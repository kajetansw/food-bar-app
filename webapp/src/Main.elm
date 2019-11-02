module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Html exposing (Html, h3, text)
import Page.AddRecipe as AddRecipe
import Recipe exposing (..)
import Route exposing (Route)
import Url exposing (Url)



--viewRecipe : Recipe -> Html Msg
--viewRecipe recipe =
--    div [ class "recipe-card" ]
--        [ h2 [] [ text recipe.title ]
--        , p [] [ text recipe.description ]
--        , p [] [ text ("Preparation time: " ++ getPreparationTime recipe) ]
--        ]
-- MODEL


type Msg
    = AddRecipePageMsg AddRecipe.Msg
    | LinkClicked UrlRequest
    | UrlChanged Url


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }



-- ROUTING


type alias Model =
    { route : Route
    , page : Page
    , navKey : Nav.Key
    }


type Page
    = NotFoundPage
    | AddRecipePage Recipe



-- INIT


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        model =
            { route = Route.parseUrl url
            , page = NotFoundPage
            , navKey = navKey
            }
    in
    initCurrentPage ( model, Cmd.none )


initCurrentPage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
initCurrentPage ( model, existingCmds ) =
    let
        ( currentPage, mappedPageCmds ) =
            case model.route of
                Route.NotFound ->
                    ( NotFoundPage, Cmd.none )

                Route.AddRecipe ->
                    let
                        ( pageModel, pageCmds ) =
                            AddRecipe.init
                    in
                    ( AddRecipePage pageModel, Cmd.map AddRecipePageMsg pageCmds )
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Food Bar App"
    , body = [ currentView model ]
    }


currentView : Model -> Html Msg
currentView model =
    case model.page of
        NotFoundPage ->
            notFoundView

        AddRecipePage pageModel ->
            AddRecipe.view pageModel
                |> Html.map AddRecipePageMsg


notFoundView : Html msg
notFoundView =
    h3 [] [ text "Page not found!" ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( AddRecipePageMsg subMsg, AddRecipePage pageModel ) ->
            let
                ( updatedPageModel, updatedCmd ) =
                    AddRecipe.update subMsg pageModel
            in
            ( { model | page = AddRecipePage updatedPageModel }
            , Cmd.map AddRecipePageMsg updatedCmd
            )

        ( LinkClicked urlRequest, _ ) ->
            ( model, Cmd.none )

        ( UrlChanged url, _ ) ->
            let
                newRoute =
                    Route.parseUrl url
            in
            ( { model | route = newRoute }, Cmd.none )
                |> initCurrentPage

        ( _, _ ) ->
            ( model, Cmd.none )



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }
