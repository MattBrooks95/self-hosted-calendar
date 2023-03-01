module InputExample exposing (..)

import Html exposing(..)

import Html.Attributes exposing (..)
import Html.Events exposing (
    onClick
    , onInput
    )

type alias Model = {
    input: String
    }

type Msg = InputChanged String
    | Submit

update : Model -> Msg -> Model
update model msg = case msg of
    InputChanged newVal -> {model | input=newVal}
    Submit -> model

view : Model -> Html Msg
view model =
    div []
        [input [ placeholder "type something", value model.input, onInput InputChanged ] []
        -- TODO find a way to send the message to the parent
        -- continue following along with this example https://sporto.github.io/elm-patterns/architecture/translator.html
        , button [onClick Submit] [text "notify parent of message"]
        ]

