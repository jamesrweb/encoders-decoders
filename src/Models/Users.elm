module Models.Users exposing (Users, decoder, view)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Json.Decode as D exposing (Decoder)
import Models.User exposing (User)


type alias Users =
    List User


view : Users -> Html msg
view users =
    users
        |> List.map Models.User.view
        |> Html.div [ class "columns is-multiline" ]


decoder : Decoder Users
decoder =
    D.at [ "results" ] (D.list Models.User.decoder)
