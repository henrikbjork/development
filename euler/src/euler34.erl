-module(euler34).

-export([ run/0]).

run() ->
    Facts = factorials(),
    lists:filter(fun(X) -> X =:= fact_sum(X, Facts) end, lists:seq(10,10000000)).

fact_sum(X, Facts) when X > 9 ->
    L = integer_to_list(X),
    F = fun(Y, Sum) ->
                array:get(Y-$0, Facts) + Sum
        end,
    lists:foldl(F, 0, L).

factorials() ->
    L = lists:map(fun euler:factorial/1, lists:seq(0,9)),
    array:from_list(L).
