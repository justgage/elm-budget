module View exposing (view)

import Html exposing (body, h3, div, button, text, Html, img)
import Html.Events exposing (onClick, onMouseEnter)
import Html.Attributes exposing (class, style, src)
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
    viewExpense (style [])


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
        button [ class "button", Style.button, onClick (Categorize catBudgeted.name) ]
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
    div [ class "button", Style.button, onClick Undo ]
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
        body []
            [ div []
                [ img [ src "/flowbudget.png", style [ ( "margin", "0 auto" ) ] ] []
                , div [ Style.body ]
                    [ div [ Style.flexGrow, Style.flexDown, Style.scroll ]
                        ((div [ Style.flexGrow ] [])
                            :: (List.map viewExpenseNew (newExpenses |> List.reverse))
                        )
                    , div [ Style.buttonHolder ]
                        (viewUndoButton :: List.map catButton cats)
                    ]
                ]
            ]
