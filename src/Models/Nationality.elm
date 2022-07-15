module Models.Nationality exposing (Nationality(..), decoder, toString)

import Json.Decode as D exposing (Decoder)


type Nationality
    = GB
    | DE


fromString : String -> Nationality
fromString nationality =
    if String.toLower nationality == "gb" then
        GB

    else
        DE


toString : Nationality -> String
toString nationality =
    case nationality of
        GB ->
            "British"

        DE ->
            "German"


decoder : Decoder Nationality
decoder =
    D.string
        |> D.andThen
            (\nationality -> fromString nationality |> D.succeed)
