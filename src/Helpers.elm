module Helpers exposing (..)

import Types exposing (Expense)
import Dict exposing (Dict)


type alias FullCategory =
    { amount : Float
    , expences : List Expense
    }


dictReduce : Expense -> Dict String FullCategory -> Dict String FullCategory
dictReduce expence fcats =
    let
        fcat =
            Dict.get expence.cat fcats
                |> Maybe.withDefault (FullCategory 0 [])

        amount =
            fcat.amount + expence.amount

        expences =
            expence :: fcat.expences

        updatedCat =
            { amount = amount, expences = expences }
    in
        Dict.insert expence.cat updatedCat fcats


{-|
    This will collect all the expences and place them in their respective categories
-}
collectExpenses : List Expense -> Dict String FullCategory
collectExpenses expences =
    List.foldl dictReduce Dict.empty expences
