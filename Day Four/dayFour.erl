-module(dayFour).
-export([start/0,init/0,sleep/1,startPong/0,startPing/1,initPing/1,initPong/0,startMonitoring/0,initMonitor/0,startSupervised/0,initSupervised/0]).
-export([startMaster/1,initMaster/1,to_slave/2,slave/0]).

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

%Linking between processes for further connection
%first method is using link(Pid).
%or when spawning other function use spawn_link(Module, Function, Args).
%to remove the link use unlink(Pid).

%if first processes exited with normal termination the second one will ignore the exit signal 
%if process a exited with upnormally the next process will exit with the same reason
%how to force exit another process use exit (DestPid, Reason).
%process_flag(trap_exit,true). protection against exit signal and convert it to a message
% the message structure {'EXIT',Pid,Reasons}.
% if the reason in trap is 'kill' it will die forcefully 

% |   Process Flag        |   Normal Reason   |                           |   Abnormal Reason           |                   |
% |                       |                   | Reason: |            Kill             |            Other Reason             |
% |   Not trapping Exit   |   Ignores signal  |         |  Termiantes Reason:Kill     |  Terminates with the Other Reason   |
% |    Trapping Exit      |  Receives Message:|         |  Terminates Reason =killed  |           Receives Message:         |
% |                       |{'EXIT',Pid,normal}|         |                             |           {'Exit',Pid,Other}        |
                                                                       
% ------------------------------------------------------------------------------

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

%--------------------Ping-Pong Example-------------

%-------------------ping Code ---------------------
startPing(M) ->
    Pid=spawn (dayFour,initPing,[M]),
    register(ping,Pid).
initPing(M)->
    dayFour:startPong(),
    loopPing(M).
loopPing(0)->
    pong ! stop,
    io:format("Ping Pong processes finished ~n",[]);
loopPing(M)->
    pong ! M ,
    io:format("Ping for : ~p time ~n",[M]),
    receive
        stop ->
            true;
        M ->
            loopPing (M-1)
    end.

%------------------pong code-----------------------
startPong() ->
    Pid=spawn(dayFour,initPong,[]),
    register(pong,Pid).
initPong()->
    loopPong().
loopPong()->
    receive
        stop ->
            true;
        Msg -> 
            ping ! Msg ,
            io:format("original message N= ~p~n",[Msg]),
            loopPong()
    end.
% ----------------End of Ping Pong Example -------------

%-----------------Supervised Process-------------------

startMonitoring() ->
    Pid=spawn(dayFour, initMonitor, []),
    register(monitor,Pid).
initMonitor()->
    process_flag(trap_exit,true),
    dayFour:startSupervised(),
    loopMonitor().
loopMonitor()->
    
    Supervised_Id=whereis(supervised),
    io:format("Supervised_Id ~p~n",[Supervised_Id]),
    erlang:monitor(monitor,supervised),
    receive
        init ->
            supervised ! error;
        Msg->
            io:format("the reason of termination is ~p :~n",Msg),
            true
        
    end,
    unregister(monitor).

startSupervised()->
    Pid=spawn(dayFour,initSupervised,[]),
    register(supervised,Pid).
initSupervised()->
    link(whereis(monitor)),
    loopSupervised().
loopSupervised()->
    monitor ! init,
    receive
        error ->
            a=ab
    end,
    unregister(supervised).
%----------------------------------------End of monitoring Process------------
%--------------------Master and slaves ------------------
startMaster(N)->
    SlavesList=spawnSlaves(N,[]),
    Pid=spawn (dayFour,initMaster,[SlavesList]),
    register(master,Pid).
spawnSlaves (0,SlavesList) ->
    SlavesList;
spawnSlaves (N,SlavesList) ->
    SPID= spawn (dayFour,slave,[]),
    io:format("now spawning  ~p in ~p~n",[SPID,SlavesList]),
    spawnSlaves(N-1,[SPID|SlavesList]).

initMaster(SlavesList) ->
    loopMaster(SlavesList).

loopMaster(SlavesList) ->
    
    receive 
        {die , N}->
            lists:nth(N,SlavesList)!die ,
            NL=lists:delete(lists:nth(N,SlavesList),SlavesList),
            io:format("slaveList after delete ~p~n",[NL]),
            SL=spawnSlaves(1,NL),
             io:format("slaveList after spawning new slave ~p~n",[SL]),
            loopMaster(SL);
        {Msg , N} ->
            lists:nth(N,SlavesList)! Msg ,
            loopMaster(SlavesList)
    end.
slave() ->
    receive 
        die ->
            io:format("Slave ~p will die~n", [self()]),
            dead;
        Msg ->
            io:format("Slave ~p got message ~p~n", [self(), Msg]),
            slave()
    end.

to_slave(die,N)->
    master ! {die , N},
    {die , N};
to_slave(Msg,N)->
    master ! {Msg,N},
    {Msg,N}.
%------------------------End of masters and slaves example------------------