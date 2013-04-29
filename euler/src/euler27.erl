-module(euler27).

-export([ is_prime/1
        , run/0]).

run() ->
    max_quad(lists:seq(-1000,1000), lists:seq(-1000,1000)).

max_quad(AS, BS) ->
    max_quad(AS, BS, BS, {0,0,0}).

max_quad([], _,_,Score) ->
    Score;
max_quad([_AH|AT], [], BS, Score) ->
    max_quad(AT, BS, BS, Score);
max_quad([AH|_AT]=A, [BH|BT], BS, {_,_,S} = Score0) ->
    Q = quad(AH,BH),
    Score = case Q > S of
                true  -> {AH,BH,Q};
                false -> Score0
            end,
    max_quad(A,BT, BS, Score).

quad(A,B) ->
    do_quad(0,A,B).

do_quad(N,A,B) ->
    Q = calc_quad(N,A,B),
    case is_prime(Q) of
        true  ->
            do_quad(N+1,A,B);
        false ->
            N-1
    end.

calc_quad(N,A,B) ->
    N*N+A*N+B.

is_prime(A) when A < 2 ->
    false;
is_prime(2) ->
    true;
is_prime(A) when A rem 2 =:= 0 ->
    false;
is_prime(A) ->
    is_prime(3, A).

is_prime(N, M) when N * N > M ->
    true;
is_prime(N, M) when M rem N =:= 0 ->
    false;
is_prime(N, M) ->
    is_prime(N+2, M).

