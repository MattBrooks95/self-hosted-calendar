module App exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing(
    onClick
    )
import Url

import CreateEvent exposing(..)

main : Program () Model Msg
main = Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }

type alias Model =
    { key: Nav.Key
    , url: Url.Url
    , active: Bool
    }

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
    (Model key url False, Cmd.none)

type Msg = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | Toggle

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    (model, Nav.pushUrl model.key (Url.toString url))
                Browser.External href ->
                    (model, Nav.load href)
        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )
        Toggle -> ({model | active= not model.active}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

dummyDate: Date
dummyDate = (Date { year=2023, month=Feb, day=23})

view : Model -> Browser.Document Msg
view model = {
    title = "Url example"
    , body =
        [ text "the current url is:"
        , b [] [ text (Url.toString model.url) ]
        , ul []
            [ viewLink "/"
            , viewLink "/addevent"
            ]
        , CreateEvent.view (Just dummyDate) (Just "dummy view")
        , text (if model.active then "active" else "not active")
        --, button [onClick (update Toggle model)] [text "click me"]
        , button [onClick Toggle] [text "click me"]
        ]
    }

viewLink : String -> Html msg
viewLink path = li [] [ a [ href path ] [ text path ] ]
