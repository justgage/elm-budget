module Style exposing (..)

import Html.Attributes exposing (class, style)


body =
    style
        [ ( "max-width", "600px" )
        , ( "margin", "0 auto" )
        , ( "display", "flex" )
        , ( "align-content", "flex-end" )
        , ( "height", "100vh" )
        , ( "flex-direction", "column" )
        ]


buttonHolder =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "right" )
        ]


button =
    style
        [ ( "height", "70px" )
        , ( "flex-grow", "1" )
        ]


flexGrow =
    style
        [ ( "flex-grow", "1" )
        ]


flexDown =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "column" )
        ]
