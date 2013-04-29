-module(euler41).

-export([run/0]).

run() ->
    Perms = permutations:find_all([7,6,5,4,3,2,1]),
    find_first_prime(Perms).

find_first_prime([H|T]) ->
    Num = permutations:merge(H),
    io:format("testing ~p~n", [Num]),
    case primes:is_prime(Num) of
        true  -> Num;
        false -> find_first_prime(T)
    end.
