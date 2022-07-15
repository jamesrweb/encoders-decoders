module Models.Image exposing (Image(..), decoder, toUrl)

import Json.Decode as D exposing (Decoder)
import Url exposing (Protocol(..), Url)
import Utils.Url exposing (createUrl, toUrlHost, toUrlPath)


type Image
    = Image Url


fromUrl : Url -> Image
fromUrl url =
    Image url


toUrl : Image -> Url
toUrl (Image image) =
    image


decoder : Decoder Image
decoder =
    let
        fallbackImage =
            createUrl
                Https
                (toUrlHost "picsum.photos")
                (toUrlPath "/seed/picsum/200/300")
    in
    D.string
        |> D.andThen
            (\url ->
                Url.fromString url
                    |> Maybe.withDefault fallbackImage
                    |> fromUrl
                    |> D.succeed
            )
