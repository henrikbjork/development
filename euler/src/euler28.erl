-module(euler28).

-export([ run/0]).

run() ->
    sum(500).

sum(N) ->
    sum(N, 4, 1, 2, 1).

sum(0, _, _, _, Total) ->
    Total;
sum(N, 0, Current, Inc, Total) ->
    sum(N-1, 4, Current, Inc+2, Total);
sum(N, X, Current0, Inc, Total) ->
    Current = Current0 + Inc,
    sum(N, X-1, Current, Inc, Total+Current).


