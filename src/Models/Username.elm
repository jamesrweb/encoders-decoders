module Models.Username exposing (Username(..), decoder, toString)

import Json.Decode as D exposing (Decoder)


type Username
    = Username String


fromString : String -> Username
fromString username =
    Username username


toString : Username -> String
toString (Username username) =
    username


decoder : Decoder Username
decoder =
    D.string
        |> D.andThen
            (\username -> fromString username |> withAtSymbol |> D.succeed)


withAtSymbol : Username -> Username
withAtSymbol (Username username) =
    if String.startsWith "@" username then
        fromString username

    else
        "@" ++ username |> fromString
