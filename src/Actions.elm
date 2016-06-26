module Actions exposing (..)

import Types exposing (..)


update : Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            noOp model

        Undo ->
            undo model

        Categorize cat ->
            categorize cat model

        Defer ->
            defer model


defer : Model -> Model
defer model =
    categorize "flaged" model


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



-- do nothing


noOp : Model -> Model
noOp =
    identity



-- undo last categorize (category is still there)


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
