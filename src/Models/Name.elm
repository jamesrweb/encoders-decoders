module Models.Name exposing (Name(..), decoder, toString)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline as P


type Name
    = Name
        { title : String
        , first : String
        , last : String
        }


fromParts : String -> String -> String -> Name
fromParts title first last =
    Name
        { title = title
        , first = first
        , last = last
        }


toString : Name -> String
toString (Name name) =
    String.join " " [ name.title, name.first, name.last ]


decoder : Decoder Name
decoder =
    let
        toName : String -> String -> String -> Decoder Name
        toName title first last =
            fromParts title first last |> D.succeed
    in
    D.succeed toName
        |> P.required "title" D.string
        |> P.required "first" D.string
        |> P.required "last" D.string
        |> P.resolve
