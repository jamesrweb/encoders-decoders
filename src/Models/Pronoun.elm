module Models.Pronoun exposing (Pronoun(..), toPronouns)


type Pronoun
    = He
    | She


toPronouns : Pronoun -> String
toPronouns pronoun =
    case pronoun of
        He ->
            "He / Him"

        She ->
            "She / Her"
