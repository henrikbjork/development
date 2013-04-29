-module(euler30).

-export([run/0]).

run() ->
    pow_sum(5).

pow_sum(E) ->
    Nums = pow_sum(2, 1000000, E, []),
    lists:foldl(fun(X,Acc) -> X + Acc end, 0, Nums).

pow_sum(Max, Max, _E, Acc) ->
    Acc;
pow_sum(N, Max, E, Acc0) ->
    Acc = case is_pow_sum(N,E) of
              true  -> [N|Acc0];
              false -> Acc0
          end,
    pow_sum(N+1, Max, E, Acc).

is_pow_sum(N,E) ->
    digit_pow_sum(N,E) =:= N.

digit_pow_sum(N,E) ->
    L = integer_to_list(N),
    F = fun(D,Acc) -> pow(D-$0,E) + Acc end,
    lists:foldl(F, 0, L).

pow(N,E) ->
    euler29:pow(N,E).
