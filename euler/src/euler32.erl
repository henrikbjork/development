-module(euler32).

-export([ run/0
        , test/0
        ]).

run() ->
    Prods0 = [X*Y || X <- lists:seq(3,99), Y <- lists:seq(100,3333), is_pandigital(X,Y)],
    Prods = lists:usort(Prods0),
    lists:foldl(fun(X,Acc) -> X + Acc end, 0, Prods).

test() ->
    true = is_pandigital(39,186),
    false = is_pandigital(10,999),
    false = is_pandigital(39,187),
    ok.

is_pandigital(X,Y) ->
    Prod = X*Y,
    XL = permutations:split(X),
    YL = permutations:split(Y),
    PL = permutations:split(Prod),
    case length(PL) of
        4 -> lists:sort(XL ++ YL ++ PL) =:= [1,2,3,4,5,6,7,8,9];
        _ -> false
    end.

