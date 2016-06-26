module Style exposing (..)

import Html.Attributes exposing (class, style)


logo =
    [ ( "float", "left" )
    , ( "margin", "0 auto" )
    ]


expense =
    [ ( "font-size", "2em" )
    , ( "align-content", "center" )
    , ( "text-align", "center" )
    ]


body =
    [ ( "max-width", "600px" )
    , ( "margin", "0 auto" )
    , ( "display", "flex" )
    , ( "align-content", "flex-end" )
    , ( "flex-direction", "column" )
    ]
        ++ halfHeight


buttonHolder =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "flex-wrap", " wrap" )
    , ( "justify-content", " space-between" )
    , ( "align-content", " stretch" )
    , ( "align-items", " stretch" )
    , ( "height", "50vh" )
    ]


button =
    [ ( "flex-grow", "1" )
    , ( "min-height", "80px" )
    , ( "background-color", "lightgreen" )
    ]


flexGrow =
    [ ( "flex-grow", "1" )
    ]


flexDown =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    ]


scroll =
    [ ( "overflow", "scroll" )
    ]


halfHeight =
    [ ( "height", "100vh" )
    ]


styles lst =
    lst
        |> List.concat
        |> style
