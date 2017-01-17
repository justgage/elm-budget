module View exposing (view)

import Html exposing (Html)
import Types exposing (..)
import Pages.Categorization


view : Model -> Html Action
view model =
    let
        { route } =
            model
    in
        Pages.Categorization.view model
