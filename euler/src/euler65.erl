-module(euler65).

-export([ run/0
        , run/1
        , test/0
        ]).

run() ->
    run(gen_e_list(100)).

run(L) ->
    {N,_} = calc(L),
    dig_sum(N).

calc(L0) ->
    [H|T] = lists:reverse(L0),
    calc(T, H, 1).

calc([], N, D) ->
    {N,D};
calc([H|T], N, D) ->
    calc(T, H*N+D, N).

gen_e_list(N) ->
    [2|gen_e_list(N-1,1,2)].

gen_e_list(0, _, _) ->
    [];
gen_e_list(N, 0, X) ->
    [X|gen_e_list(N-1,2,X+2)];
gen_e_list(N, I, X) ->
    [1|gen_e_list(N-1,I-1,X)].

dig_sum(0) -> 0;
dig_sum(N) ->
    N rem 10 + dig_sum(N div 10).

test() ->
    {99,70} = calc([1,2,2,2,2,2]),
    {193,71} = calc([2,1,2,1,1,4,1,1]),
    [2,1,2,1,1,4,1,1,6,1,1,8,1] = gen_e_list(13),
    ok.
