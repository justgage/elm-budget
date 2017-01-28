module Helpers exposing (collectExpenses, FullCategory)

import Types exposing (Expense)
import Dict exposing (Dict)


type alias FullCategory =
    { amount : Float
    , expences : List Expense
    }


dictReduce : Expense -> Dict String FullCategory -> Dict String FullCategory
dictReduce expence fullCategorys =
    let
        fullCategory =
            Dict.get expence.cat fullCategorys
                |> Maybe.withDefault (FullCategory 0 [])

        amount =
            fullCategory.amount + expence.amount

        expences =
            expence :: fullCategory.expences

        updatedCat =
            { amount = amount, expences = expences }
    in
        Dict.insert expence.cat updatedCat fullCategorys


{-|
    This will collect all the expences and place them in their respective categories
-}
collectExpenses : List Expense -> Dict String FullCategory
collectExpenses expences =
    List.foldl dictReduce Dict.empty expences
