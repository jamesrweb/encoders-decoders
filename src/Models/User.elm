module Models.User exposing (User, decoder, view)

import Html exposing (Html)
import Html.Attributes exposing (alt, class, src, style)
import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline as P
import Models.Address as Address exposing (Address)
import Models.Age as Age exposing (Age)
import Models.Image as Image exposing (Image)
import Models.Name as Name exposing (Name)
import Models.Nationality as Nationality exposing (Nationality)
import Models.Sex as Sex exposing (Sex)
import Models.Username as Username exposing (Username)
import Url


type alias Images =
    { thumbnail : Image
    , cover : Image
    }


type User
    = User
        { address : Address
        , age : Age
        , images : Images
        , name : Name
        , nationality : Nationality
        , sex : Sex
        , username : Username
        }


view : User -> Html msg
view (User user) =
    Html.div [ class "column is-one-third-tablet is-one-quarter-widescreen" ]
        [ Html.article [ class "card", style "height" "100%" ]
            [ Html.div [ class "card-image" ]
                [ Html.figure [ class "image is-4by3" ]
                    [ Html.img
                        [ Image.toUrl user.images.cover |> Url.toString |> src
                        , alt ""
                        ]
                        []
                    ]
                ]
            , Html.div [ class "card-content" ]
                [ Html.div [ class "media" ]
                    [ Html.div [ class "media-left" ]
                        [ Html.figure [ class "image is-48x48" ]
                            [ Html.img
                                [ Image.toUrl user.images.thumbnail |> Url.toString |> src
                                , alt ""
                                , class "is-rounded"
                                ]
                                []
                            ]
                        ]
                    , Html.div [ class "media-content" ]
                        [ Html.p [ class "title is-4" ] [ Name.toString user.name |> Html.text ]
                        , Html.p [ class "subtitle is-6" ] [ Username.toString user.username |> Html.text ]
                        ]
                    ]
                , Html.div [ class "card-content p-0" ]
                    [ Html.ul []
                        [ Age.toInt user.age
                            |> String.fromInt
                            |> userOverviewListItem "Age:"
                        , user.address
                            |> Address.toString
                            |> userOverviewListItem "Address:"
                        , Nationality.toString user.nationality
                            |> userOverviewListItem "Nationality:"
                        , Sex.toString user.sex
                            |> userOverviewListItem "Sex:"
                        ]
                    ]
                ]
            ]
        ]


userOverviewListItem : String -> String -> Html msg
userOverviewListItem title content =
    Html.li [ class "mb-2" ]
        [ Html.strong [] [ Html.text title ]
        , Html.br [] []
        , Html.text content
        ]


decoder : Decoder User
decoder =
    D.succeed toUser
        |> P.required "location" Address.decoder
        |> P.requiredAt [ "dob", "age" ] Age.decoder
        |> P.requiredAt [ "picture" ] imagesDecoder
        |> P.required "name" Name.decoder
        |> P.required "nat" Nationality.decoder
        |> P.required "gender" Sex.decoder
        |> P.requiredAt [ "login", "username" ] Username.decoder


toUser : Address -> Age -> Images -> Name -> Nationality -> Sex -> Username -> User
toUser address age images name nationality sex username =
    User
        { address = address
        , age = age
        , images = images
        , name = name
        , nationality = nationality
        , sex = sex
        , username = username
        }


imagesDecoder : Decoder Images
imagesDecoder =
    D.succeed toImages
        |> P.required "large" Image.decoder
        |> P.required "thumbnail" Image.decoder


toImages : Image -> Image -> Images
toImages cover thumbnail =
    { thumbnail = thumbnail
    , cover = cover
    }
