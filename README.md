# Dhall-Deptrac

This is a small tool which allows you to use [Dhall](https://dhall-lang.org/) to write the configuration for [Deptrac](https://github.com/qossmic/deptrac)

## How to use

To create a configuration file for Deptrac, you need to create a `depfile.dhall` file.

You will need to import the code of this library using

```dhall
let Deptrac = https://raw.githubusercontent.com/marcosh/dhall-deptrac/main/src/deptrac.dhall
```

and then create an instance of the [`Depfile`](https://github.com/marcosh/dhall-deptrac/blob/main/src/deptrac.dhall#L84) type, as in

```dhall
let Deptrac = https://raw.githubusercontent.com/marcosh/dhall-deptrac/main/src/deptrac.dhall

in
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
```

Then you can generate the Deptrac configuration file using

```bash
dhall-to-yaml --file depfile.dhall --output depfile.yml
```

Now you can invoke Deptrac as usual with

```bash
php deptrac.phar
```

## Test

Run

```
test/run.sh
```

from the root folder of the repository
