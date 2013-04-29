-module(euler33).

-export([ run/0
        , simplify/1]).

run() ->
    curious().

curious() ->
    Res = curious(lists:seq(11,99)),
    F = fun({N,D}, {NS,DS}) ->
                {N*NS,D*DS}
        end,
    ND = lists:foldl(F, {1,1}, Res),
    simplify(ND).

curious([]) ->
    [];
curious([AH|AT]) ->
    curious(AH, lists:seq(AH+1,99)) ++ curious(AT).

curious(_Nom, []) ->
    [];
curious(Nom, [DH|DT]) ->
    case is_curious(Nom, DH) of
        true ->
            [{Nom,DH}|curious(Nom, DT)];
        false ->
            curious(Nom, DT)
    end.

is_curious(_Nom, Denom) when Denom rem 10 =:= 0 ->
    false;
is_curious(N, D) ->
    N1 = N div 10,
    N2 = N rem 10,
    D1 = D div 10,
    D2 = D rem 10,
    R  = N / D,
    (N1 =:= D1 andalso N2 / D2 == R) orelse
    (N1 =:= D2 andalso N2 / D1 == R) orelse
    (N2 =:= D1 andalso N1 / D2 == R) orelse
    (N2 =:= D2 andalso N1 / D1 == R).

simplify({N,D}) when N < D ->
    simplify({N,D},2).

simplify({N,D},X) when X > N ->
    {N,D};
simplify({N,D},X) when N rem X =:= 0, D rem X =:= 0 ->
    simplify({N div X, D div X}, X);
simplify(ND,X) ->
    simplify(ND,X+1).
