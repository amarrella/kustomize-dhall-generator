let appName = "nginx"

let config =
      { name =
          appName
      , podLabels =
          toMap { app = appName }
      , containerPort =
          80
      , image =
          { name = "nginx", version = "latest" }
      , replicas =
          3
      }

in  ../templates/makeApp.dhall config
