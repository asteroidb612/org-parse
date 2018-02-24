module Main exposing (main)

import Parser exposing (..)
import Org  
import Html exposing (Html, div, text)

main = parse Org.source

parse : String -> Html msg
parse s = div [] [text s]
