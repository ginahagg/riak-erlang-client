%% -------------------------------------------------------------------
%%
%% riakc_utils: erlang client utils
%%
%% Copyright (c) 2016 Basho Technologies, Inc.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(riakc_utils).

-export([wait_for_list/1]).

%% @doc Wait for the results of a listing operation
wait_for_list(ReqId) ->
    wait_for_list(ReqId, []).
wait_for_list(ReqId, Acc) ->
    receive
        {ReqId, done} -> {ok, lists:flatten(Acc)};
        {ReqId, {error, Reason}} -> {error, Reason};
        {ReqId, {_, Res}} -> wait_for_list(ReqId, [Res|Acc])
    end.