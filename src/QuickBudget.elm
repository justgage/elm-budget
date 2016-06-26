module QuickBudget exposing (..)

import Actions as A
import Types exposing (..)


model : Model
model =
    { cats =
        [ { name = "Medical"
          , budgeted = 100.0
          }
        , { name = "Darvil"
          , budgeted = 100.0
          }
        , { name = "Gas"
          , budgeted = 100.0
          }
        , { name = "Jessicas's Allowance"
          , budgeted = 100.0
          }
        , { name = "Gage's Allowance"
          , budgeted = 100.0
          }
        , { name = "Home"
          , budgeted = 100.0
          }
        , { name = "Groceries"
          , budgeted = 500.0
          }
        , { name = "Gages Allowance"
          , budgeted = 25.0
          }
        ]
    , budget =
        { old = []
        , new =
            [ { name = "Walmart"
              , amount = 120.0
              , cat = "none"
              }
            , { name = "Zelda"
              , amount = 8.0
              , cat = "none"
              }
            , { name = "Disney Land"
              , amount = 20000.0
              , cat = "none"
              }
            , { name = "Petco"
              , amount = 8.0
              , cat = "none"
              }
            , { name = "Petco"
              , amount = 8.0
              , cat = "none"
              }
            , { name = "Winco"
              , amount = 180.0
              , cat = "none"
              }
            , { name = "Zurkers"
              , amount = 8.0
              , cat = "none"
              }
            , { name = "Humble Bundle"
              , amount = 1.0
              , cat = "none"
              }
            ]
        }
    }


update : Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            A.noOp model

        Undo ->
            A.undo model

        Hightlight id ->
            A.hightlight id model

        Categorize cat ->
            A.categorize cat model
