-module(euler46).

-export([ run/0
        , test/0
        ]).

run() ->
    [2|Primes] = primes:find(10001),
    DblSqrs = [2*X*X || X <- lists:seq(1,100)],
    OddComps = [X || X <- lists:seq(3,9999,2), not lists:member(X, Primes)],
    find(Primes, DblSqrs, OddComps).

test() ->
    ok.

find(_Primes, _DblSqrs, []) ->
    false;
find(Primes, DblSqrs, [H|T]) ->
    case fulfills(H, Primes, DblSqrs) of
        false -> {ok, H};
        true  -> find(Primes, DblSqrs, T)
    end.

fulfills(N, [H|_], _DblSqrs) when H >= N -> false;
fulfills(N, [H|T], DblSqrs) ->
    case do_fulfill(N, H, DblSqrs) of
        true  -> true;
        false -> fulfills(N, T, DblSqrs)
    end.

do_fulfill(N, Base, [H|T]) when H + Base  <  N -> do_fulfill(N, Base, T);
do_fulfill(N, Base, [H|_]) when H + Base =:= N -> true;
do_fulfill(N, Base, [H|_]) when H + Base  >  N -> false.
