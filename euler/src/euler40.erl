-module(euler40).

-export([run/0]).

%% 1-9 -> 9*1 = 9 digits -> acc 9
%% 10-99 -> 90*2 = 180 digits -> acc 189
%% 100-999 -> 900*3 = 2700 digits -> acc 2889
%% 1000-9999 -> 9000*4 = 36000 digits -> acc 38889
%% 10000-99999 -> 90000*5 = 450000 digits -> 488889
%% digit 1 = 1
%% digit 10 = 10 -> 1
%% digit 100 = 91 in 10-99 = 45*2+1 -> 10+45 = 55 -> 5
%% digit 1000 -> 1000-189 = 811 in 100-999 -> 270*3+1 -> 100+270 = 370 -> 3
%% digit 10000 -> 10000-2889 = 7111 in 1000-9999 -> 1777+3/4
run() ->
    lists:map(fun nth_digit/1, [1,10,100,1000,10000,100000,1000000]).

nth_digit(X) ->
   Spans = [ {1,0,1}
           , {10,9,2}
           , {100,189,3}
           , {1000,2889,4}
           , {10000,38889,5}
           , {100000,488889,6}
           ],
    Span = find_span(X, Spans),
    {Num, NumDigit} = num_and_digit(X,Span).

find_span(X, Spans) ->
    L = lists:reverse(Spans),
    hd(lists:filter(fun({_,Start,_}) -> Start =< X end, L)).

num_and_digit(X, {StartNum, Offset,NumWidth}) ->
    N = X - Offset - 1,
    Place = N div NumWidth,
    NumDigit = N rem NumWidth,
    {StartNum+Place,NumDigit+1}.
