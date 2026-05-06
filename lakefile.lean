import Lake
open Lake DSL

require VersoBlueprint from git "https://github.com/leanprover/verso-blueprint.git" @ "v4.30.0"
require Carleson from "Carleson"

package CarlesonBlueprint where
  precompileModules := false
  leanOptions := #[
    ⟨`experimental.module, true⟩,
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩,
    ⟨`maxSynthPendingDepth, .ofNat 3⟩,
    ⟨`verso.blueprint.math.lint, true⟩,
    ⟨`verso.blueprint.externalCode.strictResolve, true⟩,
    ⟨`verso.code.warnLineLength, .ofNat 0⟩
  ]

@[default_target]
lean_lib CarlesonBlueprint where

lean_exe «blueprint-gen» where
  root := `BlueprintMain
  supportInterpreter := true
