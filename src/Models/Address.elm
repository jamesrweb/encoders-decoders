module Models.Address exposing (Address(..), decoder, toString)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline as P


type City
    = City String


type State
    = State String


type Country
    = Country String


type Postcode
    = Postcode String


type Address
    = Address
        { city : City
        , state : State
        , country : Country
        , postcode : Postcode
        }


fromParts : String -> String -> String -> String -> Address
fromParts city state country postcode =
    Address
        { city = City city
        , state = State state
        , country = Country country
        , postcode = Postcode postcode
        }


toString : Address -> String
toString (Address address) =
    let
        (City city) =
            address.city

        (State state) =
            address.state

        (Country country) =
            address.country

        (Postcode postcode) =
            address.postcode
    in
    String.join ", " [ city, state, country, postcode ]


decoder : Decoder Address
decoder =
    let
        toAddress : String -> String -> String -> String -> Decoder Address
        toAddress city state country postcode =
            fromParts city state country postcode |> D.succeed
    in
    D.succeed toAddress
        |> P.required "city" D.string
        |> P.required "state" D.string
        |> P.required "country" D.string
        |> P.required "postcode" postcodeDecoder
        |> P.resolve


postcodeDecoder : Decoder String
postcodeDecoder =
    D.oneOf
        [ D.string
        , D.int
            |> D.andThen
                (\postcode -> String.fromInt postcode |> D.succeed)
        ]
