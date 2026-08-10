import Lake.Util.Version
/-!
Replaces all occurrences of `$MATHLIB_CONSTANT` in `CarlesonBlueprint/Chapters/Main.lean`
by constants in `constant-list/$TOOLCHAIN.txt`, where `$TOOLCHAIN` is read from `lean-toolchain`,
or in the semver-latest list in case no list matches the current toolchain version.

Usage (from the repository root): `lean --run scripts/InsertConstants.lean`
-/

def constantListsDir : System.FilePath := "constant-lists"
def mainLean : System.FilePath := "CarlesonBlueprint/Chapters/Main.lean"
def placeholder : String := "$MATHLIB_CONSTANT"

open Lake

/-- Returns `constant-lists/$version.txt` if it exists,
otherwise the latest constant list in semver order. -/
def findConstantList (version : ToolchainVer) : IO System.FilePath := do
  let exact := constantListsDir / s!"{version}.txt"
  if ← exact.pathExists then
    return exact
  let mut best : Option (ToolchainVer × System.FilePath) := none
  for entry in ← constantListsDir.readDir do
    unless entry.fileName.endsWith ".txt" do continue
    let ver := ToolchainVer.ofString (entry.fileName.dropSuffix ".txt").toString
    if (best.map (·.1)).all (· < ver) then
      best := some (ver, entry.path)
  match best with
  | some (_, path) =>
    IO.eprintln s!"note: constant list for toolchain '{exact}' not found, falling back to latest constant list '{path}'"
    return path
  | none =>
    throw <| IO.userError s!"no constant list for toolchain '{version}' and no fallback found"

/-- Parses a constant-list line `$MOD | $NAME` into `(mod, name)`. -/
def parseListLine (line : String) : IO (String × String) :=
  match line.splitOn "|" with
  | [mod, name] => pure (mod.trimAscii.toString, name.trimAscii.toString)
  | _ => throw <| IO.userError s!"cannot parse constant-list line '{line}' (expected '$MOD | $NAME')"

def main : IO UInt32 := do
  let some version ← ToolchainVer.ofDir? "." |
    IO.eprintln "could not parse toolchain version in ./lean-toolchain"
    return 1
  let listFile ← findConstantList version
  let lines ← IO.FS.Stream.ofHandle (← IO.FS.Handle.mk listFile .read) |>.lines
  let entries ← Array.toList <$> lines.mapM parseListLine
  let mainContent ← IO.FS.readFile mainLean
  let parts := mainContent.splitOn placeholder
  let occurrences := parts.length - 1
  unless occurrences == entries.length do
    throw <| IO.userError <| s!"found {occurrences} occurrences of {placeholder} in {mainLean}, \
      but {listFile} lists {entries.length} constants" ++
      if occurrences == 0 then " (constants already inserted?)" else ""
  -- Replace the `i`-th placeholder by the `i`-th constant name.
  let mut out := parts.head!
  for ((_, name), part) in entries.zip parts.tail do
    out := out ++ name ++ part
  let imports := String.join <| entries.map fun (mod, _) => s!"import {mod}\n"
  IO.FS.writeFile mainLean (imports ++ out)
  IO.println s!"{mainLean}: inserted {entries.length} constants from {listFile}"
  return 0
