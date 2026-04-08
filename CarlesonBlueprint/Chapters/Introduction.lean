import Verso
import VersoManual
import VersoBlueprint

open Verso.Genre
open Verso.Genre.Manual
open Informal

#doc (Manual) "Introduction" =>

This integration repository keeps the shared harness at
`tools/verso-harness`, vendors the upstream formalization at `Carleson/`, and
treats `Carleson/blueprint/src/chapter/main.tex` as the current TeX source of
truth for direct-port work.

The first source-backed LT work lives in `CarlesonBlueprint/Chapters/Main.lean`.
