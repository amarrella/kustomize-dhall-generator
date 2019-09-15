-- Config.dhall
let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v10.0.0/Prelude/Map/Type sha256:210c7a9eba71efbb0f7a66b3dcf8b9d3976ffc2bc0e907aadfb6aa29c333e8ed

in  { name :
        Text
    , podLabels :
        Map Text Text
    , containerPort :
        Natural
    , image :
        { name : Text, version : Text }
    , replicas :
        Natural
    }
