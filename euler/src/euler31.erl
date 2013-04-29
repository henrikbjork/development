-module(euler31).

-export([run/0]).

run() ->
    cur(200).

cur(N) ->
    cur(N, [200,100,50,20,10,5,2,1]).

cur(0, _) -> 1;
cur(_,[]) -> 0;
cur(Left, [H|T]) ->
    N = Left div H,
    F = fun(X, Acc) ->
                cur(Left - X * H, T) + Acc
        end,
    lists:foldl(F, 0, lists:seq(0,N)).
