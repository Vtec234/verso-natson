import Lake
open Lake DSL

require Carleson from "Carleson"
require VersoBlueprint from git "https://github.com/ejgallego/verso-blueprint.git" @ "lean-v4.28.0"

package CarlesonBlueprint where
  precompileModules := false
  leanOptions := #[
    ⟨`experimental.module, true⟩,
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩,
    ⟨`maxSynthPendingDepth, .ofNat 3⟩
  ]

@[default_target]
lean_lib CarlesonBlueprint where

lean_exe «blueprint-gen» where
  root := `BlueprintMain
  supportInterpreter := true
