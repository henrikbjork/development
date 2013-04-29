-module(permutations).

-export([ find_all/1
        , find_unique/1
        , merge/1
        , split/1
        , test/0
        ]).

test() ->
    [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] = find_unique([1,2,3]),
    [3,2,4,5,0,1] = split(324501),
    7364640 = merge([0,7,3,6,4,6,4,0]),
    ok.

find_all(L) ->
    all_permutations(L, length(L)).

find_unique(L) ->
    lists:usort(find_all(L)).

all_permutations([], 0)  -> [[]];
all_permutations(L, Len) ->
    F = fun(I) ->
                X = lists:nth(I, L),
                Rem = lists:delete(X,L),
                SubPerms = all_permutations(Rem, Len-1),
                lists:map(fun(SP) -> [X|SP] end, SubPerms)
        end,
    lists:flatmap(F, lists:seq(1,Len)).

merge(List) ->
    F = fun(D, {M, Sum}) ->
                {M div 10, Sum + D * M}
        end,
    {_, Sum} = lists:foldl(F, {trunc(math:pow(10,length(List)-1)), 0}, List),
    Sum.

split(Int) ->
    do_split(Int, []).

do_split(0, Acc) ->
    Acc;
do_split(Num, Acc) ->
    do_split(Num div 10, [Num rem 10|Acc]).

