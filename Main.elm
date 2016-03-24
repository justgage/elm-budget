module Main where
--import Counter exposing (update, view)
import QuickBudget exposing (model, update, view)
import StartApp.Simple exposing (start)
import Html exposing (Html)


main : Signal Html.Html
main =
  start
  { model = model
  , update = update
  , view = view
  }
