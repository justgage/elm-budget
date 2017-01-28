module Pages.Home exposing (view)

import Types exposing (..)
import Html exposing (div, button, text)
import Html.Attributes exposing (class, style, src)
import Html.Events exposing (onClick)


view model =
    div []
        [ button [ onClick (RouteChange CategorizationPage) ] [ text "Categorize" ]
        ]
