module API.Users exposing (get)

import Http
import Models.Users as Users exposing (Users)
import Url exposing (Protocol(..), Url)
import Url.Builder exposing (int, string)
import Utils.Url exposing (createUrl, toUrlHost, toUrlPath, withQueryParameters)


usersApiUrl : Url
usersApiUrl =
    createUrl Https (toUrlHost "randomuser.me") (toUrlPath "/api")


get : (Result Http.Error Users -> msg) -> Cmd msg
get message =
    let
        url =
            usersApiUrl
                |> withQueryParameters
                    [ int "results" 10
                    , string "nat" "gb,de"
                    , string "noinfo" ""
                    ]
                |> Url.toString
    in
    Http.get
        { url = url
        , expect = Http.expectJson message Users.decoder
        }
