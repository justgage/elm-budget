module View.Pages.Categorization exposing (view)

import Html exposing (body, h3, div, button, text, Html, img, em, span, strong)
import Html.Events exposing (onClick, onMouseEnter)
import Html.Attributes exposing (class, style, src)
import Types exposing (..)
import Helpers exposing (collectExpenses, FullCategory)
import Style exposing (styles)
import Dict exposing (Dict)


{- displays in the button for -}


viewMoney : Float -> Html msg
viewMoney money =
    if money >= 0 then
        span [ style Style.money ]
            [ text "$", text <| toString <| money ]
    else
        span [ styles [ Style.money, Style.red ] ]
            [ text " - $", text <| toString <| (-money) ]


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


viewCatButton : Dict String FullCategory -> Category -> Html Action
viewCatButton cats catBudgeted =
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
                [ viewMoney left
                , t " of "
                , viewMoney catBudgeted.budgeted
                , t " left"
                ]
            ]


viewDeferButton : Html Action
viewDeferButton =
    button [ class "button", style Style.button, onClick Defer ]
        [ text "Skip" ]


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
                  -- to push things to the bottom
                , em [] [ text <| toString <| numLeft, text " left to categorize..." ]
                , viewExpense expense
                ]


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
            viewCatButton collectedCats

        catButtons =
            List.map catButton cats
    in
        div [ style Style.body ]
            [ scrollList nextExpense (List.length budget.new)
            , div [ style Style.buttonHolder ]
                (List.concat [ [ viewUndoButton, viewDeferButton ], catButtons ])
            ]
