-module (dayOne).
-export([testFn/0,factorial/1,grader/1]).
%comment in erlang
% for askii $A
% atom is a constant string 
%parameter can equal an atom
%f(). unbound all variables
% tuples{} fixed no of items together that are related 
%size({1,2,3}). to get no of items of tuples items
%lists [] is alinked list variable amount of items
%length([a,b,c]). to get no of items of list items
%the parameters are uppercase but atoms are lower case
%----------------testing export and private functions----------------------
testFn () ->
    privateFunction(),
    io:format ("it's working ~n").

privateFunction() ->
    io:format ("private line ~n").
%-----------------factorial using recursion----------------------
factorial(0) ->
    1;
factorial (X) ->
    X * factorial(X-1).
%------------------grader function---------------------
grader(10) ->
    io:format("Full Mark~n");
grader(9) ->
    io:format("Very Good ~n");
grader(N) ->
    io:format("you got ~p~n",[N]).
%-------------------------------------------------

