module Main exposing (main)

import API.Users as Users
import Browser exposing (Document)
import Html
import Html.Attributes exposing (class, href, rel)
import Http
import Models.Users as Users exposing (Users)


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


type Model
    = Loading
    | Loaded Users
    | Failed


init : Flags -> ( Model, Cmd Message )
init _ =
    ( Loading, Users.get GotUsers )


type Message
    = GotUsers (Result Http.Error Users)


update : Message -> Model -> ( Model, Cmd Message )
update message _ =
    case message of
        GotUsers (Ok users) ->
            ( Loaded users, Cmd.none )

        GotUsers (Err _) ->
            ( Failed, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.none


view : Model -> Document Message
view model =
    { title = "Users"
    , body =
        [ Html.node "link" [ href "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css", rel "stylesheet" ] []
        , case model of
            Loading ->
                Html.p [] [ Html.text "Loading..." ]

            Loaded users ->
                Html.div [ class "container p-4" ]
                    [ Users.view users
                    ]

            Failed ->
                Html.p [] [ Html.text "Failed to load users..." ]
        ]
    }
