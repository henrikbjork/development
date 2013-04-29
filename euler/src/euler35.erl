-module(euler35).

-export([run/0]).

run() ->
    Primes = primes:find(100000),
    F = fun(X) -> is_circular(X, Primes) end,
    lists:filter(F, Primes).

is_circular(X, All) ->
    C = create_circulars(X),
    lists:all(fun(Y) -> lists:member(Y, All) end, C).

create_circulars(X) ->
    L = integer_to_list(X),
    Length = length(L),
    LL = L ++ L,
    F = fun(N) -> lists:sublist(LL, N, Length) end,
    R0 = lists:map(F, lists:seq(1,Length)),
    R1 = lists:filter(fun([$0|_]) -> false;
                         (_)      -> true
                      end,
                      R0),
    lists:map(fun erlang:list_to_integer/1, R1).
