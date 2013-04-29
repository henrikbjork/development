-module(euler45).

-export([ run/0
        , test/0
        ]).

run() ->
    Ns = lists:seq(1,100000),
%%    Tris  = sets:from_list([triangle(N) || N <- Ns]),
    Pents = sets:from_list([pentagonal(N) || N <- Ns]),
    Hexs  = sets:from_list([hexagonal(N) || N <- Ns]),
    sets:to_list(sets:intersection(Pents, Hexs)).

test() ->
    [1,3,6,10,15]  = [triangle(N) || N <- lists:seq(1,5)],
    [1,5,12,22,35] = [pentagonal(N) || N <- lists:seq(1,5)],
    [1,6,15,28,45] = [hexagonal(N) || N <- lists:seq(1,5)],
    Tris  = sets:from_list([triangle(N) || N <- lists:seq(1,1000)]),
    Hexs  = sets:from_list([hexagonal(N) || N <- lists:seq(1,100)]),
    %% "verify" that all hexagonal number are also triangle
    true = lists:sort(sets:to_list(Hexs)) =:= lists:sort(sets:to_list(sets:intersection(Tris, Hexs))),
    ok.

triangle(N) ->
    N*(N+1) div 2.

pentagonal(N) ->
    N*(3*N-1) div 2.

hexagonal(N) ->
    N*(2*N-1).
