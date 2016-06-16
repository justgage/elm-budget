module View exposing (view)

import Html exposing (h3, div, button, text, Html)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Types exposing (..)
import Helpers exposing (collectExpenses, FullCategory)
import Style
import Dict exposing (Dict)


viewCategory : ( String, FullCategory ) -> Html msg
viewCategory ( name, cat ) =
    div []
        [ h3 [] [ text name ]
        , text ("Total: " ++ (toString cat.amount))
        ]


viewCategories : Dict.Dict String FullCategory -> Html msg
viewCategories cats =
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


viewCatButton : Dict String FullCategory -> Maybe Expense -> Category -> Html Action
viewCatButton cats possibleDeduct catBudgeted =
    let
        left =
            catBudgeted.budgeted
                - (Dict.get catBudgeted.name cats
                    |> Maybe.withDefault (FullCategory 0 [])
                  ).amount

        tn x =
            text <| toString x

        t =
            text
    in
        button [ Style.button, onClick (Categorize catBudgeted.name) ]
            [ text catBudgeted.name
            , div []
                -- amount - possible = total
                (case possibleDeduct of
                    Nothing ->
                        [ t "$ "
                        , tn left
                        , t " of "
                        , tn catBudgeted.budgeted
                        ]

                    Just { amount } ->
                        let
                            total =
                                (left - amount)

                            overflow =
                                total < 0
                        in
                            [ tn left
                            , t " - "
                            , tn amount
                            , t "="
                            , tn total
                            , div []
                                [ t
                                    <| if overflow then
                                        "warning: overflow!"
                                       else
                                        ""
                                ]
                            ]
                )
            ]


viewUndoButton : Html Action
viewUndoButton =
    button [ Style.button, onClick Undo ]
        [ text "Undo" ]


view : Model -> Html Action
view model =
    let
        { budget, cats } =
            model

        newExpenses =
            budget.new

        nextExpense =
            List.head newExpenses

        collectedCats =
            collectExpenses budget.old

        catButton =
            viewCatButton collectedCats nextExpense
    in
        div [ Style.body ]
            [ -- div [] (List.map viewExpenseOld budget.old),
              div []
                (List.map viewExpenseNew (newExpenses |> List.reverse))
            , div [ Style.buttonHolder ]
                (viewUndoButton :: List.map catButton cats)
              -- , div []
              --     [ (viewCategories collectedCats) ]
            ]
