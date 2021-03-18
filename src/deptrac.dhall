let map = https://prelude.dhall-lang.org/List/map
let RegexCollector : Type
  = { type : Text
    , regex : Text
    }
let MethodCollector : Type
  = { type : Text
    , name : Text
    }
let ImplementsCollector : Type
  = { type : Text
    , implements : Text
    }
let ExtendsCollector : Type
  = { type: Text
    , extends : Text
    }
let UsesCollector : Type
  = { type : Text
    , uses : Text
    }
let InheritsCollector : Type
  = { type : Text
    , inherits : Text
    }
let SimpleCollector : Type
  = < Regex : RegexCollector
    | Method : MethodCollector
    | Implements : ImplementsCollector
    | Extends : ExtendsCollector
    | Uses : UsesCollector
    | Inherits : InheritsCollector
    >
let boolClassName = \(regex : Text) ->
  SimpleCollector.Regex
  { type = "className"
  , regex = regex
  }
let boolDirectory = \(regex : Text) ->
  SimpleCollector.Regex
  { type = "directory"
  , regex = regex
  }
let BoolCollector : Type
  = { type: Text
    , must : List SimpleCollector
    , must_not : List SimpleCollector
    }
let Collector : Type
  = < Regex : RegexCollector
    | Method : MethodCollector
    | Implements : ImplementsCollector
    | Extends : ExtendsCollector
    | Uses : UsesCollector
    | Inherits : InheritsCollector
    | Bool : BoolCollector
    >
let className = \(regex : Text) ->
  Collector.Regex
  { type = "className"
  , regex = regex
  }
let directory = \(regex : Text) ->
  Collector.Regex
  { type = "directory"
  , regex = regex
  }
let bool = \(must : List SimpleCollector) -> \(must_not : List SimpleCollector) ->
  Collector.Bool
  { type = "bool"
  , must = must
  , must_not = must_not
  }
let Layer : Type
  = { name : Text
    , collectors : List Collector
    }
let Depfile : Type
  = { paths: List Text
    , exclude_files: List Text
    , layers : List Layer
    , ruleset : List { mapKey : Text, mapValue : List Text }
    }
in
{ RegexCollector = RegexCollector
, MethodCollector = MethodCollector
, ImplementsCollector = ImplementsCollector
, ExtendsCollector = ExtendsCollector
, UsesCollector = UsesCollector
, InheritsCollector = InheritsCollector
, SimpleCollector = SimpleCollector
, BoolCollector = BoolCollector
, Collector = Collector
, Layer = Layer
, className = className
, boolClassName = boolClassName
, directory = directory
, boolDirectory = boolDirectory
, bool = bool
, Depfile = Depfile
}
