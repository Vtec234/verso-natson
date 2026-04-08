import Verso
import VersoManual
import VersoBlueprint

open Verso.Genre
open Verso.Genre.Manual
open Informal

#doc (Manual) "TeX To Verso Porting Status" =>

:::group "porting_status"
This chapter tracks the current fidelity state of the Verso port relative to
the TeX source.
:::

:::definition "tex_source_of_truth" (parent := "porting_status")
The direct-port TeX source of truth currently lives in
`Carleson/blueprint/src/chapter/main.tex`.
:::

:::definition "porting_status_workflow" (parent := "porting_status")
Use this page for source-backed status notes. When a source block is still
open, prefer attaching the raw TeX locally in a labeled `tex` block rather
than rewriting it into placeholder prose.
:::

:::definition "porting_status_snapshot" (parent := "porting_status")
`CarlesonBlueprint/Chapters/Main.lean` is the active direct-port chapter for
`Carleson/blueprint/src/chapter/main.tex`.
`CarlesonBlueprint/Chapters/Introduction.lean` remains harness-native.
:::
