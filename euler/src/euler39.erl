-module(euler39).

-export([run/0]).

-define(MAX, 1000).

run() ->
    Nums = lists:seq(1,?MAX div 2),
    R=[conv(A,B) || A <- Nums, B <- Nums, A =< B, A + B + B < ?MAX, is_right_angle(A,B)],
    count_most(R).

conv(A,B) ->
    C = trunc(math:sqrt(A*A+B*B)),
    {A+B+C,A,B,C}.

is_right_angle(A,B) ->
    Sqrt = math:sqrt(A*A+B*B),
    Sqrt == trunc(Sqrt) andalso A+B+trunc(Sqrt) =< ?MAX.

count_most(R) ->
    p("count_most ~p", [R]),
    F = fun({Sum,A,B,C}, []) ->
                p("first"),
                Best = {Sum,1,[{A,B,C}]},
                {Best, Best};
           ({Sum,A,B,C}, {{Sum,Count,Sides}, {_,Count,_}}) ->
                Best = {Sum,Count+1,[{A,B,C}|Sides]},
                p("new best ~p", [Best]),
                {Best, Best};
           ({Sum,A,B,C}, {{Sum,Count,Sides}, Best}) ->
                p("count ~p:~p", [Sum, Count+1]),
                {{Sum,Count+1,[{A,B,C}|Sides]}, Best};
           ({Sum,A,B,C}, {_, Best}) ->
                p("new ~p", [Sum]),
                {{Sum,1,[{A,B,C}]}, Best}
        end,
    Res = lists:foldl(F, [], lists:keysort(1,R)),
    {_, Best} = Res,
    Best.

p(S) ->
    p(S, []).

p(S,A) ->
    io:format(S++"~n",A).
