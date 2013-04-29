-module(euler44).

-export([run/1]).

%% start value, bigger than expected min
-define(NAN, 100000000).

%% answer is {1560090,7042750,5482660}
run(Num) ->
    PentNums = pentagonal_numbers(Num),
    find_smallest_diff(PentNums).

pentagonal_numbers(Num) ->
    F = fun(N) -> (N*(3*N-1)) div 2 end,
    lists:map(F, lists:seq(1,Num)).

find_smallest_diff(PentNums) ->
    find_smallest_diff(sets:from_list(PentNums), PentNums, {0,0,?NAN}).

find_smallest_diff(_, [], Min)              ->
    Min;
find_smallest_diff(PentNums, [H|T], Min0) ->
    Min = do_find_smallest_diff(PentNums, H, T, Min0),
    find_smallest_diff(PentNums, T, Min).

do_find_smallest_diff(_, _, [],Min) ->
    Min;
do_find_smallest_diff(PentNums, Val, [H|T], {_,_,MinDiff}=Min) ->
    Diff = H - Val,
    case Diff > MinDiff of
        true  -> Min;
        false ->
            Sum = H + Val,
            case sets:is_element(Diff, PentNums) andalso
                sets:is_element(Sum, PentNums) of
                true ->
                    {Val, H, Diff};
                false ->
                    do_find_smallest_diff(PentNums, Val, T, Min)
            end
    end.
