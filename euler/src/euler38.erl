-module(euler38).

-export([run/0]).

run() ->
    run(10000).

run(Max) ->
    F = fun(N, Acc) when N rem 5 =:= 0-> Acc;
           (N, Acc) ->
                P = pandigital(N),
                case P > Acc of
                    true  -> 
                        io:format("new best:~p for ~p~n", [P, N]),
                        P;
                    false -> Acc
                end
        end,
    lists:foldl(F, 0, lists:seq(1,Max)).


pandigital(N) ->
    pandigital(N, 1, []).

pandigital(N, Multiplier, Acc) ->
    case length(Acc) of
        L when L > 9   -> 0;
        L when L =:= 9 -> calc_9(Acc);
        _              ->
            pandigital(N, Multiplier+1, Acc ++ to_list(N * Multiplier))
    end.

to_list(N) -> lists:reverse(do_to_list(N)).

do_to_list(0) -> [];
do_to_list(N) ->
    [N rem 10 | do_to_list(N div 10)].

calc_9(List) ->
    case lists:member(0, List) of
        true  -> 0;
        false ->
            case length(lists:usort(List)) of
                9 -> to_int(List);
                _ -> 0
            end
    end.

%% only from length 9
to_int(List) ->
    F = fun(D, {M, Sum}) ->
                {M div 10, Sum + D * M}
        end,
    {_, Sum} = lists:foldl(F, {100000000, 0}, List),
    Sum.
