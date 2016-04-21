module View (view) where

import Html exposing (h3, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Types exposing (..)
import Dict


-- import List.Extra as ListEx


groupReducer group x =
  Dict.update
    x.cat
    (\entry ->
      case entry of
        Nothing ->
          Just x.amount

        Just subTotal ->
          Just (x.amount + subTotal)
    )



-- colletCategories : List Expense -> Dict.Dict


colletCategories expenses =
  Dict.foldl groupReducer expenses {}


viewCategory : String -> Float -> Html.Html
viewCategory name total =
  div
    []
    [ h3 [] [ text name ]
    , text ("Total: " ++ (toString total))
    ]


viewExpense : Html.Attribute -> Expense -> Html.Html
viewExpense sty x =
  div
    [ class "card" ]
    [ h3 [ sty ] [ text (x.name) ]
    , div [] [ text (toString x.amount) ]
    , div [] [ text (x.cat) ]
    ]


viewExpenseNew : Expense -> Html.Html
viewExpenseNew =
  viewExpense (style [ ( "color", "red" ) ])


viewExpenseOld : Expense -> Html.Html
viewExpenseOld =
  viewExpense (style [ ( "color", "black" ) ])


viewCatButton : Signal.Address Action -> String -> Html.Html
viewCatButton address b =
  button
    [ onClick address (Categorize b) ]
    [ text b ]


viewUndoButton : Signal.Address Action -> Html.Html
viewUndoButton address =
  button
    [ onClick address Undo ]
    [ text "Undo" ]


view : Signal.Address Action -> Model -> Html.Html
view address model =
  let
    { budget, cats } =
      model
  in
    let
      viewButton =
        viewCatButton address
    in
      div
        []
        [ div
            []
            [ colletCategories budget.old
                |> toString
                |> text
            ]
        , div
            []
            (text <| toString viewExpenseOld budget.old)
        , div
            []
            (List.map viewExpenseNew budget.new |> List.reverse)
        , div
            []
            (viewUndoButton address :: List.map viewButton cats)
        ]
