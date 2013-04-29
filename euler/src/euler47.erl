-module(euler47).

-export([ run/0
        , test/0
        ]).

run() ->
    find_consequitive(4,500000).

test() ->
    Primes     = primes:find(1001),
    [2,7]      = dividers(14, Primes),
    [2,2,7,23] = dividers(644, Primes),
    [[],[2],[3],[2],[5],[2,3]] = find_dividers(6),
    14 = find_consequitive(2, 100),
    644 = find_consequitive(3, 1000),
    ok.

find_dividers(Max) ->
    Primes = primes:find((Max div 2) * 2 + 3),
    F = fun(N, Acc) ->
                Res = dividers(N, Acc, Primes),
                array:set(N, Res, Acc)
        end,
    Array0 = array:new(Max+1),
    Array1 = array:set(1, [], Array0),
    Array2 = lists:foldl(F, Array1, lists:seq(2,Max)),
    [_|Res] = array:to_list(Array2),
    Res.

dividers(N, Array, [H|_]) when N rem H =:= 0 ->
    lists:usort([H | array:get(N div H, Array)]);
dividers(N, Array, [_|T]) ->
    dividers(N, Array, T).

dividers(N, [N|_]) -> [N];
dividers(N, [H|T]) ->
    case N rem H of
        0 -> [H|dividers(N div H, [H|T])];
        _ -> dividers(N, T)
    end.

find_consequitive(Sought, Max) ->
    Divs = find_dividers(Max),
    Lens = [length(X) || X <- Divs],
    do_find(1, 0, Sought, Lens).

do_find(Index, Sought, Sought, _) ->
    Index - Sought;
do_find(Index, Acc, Sought, [Sought|T]) ->
    do_find(Index+1, Acc+1, Sought, T);
do_find(Index, _,   Sought, [_|T]) ->
    do_find(Index+1, 0, Sought, T).

