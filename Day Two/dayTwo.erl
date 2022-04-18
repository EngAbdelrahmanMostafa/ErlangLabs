-module(dayTwo).
-export([f2c/1,c2f/1,convert/1,perimeter/1,sum/1,nth/2,sublist/2]).
%--------------Lists operation and appending------------
%[X is considerd as 1 term | Y should be alist].
%[H|T]. Head is a term T is a List
%Strings are represented as a list of ascii values
% so "abcd"=[97,98,99,100]. 
%--------example ----------------- 
%36> X="abdo".
%37> [0|X].
%[0,97,98,100,111]
%38> [X|9].
%["abdo"|9]
%----------------end of example--------------
%--------------pattern Matching------------
%{A,B}={$A,$B}.
%[H|T]. yu can use operation on Head then use pattern matching 
%to create a ew head and tail
%[H1,T1]=T. and so on.

%{_A,_B,C}={1,2,3}. tell the compliler that you don't care about A and B and you will not be able to use it
% date(). ,, length([]). ,, size({}).
%time(). list_to_tuple([1,2,3,4]).
%integer _to_list(2234).
%tuple_to_list({}).
%is_list([1|2]). don't append item on a list tail is must be alist
%lists:nth(1,[1|2]).
%-------------------------lesson 3 ----------
%Gaurd to prevent excuting the function if the condition is falsey
%like factorial(N) when N>0 ->
%Gaurds for data types 
%is_atom/1
%is_integer/1
%is_list/1
%is_tuple/1
%also logical operators
%not and or xor
%or even a sequence of them
% ',' is and ';' is or

%Recursion








%------------------Temperature Functions--------------
f2c(F)->
    C=(F-32)*5/9,
   % io:format("the tempreture in Celsius is ~p~n",[C]),
    C.
c2f(C) ->
    F=(9*C/5)+32,
 %   io:format("the tempreture in Fahrenheit is ~p~n",[F]),
    F.
convert(T) ->
    {K,T_V}=T,
    case K of 
        c -> O_T={f,c2f(T_V)};
        f -> O_T={c,f2c(T_V)}
    end,
    O_T.
%--------------------End of tempreture Functions------

%---------------------Exercise 1.D--------------
perimeter(F) ->
    S=size(F),
    perimeterCalc(S,F).

perimeterCalc(2,F)->
    {K,F_V}=F,
    case K of 
        square -> P=F_V*4;
        circle -> P=F_V*3.14*2
    end,
    io:format("the perimeter of ~p shape is ~p ~n",[K,P]);
perimeterCalc(4,F) ->
    {K,F_V1,F_V2,F_V3}=F,
    case K of 
        triangle -> P=F_V1+F_V2+F_V3
    end,
    io:format("the perimeter of ~p shape is ~p ~n",[K,P]).
%------------------------end of excersize 1.D---------

%----------------------iteration Function-----------
sum(1)->
    1;
sum(N)->
    N+sum(N-1).
%------------------------end of sum function-------

%--------------------nth of a list------------------
nth(1,L)->
    [H|_]=L,
    H;
nth(N, L) when N>0 , N<length(L)+1->
    [_|T]=L,
    nth(N-1,T);
nth(_,_)->
    io:format("sorry there is an error~n").
%------------------End of nth of a list ------------

%---------------_Excersize 2B recursion-------------
sublist([H|_],1)->
    [H];
sublist([H|L],N)->
   [H|sublist(L,N-1)].
%---------------------End of Recursion Example-------


