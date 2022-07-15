module Models.Age exposing (Age(..), decoder, toInt)

import Json.Decode as D exposing (Decoder)


type Age
    = Age Int


fromInt : Int -> Age
fromInt age =
    Age age


toInt : Age -> Int
toInt (Age age) =
    age


decoder : Decoder Age
decoder =
    D.int |> D.andThen (\age -> fromInt age |> D.succeed)
