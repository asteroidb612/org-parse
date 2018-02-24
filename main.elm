module Main exposing (main)

import Parser exposing (..)
import Org
import Html exposing (Html, div, text)
import List
import String

main : Html msg
main = let parse = run parser Org.source
       in case parse of
              Ok lines -> displayOrg lines
              Err issue -> displayIssue issue

type Piece = Heading String | OtherLine

displayIssue {row, col, source, problem, context} = let sourceLines= String.split "\n" source 
                                                    in div [] <| (text <| "Error at row " ++ (toString row) ++ " and column " ++ (toString col)) :: List.map (\x -> div [] [text x]) sourceLines

displayOrg : List Piece -> Html msg
displayOrg pieces = List.map displayPiece pieces
             |> div []

displayPiece : Piece -> Html msg
displayPiece p = case p of
                     Heading h -> div [] [text h]
                     OtherLine -> div [] []

parser : Parser (List Piece)
parser = repeat oneOrMore lines

lines : Parser Piece
lines = oneOf [ headerLine
              , tabledLine
              , succeed OtherLine |. end
              ]

headerLine : Parser Piece
headerLine = succeed Heading
           |. ignore oneOrMore (\x -> x == '*')
           |= keep oneOrMore (\x -> x /= '\n')
           |. symbol "\n"

tabledLine : Parser Piece
tabledLine = succeed OtherLine
           |. ignoreUntil "\n"
