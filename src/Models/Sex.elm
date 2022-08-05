module Models.Sex exposing (Sex(..), decoder, toString)

import Json.Decode as D exposing (Decoder)


type Sex
    = Male
    | Female


toString : Sex -> String
toString sex =
    case sex of
        Male ->
            "Male"

        Female ->
            "Female"


fromString : String -> Sex
fromString sex =
    if String.toLower sex == "male" then
        Male

    else
        Female


decoder : Decoder Sex
decoder =
    D.string
        |> D.andThen
            (\sex -> fromString sex |> D.succeed)
