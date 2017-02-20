module View.Pages.NotFound exposing (view)

import Html exposing (h3, div, text)


view badPage =
    div []
        [ h3 []
            [ text "Woops! I'm not sure what page you're on!" ]
        , text ("Looks like you tried to go to " ++ badPage ++ "this doesn't seem to exist.")
        ]
