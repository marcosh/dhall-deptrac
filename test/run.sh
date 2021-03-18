#!/usr/bin/env bash

docker run --workdir /data --rm -v $(pwd):/data dhallhaskell/dhall-json:latest dhall-to-yaml --file test/example.dhall --output test/example.yml

docker run --workdir /data --rm --entrypoint "sh" -v $(pwd):/data smoench/deptrac-action:latest -c "cd test && deptrac analyse example.yml"
