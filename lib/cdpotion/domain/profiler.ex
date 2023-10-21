defmodule CDPotion.Domain.Profiler do
  use CDPotion.Utils
  @typedoc "Coverage data for a source range."
  @type coverage_range :: %{
          count: integer(),
          endOffset: integer(),
          startOffset: integer()
        }

  @typedoc "Coverage data for a JavaScript function."
  @type function_coverage :: %{
          functionName: String.t(),
          isBlockCoverage: boolean(),
          ranges: list(CDPotion.Domain.Profiler.coverage_range())
        }

  @typedoc "Specifies a number of samples attributed to a certain source position."
  @type position_tick_info :: %{
          line: integer(),
          ticks: integer()
        }

  @typedoc "Profile."
  @type profile :: %{
          endTime: number(),
          nodes: list(CDPotion.Domain.Profiler.profile_node()),
          samples: list(integer()) | nil,
          startTime: number(),
          timeDeltas: list(integer()) | nil
        }

  @typedoc "Profile node. Holds callsite information, execution statistics and child nodes."
  @type profile_node :: %{
          callFrame: CDPotion.Domain.Runtime.call_frame(),
          children: list(integer()) | nil,
          deoptReason: String.t() | nil,
          hitCount: integer() | nil,
          id: integer(),
          positionTicks: list(CDPotion.Domain.Profiler.position_tick_info()) | nil
        }

  @typedoc "Coverage data for a JavaScript script."
  @type script_coverage :: %{
          functions: list(CDPotion.Domain.Profiler.function_coverage()),
          scriptId: CDPotion.Domain.Runtime.script_id(),
          url: String.t()
        }

  @doc """

  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Profiler.disable", %{}}
  end

  @doc """

  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Profiler.enable", %{}}
  end

  @doc """
  Collect coverage data for the current isolate. The coverage data may be incomplete due to
  garbage collection.
  """
  @spec get_best_effort_coverage() :: {String.t(), map()}
  def get_best_effort_coverage() do
    {"Profiler.getBestEffortCoverage", %{}}
  end

  @doc """
  Changes CPU profiler sampling interval. Must be called before CPU profiles recording started.
  ## Parameters:
    - `interval`:New sampling interval in microseconds.
  """
  @spec set_sampling_interval(integer()) :: {String.t(), map()}
  def set_sampling_interval(interval) do
    params = as_query([{"interval", interval}])
    {"Profiler.setSamplingInterval", params}
  end

  @doc """

  """
  @spec start() :: {String.t(), map()}
  def start() do
    {"Profiler.start", %{}}
  end

  @doc """
  Enable precise code coverage. Coverage data for JavaScript executed before enabling precise code
  coverage may be incomplete. Enabling prevents running optimized code and resets execution
  counters.
  ## Parameters:
    - `call_count`:(Optional) Collect accurate call counts beyond simple 'covered' or 'not covered'.
  - `detailed`:(Optional) Collect block-based coverage.
  - `allow_triggered_updates`:(Optional) Allow the backend to send updates on its own initiative
  """
  @spec start_precise_coverage(boolean(), boolean(), boolean()) :: {String.t(), map()}
  def start_precise_coverage(call_count \\ nil, detailed \\ nil, allow_triggered_updates \\ nil) do
    params =
      as_query([
        {"callCount", call_count},
        {"detailed", detailed},
        {"allowTriggeredUpdates", allow_triggered_updates}
      ])

    {"Profiler.startPreciseCoverage", params}
  end

  @doc """

  """
  @spec stop() :: {String.t(), map()}
  def stop() do
    {"Profiler.stop", %{}}
  end

  @doc """
  Disable precise code coverage. Disabling releases unnecessary execution count records and allows
  executing optimized code.
  """
  @spec stop_precise_coverage() :: {String.t(), map()}
  def stop_precise_coverage() do
    {"Profiler.stopPreciseCoverage", %{}}
  end

  @doc """
  Collect coverage data for the current isolate, and resets execution counters. Precise code
  coverage needs to have started.
  """
  @spec take_precise_coverage() :: {String.t(), map()}
  def take_precise_coverage() do
    {"Profiler.takePreciseCoverage", %{}}
  end
end
