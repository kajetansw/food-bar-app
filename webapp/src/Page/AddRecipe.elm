module Page.AddRecipe exposing (Msg, init, initialModel, update, view)

import Html exposing (Html, button, div, form, h1, input, text)
import Html.Attributes exposing (id, type_)
import Html.Events exposing (onClick, onInput)
import Http
import Recipe exposing (..)



-- MODEL


type alias Model =
    Recipe


type Msg
    = SaveTitle String
    | SaveDescription String
    | SavePreparationTime (Maybe Int)
    | CreateRecipe
    | RecipeCreated (Result Http.Error Recipe)


initialModel : Model
initialModel =
    { title = ""
    , description = ""
    , preparationTime = Just 0
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- VIEW


view : Model -> Html Msg
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



-- UPDATE


update : Msg -> Recipe -> ( Model, Cmd Msg )
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


createRecipe : Recipe -> Cmd Msg
createRecipe recipe =
    Http.post
        { url = "http://localhost:8888/api/recipe/save"
        , body = Http.jsonBody (newRecipeEncoder recipe)
        , expect = Http.expectJson RecipeCreated recipeDecoder
        }
