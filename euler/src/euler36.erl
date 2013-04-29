-module(euler36).

-export([run/0]).

run() ->
    run(1000000).

run(Max) ->
    F = fun(N, Sum) ->
                case is_palin_in_both(N) of
                    true -> Sum + N;
                    false -> Sum
                end
        end,
    lists:foldl(F, 0, lists:seq(1,Max)).

is_palin_in_both(N) ->
    is_palindrome(rev_num_in_base(N, 2)) andalso is_palindrome(rev_num_in_base(N, 10)).

is_palindrome(L) when is_list(L) ->
    L =:= lists:reverse(L).

%% reversed number as list, i.e. (100,10) -> [0,0,1].
rev_num_in_base(0, _Base) ->
    [];
rev_num_in_base(N, Base) ->
    [N rem Base | rev_num_in_base(N div Base, Base)].
