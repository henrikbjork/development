-module(euler49).

-export([ run/0
        , test/0
        ]).

run() ->
    find(primes_between(1000, 10001)).

test() ->
    [11,13,17,19] = primes_between(10,21),
    [31] = perms(13, sets:from_list([11,13,17,19,23,29,31,37])),
    ok.

find(Primes) ->
    Set = sets:from_list(Primes),
    F = fun(E, Acc) -> case check(E, Set) of
                           {ok, Res} -> [Res|Acc];
                           false     -> Acc
                       end
        end,
    lists:foldl(F, [], Primes).

check(X, Set) ->
    do_check(X, perms(X, Set)).

do_check(_X, [])         -> false;
do_check(X, [H|T] = Res) ->
    io:format("check ~p ~p~n", [X, Res]),
    case lists:member(H + H - X, Res) of
        true  -> {ok, [X, H, H + H - X]};
        false -> do_check(X, T)
    end.

perms(X, Set) ->
    LX = permutations:split(X),
    LPerms = lists:delete(LX, permutations:find_unique(LX)),
    Perms = lists:map(fun permutations:merge/1, LPerms),
    lists:filter(fun(E) -> sets:is_element(E, Set) end, Perms).

primes_between(Min, Max) ->
    Primes0 = primes:find(Max),
    lists:dropwhile(fun(X) -> X < Min end, Primes0).
