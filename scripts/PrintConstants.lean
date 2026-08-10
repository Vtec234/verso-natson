import Mathlib
import Lean.Elab.Command
open Lean

/-! Print the 160 theorems in mathlib with minimal hash (see rendezvous hashing). -/

/-- Backported. -/
def Lean.ConstantInfo.isTheorem_ : ConstantInfo → Bool
  | .thmInfo .. => true
  | _ => false

run_cmd do
  let env ← getEnv
  let mut consts := #[]
  for (n, ci) in env.constants do
    -- Exclude non-theorems and internal theorems.
    if !ci.isTheorem_ || n.isInternalDetail then continue
    let some imod := env.getModuleIdxFor? n | continue
    let mod := env.header.moduleNames[imod]!
    -- Exclude theorems not in mathlib.
    if mod.getRoot != `Mathlib then continue
    -- Exclude auto-generated theorems by looking for a source range.
    if (← findDeclarationRangesCore? n).isNone then continue
    consts := consts.push (n, mod)
  -- There are 160 constants in Main.lean.
  let chosen := consts.qsort (fun (a, _) (b, _) => a.hash < b.hash) |>.take 160
  for (n, mod) in chosen do
    IO.println s!"{mod} | {n}"
