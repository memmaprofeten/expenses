module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, input)
import Html.Attributes exposing (style, placeholder, value, type_, name)
import Html.Events exposing (onClick, onInput)
import Date
import Task

main =
        Browser.element
                { init = init
                , update = update
                , view = view
                , subscriptions = always Sub.none
                }

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
        , date : Date.Date
        }


init : () -> (Model, Cmd Msg)
init _ =
        (Model "" "" "" "" (Date.fromOrdinalDate 0 0)
        , Date.today |> Task.perform ReceiveDate
        )

type Msg
        = ItsJoel
        | ItsEmmi
        | Category String
        | Amount String
        | AddMessage String
        | Date String
        | ReceiveDate Date.Date
        | Submit

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
        case msg of
                ItsJoel -> (
                        { model | name = "Joel" }
                        , Cmd.none )
                ItsEmmi -> (
                        { model | name = "Emmi" }
                        , Cmd.none )

                Category newCategory ->
                        (
                                { model | category = newCategory }
                                , Cmd.none
                        )
                Amount newAmount ->
                        (
                                { model | amount = newAmount }
                                , Cmd.none
                        )
                AddMessage newMessage ->
                        (
                                { model | message = newMessage }
                                , Cmd.none
                        )
                Date date ->
                        (
                                { model | date = case Date.fromIsoString date of
                                        Ok choosen_date -> choosen_date
                                        Err _ -> (Date.fromOrdinalDate 0 0)}
                                , Cmd.none
                        )
                ReceiveDate today ->
                        (
                                {model | date = today}
                                , Cmd.none
                        )
                Submit -> (model, Cmd.none)


view : Model -> Html Msg
view model =
        div [ style "margin" "auto"
            , style "width" "50%"
            , style "padding" "10px"
            ]
        [ div [] [ text "Who's there?" ]
        , button [ onClick ItsEmmi ] [ text "Emmi" ]
        , button [ onClick ItsJoel ] [ text "Joel" ]
        , div [] [ input [ type_ "radio", name "what", value "matbutik", onInput Category] [], text "Matbutik"]
        , div [] [ input [ type_ "radio", name "what", value "restaurant" , onInput Category] [], text "Restaurant"]
        , div [] [ input [ type_ "radio", name "what", value "cafe" , onInput Category] [], text "Cafe"]
        , div [] [ input [ type_ "radio", name "what", value "el" , onInput Category] [], text "El"]
        , div [] [ input [ type_ "radio", name "what", value "netti" , onInput Category] [], text "Netti"]
        , div [] [ input [ type_ "radio", name "what", value "hyra" , onInput Category] [], text "Hyra"]
        , div [] [ input [ placeholder "How much?", value model.amount, onInput Amount] []]
        , div [] [ input [ type_ "date", value (Date.toIsoString model.date), onInput Date] []]
        , div [] [ input [ placeholder "Something else?", value model.message, onInput AddMessage] []]
        , button [ onClick Submit ] [ text "Submit" ]
        , div [] [ text  model.name ]
        , div [] [ text  model.category]
        , div [] [ text  model.amount]
        , div [] [ text  (Date.toIsoString model.date) ]
        , div [] [ text  model.message]
        ]
