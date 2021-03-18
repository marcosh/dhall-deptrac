let map = https://prelude.dhall-lang.org/List/map

let Deptrac = ../src/deptrac.dhall

let textNamespace = \(namespace : Text) -> \(text : Text) ->
  namespace ++ "_" ++ text
let layerNamespace = \(namespace : Text) -> \(layer : Deptrac.Layer) ->
  { name = textNamespace namespace layer.name
  , collectors = layer.collectors
  } : Deptrac.Layer
let rulesetNamespace = \(namespace : Text) -> \(ruleset : { mapKey : Text, mapValue : List Text }) ->
  { mapKey = textNamespace namespace ruleset.mapKey
  , mapValue = map Text Text (textNamespace namespace) ruleset.mapValue
  } : { mapKey : Text, mapValue : List Text }
let namespace = \(namespace : Text) -> \(depfile : Deptrac.Depfile) ->
  { paths = depfile.paths
  , exclude_files = depfile.exclude_files
  , layers = map Deptrac.Layer Deptrac.Layer (layerNamespace namespace) depfile.layers
  , ruleset = map { mapKey : Text, mapValue : List Text } { mapKey : Text, mapValue : List Text }
    (rulesetNamespace namespace)
    depfile.ruleset
  , baseline = depfile.baseline
  , ignore_uncovered_internal_classes = depfile.ignore_uncovered_internal_classes
  , use_relative_path_from_depfile = depfile.use_relative_path_from_depfile
  } : Deptrac.Depfile
in
{ textNamespace = textNamespace
, namespace = namespace
}
