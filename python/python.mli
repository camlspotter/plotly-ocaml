type _ t = private Py.Object.t

type figure

val of_figure : Plotly.Figure.t -> figure t

val show : ?renderer:string -> figure t -> unit
val write_image : figure t -> string -> unit
