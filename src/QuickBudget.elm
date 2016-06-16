module QuickBudget exposing (..)

import Actions as A
import Types exposing (..)


model : Model
model =
    { cats =
        [ { name = "Home"
          , budgeted = 100.0
          }
        , { name = "Groceries"
          , budgeted = 100.0
          }
        , { name = "Gages Allowance"
          , budgeted = 100.0
          }
        ]
    , budget =
        { old = []
        , new =
            [ { name = "Walmart"
              , amount = 120.0
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

        Categorize cat ->
            A.categorize cat model
