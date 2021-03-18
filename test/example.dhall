let Deptrac = ../src/deptrac.dhall
let DeptracNamespace = ../src/deptracNamespace.dhall

in
DeptracNamespace.namespace
  "Namespace"
  { paths =
    [ "./src" ]
  , exclude_files = [] : List Text
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
  , baseline = None Text
  , ignore_uncovered_internal_classes = True
  , use_relative_path_from_depfile = True
  }
