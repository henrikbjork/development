-module(euler60).

-export([run/0]).

run() ->
    [2|Primes] = primes:find(1000),
    PrimeCombos = combos(Primes),
    PrimeSets = sets(PrimeCombos).

sets([]) -> [];
sets([{N,Combs}|T]) ->
    log("N: ~p~nCombs: ~p~n", [N,Combs]),
    Set = sets:from_list(Combs),
    F = fun(Elem, Acc) ->
                CmpSet = orddict:fetch(Elem, T),
                log("check ~p~nagainst ~p", [Elem, CmpSet]),
                case sets:to_list(sets:intersection(Set, sets:from_list(CmpSet))) of
                    []  -> Acc;
                    Res -> [{N,Elem, Res} | Acc]
                end
        end,
    Cs = lists:foldl(F, [], Combs),
    Cs. %% ++ sets(T).

combos([]) ->
    [];
combos([H|T]) ->
    Cs = [C || C <- T, is_prime_combo(H,C)],
    [{H,Cs} | combos(T)].

is_prime_combo(P1,P2) ->
    primes:is_prime(P1*trunc(math:pow(10,magnitude(P2)))+P2) andalso
        primes:is_prime(P2*trunc(math:pow(10,magnitude(P1)))+P1).

magnitude(X) ->
    mag(X,0).

mag(0, N) -> N;
mag(X, N) -> mag(X div 10, N+1).

log(Str, Args) ->
    io:format(Str ++ "~n", Args).
