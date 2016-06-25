module Actions exposing (..)

import Types exposing (..)


categorize : String -> Model -> Model
categorize cat model =
    let
        { budget } =
            model

        { old, new } =
            budget
    in
        case new of
            -- there's no more to categorize
            [] ->
                model

            -- there is more to categorize
            next :: rest ->
                let
                    next_cat =
                        { next | cat = cat }
                in
                    { model
                        | budget =
                            { new = rest
                            , old = next_cat :: old
                            }
                    }


hightlight : Int -> Model -> Model
hightlight id model =
    model



-- do nothing


noOp : Model -> Model
noOp =
    identity


undo : Model -> Model
undo model =
    let
        { budget } =
            model

        { old, new } =
            budget
    in
        case old of
            [] ->
                model

            last :: old_rest ->
                { model
                    | budget =
                        { new = last :: new
                        , old = old_rest
                        }
                }
