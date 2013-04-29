-module(euler29).

-export([ run/0
        , pow/2]).

run() ->
    unique_pows(lists:seq(2,100), lists:seq(2,100)).

unique_pows(A,B) ->
    All = pows(A,B,B,[]),
    Unique = lists:usort(All),
    length(Unique).

pows([], _B, _BO,Acc) ->
    Acc;
pows([_AH|AT], [], BO, Acc) ->
    pows(AT, BO, BO, Acc);
pows([AH|_AT]=A, [BH|BT], BO, Acc) ->
    pows(A, BT, BO, [pow(AH,BH)|Acc]).

pow(0,_E) -> 0;
pow(_N,0) -> 1;
pow(N,E)  -> N*pow(N,E-1).



