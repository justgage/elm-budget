module Main exposing (..)

import ElmTest exposing (..)
import Task
import ElmTest.Element exposing (..)
import Tests
import String


tests : Test
tests =
    suite "A Test Suite"
        [ test "Addition" (assertEqual (3 + 7) 10)
        , test "String.left" (assertEqual "a" (String.left 1 "abcdefg"))
        , test "This test should fail" (assert False)
        ]


main : Element
main =
    elementRunner tests
