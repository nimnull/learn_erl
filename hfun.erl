-module(hfun).
-compile(export_all).

% Try processes communication

ping() ->
    Pid = spawn(fun pong/0),
    Pid ! {ping, self()},
    ping(Pid)
.

ping(Pid) ->
    receive
        {pong, Pid} ->
            io:format("pong!~n"),
            timer:sleep(random:uniform(1200)),
            Pid ! {ping, self()},
            ping(Pid)
    after 1200 ->
        io:format("ping finished~n")
    end
.

pong() ->
    receive
        {ping, Pid} ->
            io:format("ping!~n"),
            timer:sleep(random:uniform(1200)),
            Pid ! {pong, self()},
            pong()
    after 1200 ->
        io:format("pong finished~n")
    end
.

% From the lessons learned about high ordered functions:

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H, Start), T).

run() ->
    L = [1,7,3,5,9,0,2,3,4],
    lists:any(
        fun
            (A) when A < 9 -> true;
            (_) -> false
        end
        , L
    )
.
