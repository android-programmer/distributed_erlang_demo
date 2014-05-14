%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. May 2014 8:47 PM
%%%-------------------------------------------------------------------
-module(hello_test).
-author("root").
-include_lib("eunit/include/eunit.hrl").

%% API
-export([hello/1]).

hello(Name) ->
  io:format("Hello ~p~n", [Name]).

treeToList({leaf, N}) ->
  [2, N];

treeToList({node, T1, T2}) ->
  TTL1 = treeToList(T1),
  [Size1|_] = TTL1,
  TTL2 = treeToList(T2),
  [Size2|_] = TTL2,
  [Size1 + Size2 + 1 | TTL1 ++ TTL2].

listToTree([2, N]) ->
  {leaf, N};

listToTree([_|Code]) ->
  case Code of
    [M|_] ->
      {Code1, Code2} = lists:split(M, Code),
      {node, listToTree(Code1), listToTree(Code2)}
  end.

tree0()->
  {leaf, ant}.

tree1()->
  {node,
   {node,
    {leaf,cat},
    {node,
     {leaf,dog},
     {leaf,emu}
    }
   },
   {leaf,fish}
  }.

leaf_test()->
  ?assertEqual(tree0(),listToTree(treeToList(tree0()))).

node_test()->
  ?assertEqual(tree1(),listToTree(treeToList(tree1()))).
