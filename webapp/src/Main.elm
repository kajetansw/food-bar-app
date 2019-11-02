module Main exposing (main)

import Browser
import Page.AddRecipe as AddRecipe
import Recipe exposing (..)



--viewRecipe : Recipe -> Html Msg
--viewRecipe recipe =
--    div [ class "recipe-card" ]
--        [ h2 [] [ text recipe.title ]
--        , p [] [ text recipe.description ]
--        , p [] [ text ("Preparation time: " ++ getPreparationTime recipe) ]
--        ]
-- MAIN


main : Program () Recipe AddRecipe.Msg
main =
    Browser.element
        { init = \flags -> ( AddRecipe.initialModel, Cmd.none )
        , view = AddRecipe.view
        , update = AddRecipe.update
        , subscriptions = \_ -> Sub.none
        }
