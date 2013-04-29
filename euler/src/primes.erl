-module(primes).

-export([ find/1
        , is_prime/1]).

%% Sieve of Eratosthenes, optimized to only work with odd numbers
find(Max) when Max rem 2 =/= 0 ->
    Size = Max div 2 - 1,
    %% Index 0 = number 3, 1 = number 5 etc, i.e. number = 2*index+3
    Initial = array:new(Size, {default,true}),
    %%io:format("initial: ~p~n", [Initial]),
    F = fun(I, Acc) ->
                case array:get(I, Acc) of
                    true  -> clear_multiples(I, Size-1, Acc);
                    false -> Acc
                end
        end,
    Final = lists:foldl(F, Initial, lists:seq(0,Size-1)),
    F2 = fun(Index, true, Acc) ->
                 [remap(Index) | Acc];
            (_, false, Acc) ->
                 Acc
         end,
    [2|lists:reverse(array:foldl(F2, [], Final))].

array_unset(Index, Array) ->
    array:set(Index, false, Array).

clear_multiples(N, Max, Array) ->
    Step = remap(N),
    %%io:format("clear ~p~n", [N]),
    lists:foldl(fun array_unset/2, Array, lists:seq(N + Step, Max, Step)).

remap(Index) ->
    2*Index+3.

is_prime(N) when N =:= 2; N =:= 3 -> true;
is_prime(N) when N rem 2 =:= 0    -> false;
is_prime(N) ->
    Max = trunc(math:sqrt(N)),
    F = fun(X) -> N rem X =:= 0 end,
    not lists:any(F, lists:seq(3, Max, 2)).
