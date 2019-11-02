module Route exposing (Route(..), matchRoute, parseUrl)

import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = NotFound
    | AddRecipe


parseUrl : Url -> Route
parseUrl url =
    case parse matchRoute url of
        Just route ->
            route

        Nothing ->
            NotFound


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map AddRecipe top
        , map AddRecipe (s "add-recipe")
        ]
