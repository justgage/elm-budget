module Main exposing (..)

import QuickBudget exposing (model)
import Actions exposing (update)
import View exposing (view)
import Html exposing (beginnerProgram)


main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }
