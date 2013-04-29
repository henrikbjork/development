-module(euler67).

-export([ run/0
        , test/0
        ]).

run() ->
    Data = read_data_from_file("triangle.txt"),
    euler18:run(Data).

test() ->
    ["23","02","01"] = parse_line("23 02 01\n"),
    ok.

read_data_from_file(Filename) ->
    {ok, File} = file:open(Filename, [read]),
    RawLines = lists:reverse(read_lines(File, [])),
    lists:map(fun parse_line/1, RawLines).

read_lines(File, Acc) ->
    case file:read_line(File) of
        eof                -> Acc;
        {ok, Line} -> read_lines(File, [Line|Acc])
    end.

parse_line(Line) ->
    Tokens = string:tokens(string:strip(Line, right, $\n), " "),
    lists:map(fun erlang:list_to_integer/1, Tokens).
