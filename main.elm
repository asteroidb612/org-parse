module Main exposing (main)

import Parser exposing (..)
import Html exposing (program, Html, div, text)
import List
import String
import Style exposing (styleSheet)
import Element exposing (row, el, html, viewport)
import Element.Attributes exposing (..)
import Element.Input exposing (multiline, Text, hiddenLabel)
import Org


type Style
    = Style


type Msg
    = OrgChanged String


type alias Model =
    String


main : Program Never String Msg
main =
    program { init = init, view = view, update = update, subscriptions = \_ -> Sub.none }


init : ( String, Cmd msg )
init = Org.source ! []


update : Msg -> Model -> ( String, Cmd msg )
update msg model =
    case msg of
        OrgChanged s ->
            s ! []


view : Model -> Html Msg
view model =
    let orgBuffer =
            Text OrgChanged model (hiddenLabel "") []
            |> multiline Style [alignLeft, width fill, height fill]
            |> \x -> [x]
            |> row Style [height fill, width (percent 50)]

    in viewport (styleSheet []) <|
        row Style
            [minHeight fill]
            [ el Style [alignRight, width (percent 50)] <| html <| result model
            , orgBuffer
            ]


result : String -> Html Msg
result source =
    let
        parse =
            run parser source
    in
        case parse of
            Ok lines ->
                displayOrg lines

            Err issue ->
                displayIssue issue


type Piece
    = Heading String
    | OtherLine


stringifyProblem : Problem -> String
stringifyProblem p =
    case p of
        BadOneOf problems ->
            String.join " && " <| List.map stringifyProblem problems

        BadInt ->
            "Bad Int"

        BadFloat ->
            "Bad Float"

        BadRepeat ->
            "Bad Repeat"

        ExpectingEnd ->
            "Expecting End"

        ExpectingSymbol s ->
            "Expecting Symbol(" ++ toString s ++ ")"

        ExpectingKeyword k ->
            "Expecting Keyword(" ++ toString k ++ ")"

        ExpectingVariable ->
            "Expecting Variable"

        ExpectingClosing c ->
            "Expecting Closing(" ++ toString c ++ ")"

        Fail f ->
            "Fail(" ++ toString f ++ ")"


displayIssue : Error -> Html msg
displayIssue { row, col, source, problem, context } =
    let
        sourceLines =
            String.split "\n" source

        body =
            List.map (\x -> div [] [ text x ]) sourceLines

        heading =
            "Error at row "
                ++ toString row
                ++ " and column "
                ++ toString col
                ++ ": "
                ++ stringifyProblem problem
                |> text
    in
        heading :: body |> div []


displayOrg : List Piece -> Html msg
displayOrg pieces =
    List.map displayPiece pieces
        |> div []


displayPiece : Piece -> Html msg
displayPiece p =
    case p of
        Heading h ->
            div [] [ text h ]

        OtherLine ->
            div [] []


parser : Parser (List Piece)
parser =
    repeat oneOrMore lines


lines : Parser Piece
lines =
    oneOf
        [ headerLine
        , tabledLine
        , succeed OtherLine
            |. ignore zeroOrMore (\x -> True)
            |. end
        ]


headerLine : Parser Piece
headerLine =
    succeed Heading
        |. ignore oneOrMore (\x -> x == '*')
        |= keep oneOrMore (\x -> x /= '\n')
        |. symbol "\n"


tabledLine : Parser Piece
tabledLine =
    succeed OtherLine
        |. ignoreUntil "\n"
