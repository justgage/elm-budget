module Pages.NotFound exposing (view)

import Html exposing (h3, div, text)


view =
    div []
        [ h3 [] [ text "Woops! I'm not sure what page you're on!" ]
        ]
