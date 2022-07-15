module Main exposing (main)

import API.Users as Users
import Browser exposing (Document)
import Html
import Html.Attributes exposing (class, href, rel)
import Http
import Models.Users as Users exposing (Users)
import Utils.Html exposing (viewJust)


type alias Flags =
    ()


main : Program Flags Model Message
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { users : Maybe Users
    }


init : Flags -> ( Model, Cmd Message )
init _ =
    ( Model Nothing, Users.get GotUsers )


type Message
    = GotUsers (Result Http.Error Users)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        GotUsers (Ok users) ->
            ( { model | users = Just users }, Cmd.none )

        GotUsers (Err _) ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.none


view : Model -> Document Message
view model =
    { title = "Users"
    , body =
        [ Html.node "link" [ href "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css", rel "stylesheet" ] []
        , Html.div [ class "container p-4" ]
            [ viewJust (\users -> Users.view users) model.users
            ]
        ]
    }
