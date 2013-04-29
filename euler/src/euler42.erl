-module(euler42).

-export([run/0]).

run() ->
    {ok, Bin} = file:read_file("words.txt"),
    List = binary_to_list(Bin),
    Words = remove_quotes(string:tokens(List,",")),
    TriNums = tri_nums(100),
    count_tri_words(TriNums, Words).

count_tri_words(TriNums, Words) ->
    F = fun(Word, N) ->
                case is_tri_word(Word, TriNums) of
                    true  -> N+1;
                    false -> N
                end
        end,
    lists:foldl(F, 0, Words).

is_tri_word(Word, TriNums) ->
    lists:member(word_sum(Word), TriNums).

word_sum(Word) ->
    F = fun(C, Sum) -> Sum + C - $A + 1 end,
    lists:foldl(F, 0, Word).

tri_nums(N) ->
    F = fun(X, [H|_]=L) -> [H+X|L] end,
    lists:foldl(F, [1], lists:seq(2,N)).

remove_quotes(Words) ->
    F = fun(Word) ->
                lists:delete($", lists:delete($", Word))
        end,
    lists:map(F, Words).
