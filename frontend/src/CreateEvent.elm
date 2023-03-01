module CreateEvent exposing (..)

import Html exposing(..)

type Month =
    Jan
    | Feb
    | Mar
    | Apr
    | May
    | June
    | July
    | Aug
    | Sep
    | Oct
    | Nov
    | Dec

monthAsInt : Month -> Int
monthAsInt m = case m of
    Jan -> 1
    Feb -> 2
    Mar -> 3
    Apr -> 4
    May -> 5
    June -> 6
    July -> 7
    Aug -> 8
    Sep -> 9
    Oct -> 10
    Nov -> 11
    Dec -> 12


type Date = Date {
    year: Int
    , month: Month
    , day: Int
    }

toString : Date -> String
toString (Date {year, month, day}) =
    (String.concat << List.intersperse "-") (List.map String.fromInt [year, monthAsInt month, day])

view : Maybe Date -> Maybe String -> Html msg
view date desc =
        div []
            [
            text (renderDate date)
            , text (defaultToBlank desc)
            ]

defaultToBlank : Maybe String -> String
defaultToBlank = fromNothing ""

fromNothing : String -> Maybe String -> String
fromNothing defVal maybeString = case maybeString of
    Nothing -> defVal
    Just x -> x

renderDate : Maybe Date -> String
renderDate date = case date of
    Nothing -> ""
    Just d -> toString d
