module View exposing (..)

import Html exposing (h3, div, button, text, Html)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Types exposing (..)
import Helpers exposing (..)
import Dict


viewCategory : ( String, FullCategory ) -> Html msg
viewCategory ( name, cat ) =
    div []
        [ h3 [] [ text name ]
        , text ("Total: " ++ (toString cat.amount))
        ]


viewCategories : List Expense -> Html msg
viewCategories expences =
    let
        cats =
            collectExpenses expences
    in
        div []
            (List.map viewCategory (Dict.toList cats))


viewExpense : Html.Attribute msg -> Expense -> Html msg
viewExpense sty x =
    div [ class "card" ]
        [ h3 [ sty ] [ text (x.name) ]
        , div [] [ text (x.cat) ]
        , div [] [ text ("$" ++ (toString x.amount)) ]
        ]


viewExpenseNew : Expense -> Html Action
viewExpenseNew =
    viewExpense (style [ ( "color", "red" ) ])


viewExpenseOld : Expense -> Html Action
viewExpenseOld =
    viewExpense (style [ ( "color", "black" ) ])


viewCatButton : String -> Html Action
viewCatButton b =
    button [ onClick (Categorize b) ]
        [ text b ]


viewUndoButton : Html Action
viewUndoButton =
    button [ onClick Undo ]
        [ text "Undo" ]


view : Model -> Html Action
view model =
    let
        { budget, cats } =
            model
    in
        let
            viewButton =
                viewCatButton
        in
            div []
                [ -- div [] (List.map viewExpenseOld budget.old),
                  div []
                    (List.map viewExpenseNew budget.new |> List.reverse)
                , div []
                    (viewUndoButton :: List.map viewButton cats)
                , div []
                    [ (viewCategories budget.old) ]
                ]
