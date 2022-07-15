module Models.Sex exposing (Sex(..), decoder, toPronoun, toString)

import Json.Decode as D exposing (Decoder)
import Models.Pronoun exposing (Pronoun(..))


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


toPronoun : Sex -> Pronoun
toPronoun sex =
    case sex of
        Male ->
            He

        Female ->
            She


decoder : Decoder Sex
decoder =
    D.string
        |> D.andThen
            (\sex -> fromString sex |> D.succeed)
