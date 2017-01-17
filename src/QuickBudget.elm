module QuickBudget exposing (..)

import Types exposing (..)


model : Model
model =
    { cats =
        [ { name = "Medical"
          , budgeted = 100.0
          }
        , { name = "Gas"
          , budgeted = 100.0
          }
        , { name = "Jessicas"
          , budgeted = 100.0
          }
        , { name = "Gage"
          , budgeted = 25.0
          }
        , { name = "Darvil"
          , budgeted = 100.0
          }
        , { name = "Home"
          , budgeted = 100.0
          }
        , { name = "Groceries"
          , budgeted = 500.0
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
    , route = "home"
    }
