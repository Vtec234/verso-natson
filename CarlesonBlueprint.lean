import Verso
import VersoManual
import VersoBlueprint
import VersoBlueprint.Commands.Graph
import VersoBlueprint.Commands.Summary
import CarlesonBlueprint.TeXPrelude
import CarlesonBlueprint.Chapters.Introduction
import CarlesonBlueprint.Chapters.Main
import CarlesonBlueprint.Chapters.PortingStatus

open Verso.Genre
open Verso.Genre.Manual
open Informal

#doc (Manual) "Carleson Blueprint" =>

This repository contains the Verso blueprint harness for `Carleson Blueprint`.

{include 0 CarlesonBlueprint.Chapters.Introduction}
{include 0 CarlesonBlueprint.Chapters.Main}
{include 0 CarlesonBlueprint.Chapters.PortingStatus}
{blueprint_graph}
{blueprint_summary}
