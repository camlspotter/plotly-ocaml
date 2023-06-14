(lang dune 3.8)

(name plotly)

(generate_opam_files true)

(source
 (github camlpsotter/plotly-ocaml))

(authors "Jun FURUSE <jun.furuse@dailambda.jp>")

(maintainers "Jun FURUSE <jun.furuse@dailambda.jp>")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name plotly)
 (synopsis "Binding for Plotly Open Source Graphing Library")
 (description "OCaml wrapper for Plotly Open Source Graphing Library: https://plotly.com/graphing-libraries")
 (depends ocaml dune js_of_ocaml pyml)
; (tags (topics "to describe" your project))
)

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
