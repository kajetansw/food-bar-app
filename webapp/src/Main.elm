module Main exposing (Recipe, initialModel, view)

import Browser
import Html exposing (Html, button, div, form, h1, h2, input, p, text)
import Html.Attributes exposing (class, id, type_)
import Html.Events exposing (onClick, onInput)



-- MODEL


type alias Recipe =
    { title : String
    , description : String
    , preparationTime : Maybe Int
    }


type alias Model =
    ( List Recipe, Recipe )


type Msg
    = SaveTitle String
    | SaveDescription String
    | SavePreparationTime (Maybe Int)


initialModel : Recipe
initialModel =
    { title = ""
    , description = ""
    , preparationTime = Just 0
    }



-- VIEW


view : Recipe -> Html Msg
view recipe =
    div []
        [ h1 [] [ text "Add recipe" ]
        , form []
            [ div []
                [ text "Title"
                , input
                    [ id "title"
                    , type_ "text"
                    , onInput SaveTitle
                    ]
                    []
                ]
            , div []
                [ text "Description"
                , input
                    [ id "description"
                    , type_ "text"
                    , onInput SaveDescription
                    ]
                    []
                ]
            , div []
                [ text "Preparation time"
                , input
                    [ id "prep-time"
                    , type_ "number"
                    , onInput (String.toInt >> SavePreparationTime)
                    ]
                    []
                ]
            , div []
                [ button
                    [ type_ "submit" ]
                    [ text "Create recipe" ]
                ]
            ]
        ]


viewRecipe : Recipe -> Html Msg
viewRecipe recipe =
    div [ class "recipe-card" ]
        [ h2 [] [ text recipe.title ]
        , p [] [ text recipe.description ]
        , p [] [ text ("Preparation time: " ++ getPreparationTime recipe) ]
        ]


getPreparationTime : Recipe -> String
getPreparationTime recipe =
    let
        prepTime =
            Maybe.withDefault 0 recipe.preparationTime
    in
    if prepTime >= 0 then
        String.fromInt prepTime

    else
        "Unknown"



-- UPDATE


update : Msg -> Recipe -> Recipe
update msg recipe =
    case msg of
        SaveTitle title ->
            { recipe | title = title }

        SaveDescription description ->
            { recipe | description = description }

        SavePreparationTime (Just preparationTime) ->
            { recipe | preparationTime = Just preparationTime }

        SavePreparationTime Nothing ->
            { recipe | preparationTime = Nothing }



-- MAIN


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
