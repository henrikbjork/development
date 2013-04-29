-module(euler43).

-export([ run/0
        , test/0
        ]).

run() ->
    Nums = [17,13,11,7,5,3,2],
    Res = find_pandigitals(Nums),
    lists:foldl(fun(X,Acc) -> X + Acc end, 0, Res).

test() ->
    [[932,326],[31,311],[101,11]] = find([[326,311,11,110],[932,101,27,31]]),
    [1,3,0,0,5,6,1,1,9] = merge([130,300,5,56,561,611,119]),
    1406357289 = convert([4,0,6,3,5,7,2,8,9]),
    ok.

find_pandigitals(Nums) ->
    AllNums = lists:map(fun(X) -> lists:seq(X,999,X) end, Nums),
    Candidates0 = lists:map(fun merge/1, find(AllNums)),
    Candidates1 = lists:filter(fun filter/1, Candidates0),
    lists:map(fun convert/1, Candidates1).

merge([H|_] = List) ->
    F = fun(X, Acc) -> [X rem 10|Acc] end,
    Merged = lists:foldr(F, [], List),
    [H div 100, (H div 10) rem 10 | Merged].

filter(X) ->
    lists:member(0,X) andalso length(lists:usort(X)) =:= length(X).

convert(L) ->
    All = sets:from_list([0,1,2,3,4,5,6,7,8,9]),
    RemSet = sets:subtract(All, sets:from_list(L)),
    [A] = sets:to_list(RemSet),
    F = fun(X, {Multiplier, Acc}) -> {10 * Multiplier, X * Multiplier + Acc} end,
    {_,Res} = lists:foldr(F, {1,0}, [A|L]),
    Res.

find([H|T]) -> rec_find(H, [], T).

find(Acc, []) ->
    [Acc];
find([AccH|AccT], [H|T]) ->
    AccMatch = AccH div 10,
    Candidates =  lists:filter(fun(X) -> AccMatch =:= X rem 100 end, H),
    rec_find(Candidates, [AccH|AccT], T).

rec_find(Candidates, Hist, T) ->
    F = fun(X) -> find([X|Hist], T) end,
    lists:flatmap(F, Candidates).
