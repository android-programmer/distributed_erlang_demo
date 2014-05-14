%%%-------------------------------------------------------------------
%%% @author P.Y.
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. May 2014 5:25 PM
%%%-------------------------------------------------------------------
-module(facserver).
-author("P.Y.").

%% API
-compile([export_all]).

server()->
  register(?MODULE,self()),
  facLoop().

facLoop() ->
  receive
    {Pid , N}->
      io:format("receive:~p~n",[N]),
      Pid ! {ok,fac(N)}
  end,
  facLoop().

fac(1) -> 1;
fac(N) -> N * fac(N - 1).
