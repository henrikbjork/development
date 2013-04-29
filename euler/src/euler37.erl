-module(euler37).

-export([run/0]).

run() ->
    Primes = primes:find(1000000),
    F = fun(N, Acc) ->
                case is_trunc_prime(N, Primes) of
                    true -> [N | Acc];
                    false -> Acc
                end
        end,
    L = lists:foldl(F, [], Primes),
    lists:foldl(fun(X,S) -> X + S end, 0, L).

is_trunc_prime(N, _Primes) when N < 10 ->
    false;
is_trunc_prime(N, Primes) ->
    P = fun(X) -> lists:member(X, Primes) end,
    lists:all(P, trunc_list(N div 10) ++ rev_trunc_list(N)).

trunc_list(0) ->
    [];
trunc_list(N) ->
    [N | trunc_list(N div 10)].

rev_trunc_list(N) ->
    rev_trunc_list(N, 10).

rev_trunc_list(N, D) when D > N ->
    [];
rev_trunc_list(N, D) ->
    [N rem D | rev_trunc_list(N, D * 10)].
