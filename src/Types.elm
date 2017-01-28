module Types exposing (..)


type alias Budget =
    { old : List Expense
    , new : List Expense
    }


type alias Category =
    { name : String
    , budgeted : Float
    }


type alias Categories =
    List Category


type alias Expense =
    { name : String
    , amount : Float
    , cat : String
    }


type Route
    = HomePage
    | CategorizationPage
    | NotFoundPage String


type alias Model =
    { budget : Budget
    , cats : Categories
    , route : Route
    }


type Action
    = Categorize String
    | Undo
    | NoOp
    | Defer
    | RouteChange Route
