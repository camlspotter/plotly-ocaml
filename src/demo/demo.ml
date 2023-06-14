open Plotly
open Data
open Graph
open Figure
open Layout

let scatter_ =
  figure
    [ scatter
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          (* mode "lines+markers" *)
        ] ]
    [ title "Scatter lines+markers" ]


let scatter_markers =
  figure
    [ scatter
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          mode "markers";
        ] ]
    [ title "Scatter markers" ]

let scatter_lines =
  figure
    [ scatter
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          mode "lines";
        ] ]
    [ title "Scatter lines" ]

let scatter_multi =
  figure
    [ scatter
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          name "Team A";
          (* mode "lines+markers" *)
        ];
      scatter
        [ xy [| (1.0, 2.0); (2.0, 1.0); (3.0, 3.0); (4.0, 7.0); (5.0, 11.0) |];
          mode "markers";
          name "Team B";
        ] ]
    [ title "Scatter multi" ]

let scatter_text =
  figure
    [ scatter
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |]
        ] ]
    [ title "Scatter with hoover texts" ]

let scatter_3d =
  figure
    [ scatter3d
        [ xyz [| (1.0, 1.0, 1.0); (2.0, 2.0, 8.0); (3.0, 4.0, 27.0); (4.0, 8.0, 64.0); (5.0, 16.0, 125.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |];
        ] ]
    [ title "Scatter 3D" ]

let bar_ =
  figure
    [ bar
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |];
        ] ]
    [ title "Bar with hoover texts" ]

let bar_stack =
  figure
    [ bar
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |];
        ];
      bar
        [ xy [| (1.0, 1.0); (2.0, 2.0); (3.0, 4.0); (4.0, 8.0); (5.0, 16.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |];
        ] ]
    [ title "Stacked Bar";
             barmode "stack"
           ]

let bar_stack_horizontal =
  figure
    [ bar
        [ xy [| (1.0, 1.0); (2.0, 2.0); (4.0, 3.0); (8.0, 4.0); (16.0, 5.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |];
          orientation "h";
        ];
      bar
        [ xy [| (1.0, 1.0); (2.0, 2.0); (4.0, 3.0); (8.0, 4.0); (16.0, 5.0) |];
          text [| "A"; "B"; "C"; "D"; "E" |];
          orientation "h";
        ] ]
    [ title "Stacked Bar, horizontal";
      barmode "stack"
    ]

let pie_ =
  figure
    [ pie [ values [| 1.0; 2.0; 3.0 |];
            labels [| "A"; "B"; "C" |];
          ] ]
    [ title "Pie" ]

let figures =
  [ scatter_;
    scatter_markers;
    scatter_lines;
    scatter_multi;
    scatter_text;
    scatter_3d;
    bar_;
    bar_stack;
    bar_stack_horizontal;
    pie_
  ]
