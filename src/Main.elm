module Main exposing (..)

import QuickBudget exposing (model, update)
import View exposing (view)
import Html.App exposing (beginnerProgram)


main : Program Never
main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }
