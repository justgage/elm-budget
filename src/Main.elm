module Main (..) where

import QuickBudget exposing (model, update)
import View exposing (view)
import StartApp.Simple exposing (start)
import Html exposing (Html)


main : Signal Html.Html
main =
  start
    { model = model
    , update = update
    , view = view
    }
