let Deptrac = https://raw.githubusercontent.com/marcosh/dhall-deptrac/main/src/deptrac.dhall

in
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
