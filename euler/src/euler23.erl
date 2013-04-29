-module(euler23).

-export([ run/0
        , find_abundants/1
        , test/0
        ]).

run() ->
    N = 28123,
    Abundants = find_abundants(N),
    NonSums = find_all_non_sums(N, Abundants),
    lists:foldl(fun(E,Acc) -> E + Acc end, 0, NonSums).

test() ->
    3 = divisor_sum(4),
    16 = divisor_sum(12),
    false = is_abundant(11),
    true = is_abundant(12),
    [12,18,20,24] = find_abundants(27),
    [0,1,2,3,14] = find_all_non_sums(15, [2,3,4,6,9]),
    ok.

find_abundants(N) ->
    Primes = primes:find(N) ++ [N],
    Array = array:new(N+1, {default,[]}),
    Vals = lists:foldl(fun(Elem, Acc) -> dividers(Elem, Acc, Primes) end,
                       Array, lists:seq(3,N)),

    array:foldr(fun(Index, Val, Acc) ->
                        case sum(Val) of
                            V when V >= Index, Index > 1 -> [Index | Acc];
                            _                            -> Acc
                        end
                end, [], Vals).

find_all_non_sums(N, Abundants) ->
    F = fun(E1, Acc) ->
                lists:foldl(fun(E2,A) -> case E1+E2 =< N of
                                             true  -> array:set(E1+E2, true, A);
                                             false -> A
                                         end
                            end, Acc, Abundants)
        end,
    Array = lists:foldl(F, array:new(N+1, {default,false}), Abundants),
    F2 = fun(Index,  false, Acc) -> [Index | Acc];
            (_Index, true,  Acc) -> Acc
         end,
    array:foldr(F2, [], Array).

dividers(N, Array, Primes) ->
    Div = find_div(N, Primes),
    Divs = divs(N, Div, Array),
    %io:format("Divs for ~p is ~p~n", [N, Divs]),
    array:set(N, Divs, Array).

find_div(N, [H|_T]) when N rem H =:= 0 -> H;
find_div(N, [_H|T])                    -> find_div(N, T).

divs(N, N, _Array) -> [];
divs(N, Div, Array) ->
    I = N div Div,
    IVals = array:get(I, Array),
    lists:usort([Div,I|IVals] ++ lists:map(fun(X) -> Div * X end, IVals)).

is_abundant(N) ->
    N < divisor_sum(N).

divisor_sum(N) ->
    F = fun(Elem, Sum) ->
                case N rem Elem of
                    0 -> Sum + Elem;
                    _ -> Sum
                end
        end,
    lists:foldl(F, 0, lists:seq(1, N div 2)).

sum(L) ->
    lists:foldl(fun(E,A) -> E+A end, 0, L).
