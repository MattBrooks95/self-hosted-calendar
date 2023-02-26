module App exposing (main)

import Html exposing (..)
import Html.Attributes exposing(..)

view model =
    div []
        [ p []
            [ text "Hello, World!"
            ]
        ]

main = 
    view "dummy model"
