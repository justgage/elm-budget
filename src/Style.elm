module Style exposing (..)

import Html.Attributes exposing (class, style)


body =
    style
        [ ( "max-width", "600px" )
        , ( "margin", "0 auto" )
        ]


buttonHolder =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "right" )
        ]


button =
    style
        [ ( "height", "70px" )
        ]
