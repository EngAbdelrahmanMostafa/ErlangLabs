-module(dayFour_1).
-export([start/1,init/1]).

start(N)->
    spawn (dayFour_1,init ,[N]).
init(N)->
    Epid =dayFour:start(),
    loop(N,Epid).
loop(0, Epid)->
    Epid ! stop,
    io:format("Echo passed this test ~n",[]);
loop(N,Epid)->
    Epid ! {self(),N},
    io:format("sending message N= ~p~n",[N]),
    receive
        stop ->
            true;
        {Epid, N}->
            loop(N-1,Epid)
        end.