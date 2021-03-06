{-
Welcome to your new Dhall package-set!

Below are instructions for how to edit this file for most use
cases, so that you don't need to know Dhall to use it.

## Warning: Don't Move This Top-Level Comment!

Due to how `dhall format` currently works, this comment's
instructions cannot appear near corresponding sections below
because `dhall format` will delete the comment. However,
it will not delete a top-level comment like this one.

## Use Cases

Most will want to do one or both of these options:
1. Override/Patch a package's dependency
2. Add a package not already in the default package set

This file will continue to work whether you use one or both options.
Instructions for each option are explained below.

### Overriding/Patching a package

Purpose:
- Change a package's dependency to a newer/older release than the
    default package set's release
- Use your own modified version of some dependency that may
    include new API, changed API, removed API by
    using your custom git repo of the library rather than
    the package set's repo

Syntax:
Replace the overrides' "{=}" (an empty record) with the following idea
The "//" or "⫽" means "merge these two records and
  when they have the same value, use the one on the right:"
-------------------------------
let overrides =
  { packageName =
      upstream.packageName // { updateEntity1 = "new value", updateEntity2 = "new value" }
  , packageName =
      upstream.packageName // { version = "v4.0.0" }
  , packageName =
      upstream.packageName // { repo = "https://www.example.com/path/to/new/repo.git" }
  }
-------------------------------

Example:
-------------------------------
let overrides =
  { halogen =
      upstream.halogen // { version = "master" }
  , halogen-vdom =
      upstream.halogen-vdom // { version = "v4.0.0" }
  }
-------------------------------

### Additions

Purpose:
- Add packages that aren't already included in the default package set

Syntax:
Replace the additions' "{=}" (an empty record) with the following idea:
-------------------------------
let additions =
  { package-name =
       { dependencies =
           [ "dependency1"
           , "dependency2"
           ]
       , repo =
           "https://example.com/path/to/git/repo.git"
       , version =
           "tag ('v4.0.0') or branch ('master')"
       }
  , package-name =
       { dependencies =
           [ "dependency1"
           , "dependency2"
           ]
       , repo =
           "https://example.com/path/to/git/repo.git"
       , version =
           "tag ('v4.0.0') or branch ('master')"
       }
  , etc.
  }
-------------------------------

Example:
-------------------------------
let additions =
  { benchotron =
      { dependencies =
          [ "arrays"
          , "exists"
          , "profunctor"
          , "strings"
          , "quickcheck"
          , "lcg"
          , "transformers"
          , "foldable-traversable"
          , "exceptions"
          , "node-fs"
          , "node-buffer"
          , "node-readline"
          , "datetime"
          , "now"
          ]
      , repo =
          "https://github.com/hdgarrood/purescript-benchotron.git"
      , version =
          "v7.0.0"
      }
  }
-------------------------------
-}


let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200724/packages.dhall sha256:bb941d30820a49345a0e88937094d2b9983d939c9fd3a46969b85ce44953d7d9

let overrides =
  { uuid =
    { dependencies = [ "foreign-generic", "sized-vectors" ]
    , repo = "https://github.com/openchronology/purescript-uuid.git"
    , version = "master"
    }
  , arraybuffer-class = upstream.arraybuffer-class // { version = "v0.2.6" }
  }

let additions =
  { timeline-identifiers =
    { dependencies = ["sized-vectors", "arraybuffer-class", "uuid"]
    , repo = "https://github.com/openchronology/purescript-timeline-identifiers.git"
    , version = "v0.0.0-rc3"
    }
  , timeline-time =
    { dependencies = [ "arraybuffer-class", "argonaut" ]
    , repo = "https://github.com/openchronology/purescript-timeline-time.git"
    , version = "v0.0.0-rc1"
    }
  , timeline-view =
    { dependencies =
      [ "data-default"
      , "indexed-array"
      , "unique-array"
      , "quickcheck-utf8"
      , "timeline-identifiers"
      , "timeline-time"
      , "uuid"
      , "web-html"
      , "zeta"
      ]
    , repo = "https://github.com/openchronology/purescript-timeline-view.git"
    , version = "master"
    }
  , indexed-array =
    { dependencies = [ "generics-rep" ]
    , repo = "https://github.com/openchronology/purescript-indexed-array.git"
    , version = "master"
    }
  , unique-array =
    { dependencies = [ "arrays", "generics-rep", "arraybuffer-class", "argonaut" ]
    , repo = "https://github.com/openchronology/purescript-unique-array.git"
    , version = "master"
    }
  , zeta-mapping =
    { dependencies = [ "zeta", "queue", "profunctor", "generics-rep" ]
    , repo = "https://github.com/openchronology/purescript-zeta-mapping.git"
    , version = "master"
    }
  , zeta-array =
    { dependencies = [ "zeta", "queue" ]
    , repo = "https://github.com/openchronology/purescript-zeta-array.git"
    , version = "master"
    }
  , zeta-unique-array =
    { dependencies = [ "zeta", "queue", "unique-array" ]
    , repo =
        "https://github.com/openchronology/purescript-zeta-unique-array.git"
    , version = "master"
    }
  }

in  upstream // overrides // additions
