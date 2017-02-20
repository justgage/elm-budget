module View.Nav exposing (view)

import Html exposing (Html, img, div, button, text)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Style
import Types exposing (..)


view =
    div []
        [ logo
        , nav
        ]


nav : Html Action
nav =
    div []
        [ button [ onClick (RouteChange HomePage) ] [ text "Home" ]
        , button [ onClick (RouteChange CategorizationPage) ] [ text "Categorize" ]
        ]


logo : Html Action
logo =
    img [ src "/flowbudget.png", style Style.logo ] []
