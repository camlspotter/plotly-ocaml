# Plotly-ocaml

OCaml wrapper for [Plotly Open Source Graphing Library](https://plotly.com/graphing-libraries/).
It provides 2 backend interfaces:

Standalone version via Pyml
:  Using Python library of Plotly. For standalone programs.

JSOO version
:  Using JS library of Plotly and [Js_of_ocaml](https://ocsigen.org/js_of_ocaml/latest/manual/overview).  For JSOO programs.


## Supported features

Plotly-ocaml only covers small subset of Plotly features, but it is easy
to add new graphs, data and layout attributes. Your contributions are welcome.

## Type safety

There is no type dicipline to check your misuses of attributes, for example
using `z` attribute in 2d scatter graph.  Such cool typing can be introduced
using phantom type/GADT with sub-types but I want to keep this library dumb
as possible for now.

## Pyml issue

pyml.20220905 does not load the Python runtime in mac OS + Homebrew.
Use the fixed version of pyml if you have trouble executing python/demo/demo.exe:

```
$ opam pin add pyml.20220906 git+https://gitlab.com/dailambda/pyml#b09f7160
```
