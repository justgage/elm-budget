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
        , ( "flex-direction", "column" )
        , ( "flex-wrap", " wrap" )
        , ( "justify-content", " space-between" )
        , ( "align-content", " stretch" )
        , ( "align-items", " stretch" )
        , ( "height", "50vh" )
        ]


button =
    style
        [ ( "flex-grow", "1" )
        , ( "min-height", "80px" )
        , ( "background-color", "lightgreen" )
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


scroll =
    style
        [ ( "overflow", "scroll" )
        ]
