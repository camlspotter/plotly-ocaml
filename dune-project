(lang dune 3.7)

(name plotly)

(generate_opam_files true)

(source
 (github camlspotter/plotly-ocaml))

(authors "Jun FURUSE <jun.furuse@dailambda.jp>")

(maintainers "Jun FURUSE <jun.furuse@dailambda.jp>")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name plotly)
 (synopsis "Binding for Plotly Open Source Graphing Library")
 (description "OCaml wrapper for Plotly Open Source Graphing Library: https://plotly.com/graphing-libraries")
 (depends (ocaml (>= "4.14.0")) dune js_of_ocaml js_of_ocaml-ppx js_of_ocaml-lwt pyml)
; (tags (topics "to describe" your project))
 (version "1.0.0"))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
