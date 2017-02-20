module View.View exposing (view)

import Html exposing (Html, text, div)
import Types exposing (..)
import View.Pages.Categorization as CategorizationPage
import View.Pages.Home as HomePage
import View.Pages.NotFound as NotFoundPage
import View.Nav


view : Model -> Html Action
view model =
    let
        { route } =
            model
    in
        div []
            [ View.Nav.view
            , case route of
                HomePage ->
                    HomePage.view model

                CategorizationPage ->
                    CategorizationPage.view model

                NotFoundPage badPage ->
                    NotFoundPage.view badPage
            ]
