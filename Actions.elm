module Actions (..) where

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
      [] ->
        model

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
