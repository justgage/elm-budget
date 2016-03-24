module QuickBudget where

import Html exposing (h3, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)

type alias Budget =
  { old : List Expense
  , new : List Expense
  }

type alias Expense =
  { name : String
  , amount : Float
  , cat : String
  }

model : Budget
model =
  { old = []
  , new = [
       { name = "Walmart"
       , amount = 12.00
       , cat = "none"
       }
      , { name = "Winco"
        , amount = 18.00
        , cat = "none"
        }
     ]
  }

viewExpense : Expense -> Html.Html
viewExpense x =
  div [class "card"]
        [ h3  [] [text (x.name)]
        , div []         [text (toString x.amount)]
        , div []         [text (x.cat)]
        ]

view : Signal.Address Action -> Budget -> Html.Html
view address model =
  div []
        [ div [] (List.map viewExpense model.new)
        , button [ onClick address (Categorize "cat")] [ text "Home" ]
        ]


type Action = Categorize String--| NoOp

update : Action -> Budget -> Budget
update action model =
  case action of
    -- NoOp ->
    --   model

    Categorize cat ->
      let {old , new} = model in
      case new of
        [] ->
          model

        next::rest ->
          { new = rest
          , old = next :: old
          }

