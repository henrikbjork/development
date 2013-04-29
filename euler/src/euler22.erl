-module(euler22).

-export([run/0]).

run() ->
    Names = names_from_file('names.txt'),
    SortedNames = lists:usort(Names),
    score(SortedNames, 1, 0).

names_from_file(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    String = binary_to_list(Binary),
    Names = string:tokens(String, ","),
    trim_names(Names).

trim_names(Names) ->
    F = fun(Name) -> string:strip(Name, both, $") end,
    lists:map(F, Names).

score([], _Index, Score) ->
    Score;
score([Head|Tail], Index, Score) ->
    NameScore = score_name(Head, Index),
    score(Tail, Index + 1, Score + NameScore).

score_name(Name, Index) ->
    Index * score_name(Name).

score_name(Name) ->
    F = fun(Char, Score) ->
                Score + char_score(Char)
        end,
    lists:foldl(F, 0, Name).

char_score(Char) ->
    Char - $A + 1.
