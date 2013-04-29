-module(euler50).

-export([ run/0
        , test/0
        ]).

run() ->
    find(999999,550).

test() ->
    {41,6} = find(99, 10),
    {953,21} = find(999,30),
    ok.

find(Max, Start) ->
    Primes = primes:find(2 * (Max div 2) + 3),
    do_find(Max, 1, Start, Primes).

do_find(Max, I, N, Primes) ->
    case lists:sum(lists:sublist(Primes, I, N)) of
        X when X > Max -> do_find(Max, 1, N-1, Primes);
        X -> case lists:member(X, Primes) of
                 true  -> {X,N};
                 false -> do_find(Max, I+1, N, Primes)
             end
    end.
