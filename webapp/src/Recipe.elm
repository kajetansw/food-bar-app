module Recipe exposing (Recipe, getPreparationTime, newRecipeEncoder, recipeDecoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as JP
import Json.Encode as Encode


type alias Recipe =
    { title : String
    , description : String
    , preparationTime : Maybe Int
    }


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
