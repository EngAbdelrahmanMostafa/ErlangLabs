-module(dayFour).
-export([start/0,init/0,sleep/1]).

%-----------------day4 begins --------
% process pattern
%start() --->for spawning initialization function
% to avoid the hassle of the pid you can use alias an save it with 
%the corresponding PID in a register
%register(iti,Pid)
%iti! hello
%to make function wait for a period use after like receive .
%after 1000 ->
        %true
        %end.

% message protocol 
%{request, ClientPid,alloc}->{reply, Resource}
%{request, ClientPid, {free,Resource}}->{reply,ok}




%--------------------echo original function------------------
start() ->
    spawn(dayFour,init,[]).
init()->
    loop().
loop()->
    receive 
        stop ->
            true;
        {Pid, Msg} ->
            Pid ! {self(),Msg},
            io:format("original message N= ~p~n",[Msg]),
            loop()
    end.
%---------------------End of Echo Original Function------------

%------------------sleep Function-------
sleep(T)->
    receive
    after
        T ->
            io:format("time out function ~n")
    end.
%---------------End of Sleep Function -------------

%--------------------
