module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, input)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)

main = 
        Browser.sandbox { init = init, update = update, view = view}

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
        div []
        [ div [] [ text "Who's there?" ]
        , button [ onClick ItsEmmi ] [ text "Emmi" ]
        , button [ onClick ItsJoel ] [ text "Joel" ]
        , div [] [ input  [ placeholder "Shopping where?", value model.category, onInput Category] []] 
        , div [] [ input  [ placeholder "How much?", value model.amount, onInput Amount] []] 
        , div [] [ input  [ placeholder "Something else?", value model.message, onInput AddMessage] []] 
        , div [] [ text  model.name ]
        , div [] [ text  model.category]
        , div [] [ text  model.amount]
        ]
