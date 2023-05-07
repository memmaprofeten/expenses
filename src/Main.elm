module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, input)
import Html.Attributes exposing (style, placeholder, value, type_, name)
import Html.Events exposing (onClick, onInput)

main = 
        Browser.sandbox { init = init, update = update, view = view}

type ExpenseCategory
        = MatButik
        | Restaurant
        | Cafe
        | El
        | Netti
        | Hyra


type alias Model = 
        { name : String
        , category : String
        , amount : String
        , message : String
        }

init : Model
init = Model "" "" "" ""

type Msg
        = ItsJoel
        | ItsEmmi
        | Category String
        | Amount String
        | AddMessage String

update : Msg -> Model -> Model
update msg model =
        case msg of 
                ItsJoel ->
                        { model | name = "Joel" }

                ItsEmmi ->
                        { model | name = "Emmi" }

                Category newCategory ->
                        { model | category = newCategory }
                Amount newAmount ->
                        { model | amount = newAmount }
                AddMessage newMessage ->
                        { model | message = newMessage }


view : Model -> Html Msg
view model =
        div [ style "margin" "auto"
            , style "width" "50%" 
            , style "padding" "10px"
            ]
        [ div [] [ text "Who's there?" ]
        , button [ onClick ItsEmmi ] [ text "Emmi" ]
        , button [ onClick ItsJoel ] [ text "Joel" ]
        , div [] [ input [ type_ "radio", name "what", value "hep" ] [], text "Matbutik"]
        , div [] [ input [ type_ "radio", name "what", value "hep" ] [], text "Restaurant"]
        , div [] [ input [ type_ "radio", name "what", value "hep" ] [], text "Cafe"]
        , div [] [ input [ type_ "radio", name "what", value "hep" ] [], text "El"]
        , div [] [ input [ type_ "radio", name "what", value "hep" ] [], text "Netti"]
        , div [] [ input [ type_ "radio", name "what", value "hep" ] [], text "Hyra"]
        , div [] [ input [ placeholder "How much?", value model.amount, onInput Amount] []] 
        , div [] [ input [ placeholder "Something else?", value model.message, onInput AddMessage] []] 
        , div [] [ text  model.name ]
        , div [] [ text  model.category]
        , div [] [ text  model.amount]
        ]
