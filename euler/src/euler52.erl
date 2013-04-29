-module(euler52).

-export([ run/0
        , test/0
        ]).

run() ->
    N = 6,
    X = find(N),
    [X * M || M <- lists:seq(1,N)].

test() ->
    true = same_digits([343, 433, 343]),
    false = same_digits([12, 21, 13]),
    ok.

find(N) ->
    find(10, lists:seq(1,N)).

find(X, Multipliers) ->
    Nums = [X * M || M <- Multipliers],
    case same_digits(Nums) of
        true  -> X;
        false -> find(next(X), Multipliers)
    end.

same_digits([H|T]) ->
    same_digits(lists:sort(permutations:split(H)), T).

same_digits(_Str, []) -> true;
same_digits(Str, [H|T]) ->
    case lists:sort(permutations:split(H)) of
        Str -> same_digits(Str, T);
        _   -> false
    end.

next(16) -> 100;
next(166) -> 1000;
next(1666) -> 10000;
next(16666) -> 100000;
next(166666) -> 1000000;
next(X) when X > 9 -> X+1.

