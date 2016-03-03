-module(find_SUITE).

%% CT
-export([
  all/0,
  init_per_suite/1,
  end_per_suite/1
]).

%% Test Cases
-include_lib("mixer/include/mixer.hrl").
-mixin([{sumo_find_test_helper, [find_by_sort/1, find_all_sort/1]}]).

-type config() :: [{atom(), term()}].

%%%=============================================================================
%%% Common test
%%%=============================================================================

-spec all() -> [atom()].
all() -> [find_by_sort, find_all_sort].

-spec init_per_suite(config()) -> config().
init_per_suite(Config) ->
  {ok, _} = application:ensure_all_started(sumo_db_mongo),
  Module = sumo_test_people_mongo,
  sumo_find_test_helper:init_store(Module),
  [{module, Module} | Config].

-spec end_per_suite(config()) -> config().
end_per_suite(Config) ->
  Config.
