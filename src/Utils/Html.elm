module Utils.Html exposing (viewJust)

import Html exposing (Html)


empty : Html msg
empty =
    Html.text ""


viewJust : (a -> Html msg) -> Maybe a -> Html msg
viewJust fn maybe =
    Maybe.map (\a -> fn a) maybe |> Maybe.withDefault empty
