module Types exposing (..)


type alias Budget =
    { old : List Expense
    , new : List Expense
    }


type alias Categories =
    List String


type alias Expense =
    { name : String
    , amount : Float
    , cat : String
    }


type alias Model =
    { budget : Budget
    , cats : Categories
    }


type Action
    = Categorize String
    | Undo
    | NoOp
