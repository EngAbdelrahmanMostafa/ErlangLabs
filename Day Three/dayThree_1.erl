-module(dayThree_1).
-export([hello/0,start/0,print/0,start_demo/0,wait/0]).
%-----------day Three ----------

%rpc:call('N2@abdelrahmanmostafa',dayThree_2,hello,[]).
%rpc:call(anotherNodeName,module name,function name,[])
% case L of 
%    [] ->
%        hjhj;
%    [H|T]->
%            recallself wih new parameter;
%    _ ->
%           default value
%end.

%if 
%  x<5 ->
%        do something;
%  true ->
%        else
%end.
%---------------------fun----------------
%MF=fun(X)-> X+1 end.
%used in lists:map(fun(),[]). and it will run in the fg
%also in background we have lists:forEach(fun,[]).

%-------------------------lesson4-------------
%processes do their chunck of code then die without residual
% P=spawn(io,format,["hell no ~n"]).
% P=spawn(moduke_name,function_Name,[arguments of the function]).
% so you create a new process

%messages between processes are sent ! ---> which called bang 
%Pid ! Msg ::: Msg can be any erlang term
% so where can i get the Pid you can use self(). 
%.

%------------------------functions to try rpc between two nodes----
hello()->
    io:format("Hello from9 node 1~n").
%----------------------end of use with the other  erl module-------

start_demo()->
    io:format("my PiD ~p by function start ~n",[self()]),
    spawn(dayThree_1,print,[]),
    ok. 
print()->
    io:format("my pid is ~p and i have been respawned by start functin my name is print ~n",[self()]).
%-------------------------------End of respawn Example---------------------------------------

%------------------------Exercise 3.A-------------------------
start()->
    spawn(dayThree_1, wait, []).
wait()->
  io:format("my self Pid is ~p~n",[self()]),
    receive 
        stop ->
            terminated;
        Msg ->
            io:format("Message recieved ~p~n",[Msg]),
        wait()
    end.
%-----------------------End of exercise 3.A-------------

