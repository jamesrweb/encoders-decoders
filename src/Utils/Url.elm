module Utils.Url exposing (createUrl, toUrlHost, toUrlPath, withQueryParameters)

import Url exposing (Protocol, Url)
import Url.Builder exposing (QueryParameter, toQuery)


type Host
    = Host String


type Path
    = Path String


toUrlHost : String -> Host
toUrlHost host =
    Host host


toUrlPath : String -> Path
toUrlPath path =
    if String.startsWith "/" path then
        Path path

    else
        "/" ++ path |> Path


createUrl : Protocol -> Host -> Path -> Url
createUrl protocol (Host host) (Path path) =
    { protocol = protocol
    , host = host
    , port_ = Nothing
    , path = path
    , query = Nothing
    , fragment = Nothing
    }


withQueryParameters : List QueryParameter -> Url -> Url
withQueryParameters queryParameters url =
    { url | query = toQuery queryParameters |> String.dropLeft 1 |> Just }
