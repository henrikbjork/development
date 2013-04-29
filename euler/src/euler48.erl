-module(euler48).

-export([run/1]).

run(N) ->
    Sum = lists:foldl(fun(X,Acc) ->
                              ten_last(Acc+pow(X,X))
                      end,
                      0,
                      lists:seq(1,N)),
    Sum.

ten_last(N) ->
    N rem 10000000000.

pow(_,0) -> 1;
pow(N,E) -> ten_last(N*pow(N,E-1)).
