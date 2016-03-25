module QuickBudget where

import Html exposing (h3, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)

type alias Budget =
  { old : List Expense
  , new : List Expense
  }

type alias Categories = List String

type alias Expense =
  { name : String
  , amount : Float
  , cat : String
  }

type alias Model =
  { budget : Budget
  , cats : Categories
  }

model : Model
model =
  {
    cats = [ "Home"
           , "Groceries"
           , "Gages Allowance"
           ]
  , budget =
      { old = []
      , new =
          [ { name = "Walmart"
            , amount = 120.00
            , cat = "none"
            }
          , { name = "Petco"
            , amount = 8.00
            , cat = "none"
            }
          , { name = "Winco"
            , amount = 180.00
            , cat = "none"
            }
          , { name = "Zurkers"
            , amount = 8.00
            , cat = "none"
            }
          , { name = "Humble Bundle"
            , amount = 1.00
            , cat = "none"
            }
          ]
      }
  }

viewCategory : String -> Float -> Html.Html
viewCategory name total =
  div [] [h3 [] [text name]
         , text ("Total: " ++ (toString total))
         ]

viewExpense : Html.Attribute -> Expense -> Html.Html
viewExpense sty x =
  div [class "card"]
        [ h3  [sty] [text (x.name)]
        , div []         [text (toString x.amount)]
        , div []         [text (x.cat)]
        ]


viewExpenseNew : Expense -> Html.Html
viewExpenseNew = viewExpense ( style [("color", "red")] )
                 
viewExpenseOld : Expense -> Html.Html
viewExpenseOld = viewExpense ( style [("color", "black")] )

viewCatButton address b =
  button
    [ onClick address (Categorize b)]
    [ text b ]

viewUndoButton address =
  button
    [ onClick address Undo]
    [ text "Undo" ]


view : Signal.Address Action -> Model -> Html.Html
view address model =
  let {budget, cats} = model in
  let viewButton = viewCatButton address in
  div []
        [ div
            [] (List.map viewExpenseOld budget.old)
        , div
          [] (List.map viewExpenseNew budget.new |> List.reverse)
        , div
            [] (viewUndoButton address :: List.map viewButton cats)
        ]


type Action = Categorize String
            | Undo
            | NoOp

update : Action -> Model -> Model
update action model =
  let _ = Debug.watch "action" action in
  let _ = Debug.watch "model." (toString model) in
  case action of
    NoOp ->
      model

    Undo ->
      let {budget} = model in
      let {old , new} = budget in
      case old of
        [] ->
          model

        last :: old_rest ->
          { model |
              budget =
              { new = last :: new
              , old = old_rest
              }
          }

    Categorize cat ->
      let {budget} = model in
      let {old , new} = budget in
      case new of
        [] ->
          model

        next::rest ->
          let next_cat = {next | cat = cat} in

          { model |
              budget =
              { new = rest
              , old = next_cat :: old
              }
          }
