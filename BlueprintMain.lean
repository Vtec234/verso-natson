import VersoManual
import VersoBlueprint.PreviewManifest
import CarlesonBlueprint

open Verso Doc
open Verso.Genre Manual

set_option verso.blueprint.numbering "sub"
set_option verso.blueprint.subNumberingPrefix "full"
set_option verso.blueprint.subNumberingCounter "prefix"

def main (args : List String) : IO UInt32 :=
  Informal.PreviewManifest.blueprintMainWithPreviewData
    (%doc CarlesonBlueprint)
    args
    (extensionImpls := by exact extension_impls%)
    (config := { rootTocDepth := none })
