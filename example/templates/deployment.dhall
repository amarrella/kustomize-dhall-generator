-- deployment.dhall
{- 
A common pattern in dhall until version 9 is to define types and defaults records 
(with dhall 10 it will be possible to merge the two in a single import). 
In this case, types imports from dhall-kubernetes the generated dhall types for kubernetes,
and defaults some base default values (also generated) that avoid a lot of boilerplate
(most of the values in kubernetes definitions are optional, 
and dhall has explicit optional types so that would be very verbose).
-}

let types =
      https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/4ad58156b7fdbbb6da0543d8b314df899feca077/types.dhall sha256:e48e21b807dad217a6c3e631fcaf3e950062310bfb4a8bbcecc330eb7b2f60ed

let defaults =
      https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/4ad58156b7fdbbb6da0543d8b314df899feca077/defaults.dhall sha256:4450e23dc81975d111650e06c0238862944bf699537af6cbacac9c7e471dfabe

let podSpec =
          \(config : ./Config.dhall)
      ->      defaults.PodSpec
          //  { containers =
                  [     defaults.Container
                    //  { name =
                            config.name
                        , image =
                            Some "${config.image.name}:${config.image.version}"
                        , ports =
                            [     defaults.ContainerPort
                              //  { containerPort = config.containerPort }
                            ]
                        }
                  ]
              }

let podTemplate =
          \(config : ./Config.dhall)
      ->      defaults.PodTemplateSpec
          //  { metadata =
                      defaults.ObjectMeta
                  //  { name = config.name, labels = config.podLabels }
              , spec =
                  Some (podSpec config)
              }

in      \(config : ./Config.dhall)
    ->      defaults.Deployment
        //  { metadata =
                    defaults.ObjectMeta
                //  { name =
                        "${config.name}-deployment"
                    , labels =
                        config.podLabels
                    }
            , spec =
                Some
                (     defaults.DeploymentSpec
                  //  { replicas =
                          Some config.replicas
                      , selector =
                              defaults.LabelSelector
                          //  { matchLabels = config.podLabels }
                      , template =
                          podTemplate config
                      }
                )
            }
