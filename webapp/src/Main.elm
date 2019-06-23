module Main exposing (Recipe, initialModel, view)

import Browser
import Html exposing (Html, button, div, form, h1, input, text)
import Html.Attributes exposing (id, type_)


type alias Recipe =
    { title : String
    , description : String
    , preparationTime : Int
    }


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


initialModel : Recipe
initialModel =
    { title = ""
    , description = ""
    , preparationTime = 0
    }


view : Recipe -> Html msg
view recipe =
    div []
        [ h1 [] [ text "Add recipe" ]
        , form []
            [ div []
                [ text "Title"
                , input
                    [ id "title"
                    , type_ "text"
                    ]
                    []
                ]
            , div []
                [ text "Description"
                , input
                    [ id "description"
                    , type_ "text"
                    ]
                    []
                ]
            , div []
                [ text "Preparation time"
                , input
                    [ id "prep-time"
                    , type_ "number"
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


update : msg -> Recipe -> Recipe
update msg model =
    initialModel
