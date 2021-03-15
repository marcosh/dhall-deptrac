let Deptrac = ../src/deptrac.dhall

in
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
}
