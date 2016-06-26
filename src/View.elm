module View exposing (view)

import Html exposing (body, h3, div, button, text, Html, img, em, span, strong)
import Html.Events exposing (onClick, onMouseEnter)
import Html.Attributes exposing (class, style, src)
import Types exposing (..)
import Helpers exposing (collectExpenses, FullCategory)
import Style exposing (styles)
import Dict exposing (Dict)


viewMoney money =
    if money >= 0 then
        span [ style Style.money ] [ text "$", text <| toString <| (money) ]
    else
        span [ styles [ Style.money, Style.red ] ] [ text "($", text <| toString <| (money), text ")" ]


viewCategory : ( String, FullCategory ) -> Html msg
viewCategory ( name, cat ) =
    div []
        [ h3 [] [ text name ]
        , text "Total: "
        , viewMoney cat.amount
        ]


viewCategories : Dict.Dict String FullCategory -> Html msg
viewCategories cats =
    div []
        (List.map viewCategory (Dict.toList cats))


viewExpense : Expense -> Html msg
viewExpense x =
    div [ style Style.expense ]
        [ h3 [] [ text (x.name) ]
        , div [ style [ ( "font-size", "3em" ) ] ] [ viewMoney x.amount ]
        , em [] [ text "Category: ", text (x.cat) ]
        ]


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
        button [ class "button", style Style.button, onClick (Categorize catBudgeted.name) ]
            [ strong [] [ text catBudgeted.name ]
            , div []
                -- amount - possible = total
                (case possibleDeduct of
                    Nothing ->
                        [ viewMoney left
                        , t " of "
                        , viewMoney catBudgeted.budgeted
                        , t " left"
                        ]

                    Just { amount } ->
                        let
                            total =
                                (left - amount)

                            overflow =
                                total < 0
                        in
                            [ viewMoney left
                            , t " → "
                            , viewMoney total
                            ]
                )
            ]


viewDeferButton : Html Action
viewDeferButton =
    button [ class "button", style Style.button, onClick Defer ]
        [ text "Defer" ]


viewUndoButton : Html Action
viewUndoButton =
    button [ class "button", style Style.button, onClick Undo ]
        [ text "Undo" ]


scrollList maybeExpense numLeft =
    case maybeExpense of
        Nothing ->
            h3 [] [ text "All done :)" ]

        Just expense ->
            div
                [ styles
                    [ Style.flexGrow
                    , Style.flexDown
                    , Style.halfHeight
                    ]
                ]
                [ div [ style Style.flexGrow ] []
                , viewExpense expense
                , em [] [ text <| toString <| numLeft, text " left to categorize..." ]
                ]


logo : Html Action
logo =
    img [ src "/flowbudget.png", style Style.logo ] []


view : Model -> Html Action
view model =
    let
        { budget, cats } =
            model

        nextExpense =
            List.head budget.new

        collectedCats =
            collectExpenses budget.old

        catButton =
            viewCatButton collectedCats nextExpense

        catButtons =
            List.map catButton cats
    in
        div [ style Style.body ]
            [ logo
            , scrollList nextExpense (List.length budget.new)
            , div [ style Style.buttonHolder ]
                (List.concat [ [ viewUndoButton, viewDeferButton ], catButtons ])
            ]
