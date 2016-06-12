module Style exposing (..)

import Html.Attributes exposing (class, style)


body =
    style
        [ ( "max-width", "500px" )
        , ( "margin", "0 auto" )
        ]


buttonHolder =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "right" )
        ]


button =
    style
        [ ( "height", "50px" )
        ]
