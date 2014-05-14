%%%-------------------------------------------------------------------
%%% @author P.Y.
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. May 2014 12:22 PM
%%%-------------------------------------------------------------------
-module(dist2).
-author("P.Y.").

%% API
-export([s/1,remote_call/2,setup/0]).


s(Name) ->
  register(Name,self()),
  loop().

loop()->
  receive
    {M,Pid}->
      io:format("received from:~p, message:~p~n",[Pid,M]),
      Pid ! M
  end,
  loop().

setup()->
  process_flag(trap_exit,true),
  spawn_link('bar@py-3570R-370R-470R-450R-510R',facserver,server,[]).

remote_call(Message,Node)->
  {facserver, Node} ! {self(),Message},
  receive
    {ok, Res} ->
      Res
  after 1 ->
    {error,timeout}
  end.


