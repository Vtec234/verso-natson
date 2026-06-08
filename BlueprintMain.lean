import VersoManual
import VersoBlueprint.PreviewManifest
import CarlesonBlueprint

open Verso Doc
open Verso.Genre Manual

def main (args : List String) : IO UInt32 :=
  Informal.PreviewManifest.manualMainWithPreviewData
    (%doc CarlesonBlueprint)
    args
    (extensionImpls := by exact extension_impls%)
    (config := { rootTocDepth := none })
