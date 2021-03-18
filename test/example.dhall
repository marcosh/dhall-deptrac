let Deptrac = ../src/deptrac.dhall
let DeptracNamespace = ../src/deptracNamespace.dhall

in
DeptracNamespace.namespace
  "Namespace"
  Deptrac.empty //
    { paths =
      [ "./src" ]
    , layers =
      [ { name = "Domain"
        , collectors =
          [ Deptrac.className "^Domain\\\\.*" ]
        }
      , { name = "Infrastructure"
        , collectors =
          [ Deptrac.className "^Infrastructure\\\\.*" ]
        }
      , { name = "Application"
        , collectors =
          [ Deptrac.className "^Application\\\\.*" ]
        }
      ]
    , ruleset = toMap
      { Application =
        [ "Domain"
        , "Infrastructure"
        ]
      , Infrastructure =
        [ "Domain" ]
      }
    }
