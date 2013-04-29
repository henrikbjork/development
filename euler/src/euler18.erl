-module(euler18).

-export([ run/0
        , run/1
        , test/0
        ]).

run() ->
    Data = [ [75]
           , [95,64]
           , [17,47,82]
           , [18,35,87,10]
           , [20,04,82,47,65]
           , [19,01,23,75,03,34]
           , [88,02,77,73,07,63,67]
           , [99,65,04,28,06,16,70,92]
           , [41,41,26,56,83,40,80,70,33]
           , [41,48,72,33,47,32,37,16,94,29]
           , [53,71,44,65,25,43,91,52,97,51,14]
           , [70,11,33,28,77,73,17,78,39,68,17,57]
           , [91,71,52,38,17,14,91,43,58,50,27,29,48]
           , [63,66,04,68,89,53,67,30,73,16,69,87,40,31]
           , [04,62,98,27,23,09,70,98,73,93,38,53,60,04,23]
           ],
    run(Data).

test() ->
    [1,5,5,3] = maxs([1,1,5,2,3]),
    23 = run([ [3]
             , [7,4]
             , [2,4,6]
             , [8,5,9,3]
             ]),
    ok.

run(Data) ->
    N = length(Data),
    compute(N-1, lists:nth(N, Data), Data).

compute(0, [Result], _Data) ->
    Result;
compute(N, Acc0, Data) ->
    Current = lists:nth(N, Data),
    Maxs = maxs(Acc0),
    Acc = lists:zipwith(fun(X,Y) -> X+Y end, Current, Maxs),
    compute(N-1, Acc, Data).

maxs(L = [_,_|_] = [_|L2]) ->
    L1 = lists:sublist(L, length(L2)),
    [max(X,Y) || {X,Y} <- lists:zip(L1,L2)].
