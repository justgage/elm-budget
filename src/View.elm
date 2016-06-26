module View exposing (view)

import Html exposing (body, h3, div, button, text, Html, img, em)
import Html.Events exposing (onClick, onMouseEnter)
import Html.Attributes exposing (class, style, src)
import Types exposing (..)
import Helpers exposing (collectExpenses, FullCategory)
import Style exposing (styles)
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


viewExpense : Expense -> Html msg
viewExpense x =
    div [ style Style.expense ]
        [ h3 [] [ text (x.name) ]
        , div [] [ text "Category: ", text (x.cat) ]
        , div [] [ text ("Amount: $" ++ (toString x.amount)) ]
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
                            , t " → "
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
    div [ class "button", style Style.button, onClick Undo ]
        [ text "Undo" ]


scrollList maybeExpense =
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
                [ (div [ style Style.flexGrow ] [])
                , (viewExpense expense)
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
            , scrollList nextExpense
            , div [ style Style.buttonHolder ]
                (viewUndoButton :: catButtons)
            ]
