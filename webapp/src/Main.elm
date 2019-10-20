module Main exposing (Recipe, initialModel, view)

import Browser
import Html exposing (Html, button, div, form, h1, h2, input, p, text)
import Html.Attributes exposing (class, id, type_)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as JP
import Json.Encode as Encode



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
    | CreateRecipe
    | RecipeCreated (Result Http.Error Recipe)


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
                    [ type_ "submit", onClick CreateRecipe ]
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


update : Msg -> Recipe -> ( Recipe, Cmd Msg )
update msg recipe =
    case msg of
        SaveTitle title ->
            ( { recipe | title = title }, Cmd.none )

        SaveDescription description ->
            ( { recipe | description = description }, Cmd.none )

        SavePreparationTime (Just preparationTime) ->
            ( { recipe | preparationTime = Just preparationTime }, Cmd.none )

        SavePreparationTime Nothing ->
            ( { recipe | preparationTime = Nothing }, Cmd.none )

        CreateRecipe ->
            ( recipe, createRecipe recipe )

        RecipeCreated (Ok _) ->
            ( recipe, Cmd.none )

        RecipeCreated (Err error) ->
            ( recipe, Cmd.none )


recipeDecoder : Decoder Recipe
recipeDecoder =
    Decode.succeed Recipe
        |> JP.required "title" Decode.string
        |> JP.required "description" Decode.string
        |> JP.optional "preparationTime" (Decode.map Just Decode.int) Nothing


newRecipeEncoder : Recipe -> Encode.Value
newRecipeEncoder recipe =
    Encode.object
        [ ( "title", Encode.string recipe.title )
        , ( "description", Encode.string recipe.description )
        , ( "preparationTime", Encode.int (Maybe.withDefault 0 recipe.preparationTime) )
        ]


createRecipe : Recipe -> Cmd Msg
createRecipe recipe =
    Http.post
        { url = "http://localhost:8888/api/recipe/save"
        , body = Http.jsonBody (newRecipeEncoder recipe)
        , expect = Http.expectJson RecipeCreated recipeDecoder
        }



-- MAIN


main : Program () Recipe Msg
main =
    Browser.element
        { init = \flags -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
