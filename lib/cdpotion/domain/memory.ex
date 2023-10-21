defmodule CDPotion.Domain.Memory do
  use CDPotion.Utils
  @typedoc "Executable module information"
  @type module_info :: %{
          baseAddress: String.t(),
          name: String.t(),
          size: number(),
          uuid: String.t()
        }

  @typedoc "Memory pressure level."
  @type pressure_level :: :moderate | :critical

  @typedoc "Array of heap profile samples."
  @type sampling_profile :: %{
          modules: list(CDPotion.Domain.Memory.module_info()),
          samples: list(CDPotion.Domain.Memory.sampling_profile_node())
        }

  @typedoc "Heap profile sample."
  @type sampling_profile_node :: %{
          size: number(),
          stack: list(String.t()),
          total: number()
        }

  @doc """

  """
  @spec get_dom_counters() :: {String.t(), map()}
  def get_dom_counters() do
    {"Memory.getDOMCounters", %{}}
  end

  @doc """

  """
  @spec prepare_for_leak_detection() :: {String.t(), map()}
  def prepare_for_leak_detection() do
    {"Memory.prepareForLeakDetection", %{}}
  end

  @doc """
  Simulate OomIntervention by purging V8 memory.
  """
  @spec forcibly_purge_java_script_memory() :: {String.t(), map()}
  def forcibly_purge_java_script_memory() do
    {"Memory.forciblyPurgeJavaScriptMemory", %{}}
  end

  @doc """
  Enable/disable suppressing memory pressure notifications in all processes.
  ## Parameters:
    - (Required) `suppressed`: If true, memory pressure notifications will be suppressed.
  """
  @spec set_pressure_notifications_suppressed(boolean()) :: {String.t(), map()}
  def set_pressure_notifications_suppressed(suppressed) do
    params = as_query([{"suppressed", suppressed}])
    {"Memory.setPressureNotificationsSuppressed", params}
  end

  @doc """
  Simulate a memory pressure notification in all processes.
  ## Parameters:
    - (Required) `level`: Memory pressure level of the notification.
  """
  @spec simulate_pressure_notification(CDPotion.Domain.Memory.PressureLevel) ::
          {String.t(), map()}
  def simulate_pressure_notification(level) do
    params = as_query([{"level", level}])
    {"Memory.simulatePressureNotification", params}
  end

  @doc """
  Start collecting native memory profile.
  ## Parameters:
    - (Optional) `sampling_interval`: Average number of bytes between samples.
  - (Optional) `suppress_randomness`: Do not randomize intervals between samples.
  """
  @spec start_sampling(integer(), boolean()) :: {String.t(), map()}
  def start_sampling(sampling_interval \\ nil, suppress_randomness \\ nil) do
    params =
      as_query([
        {"samplingInterval", sampling_interval},
        {"suppressRandomness", suppress_randomness}
      ])

    {"Memory.startSampling", params}
  end

  @doc """
  Stop collecting native memory profile.
  """
  @spec stop_sampling() :: {String.t(), map()}
  def stop_sampling() do
    {"Memory.stopSampling", %{}}
  end

  @doc """
  Retrieve native memory allocations profile
  collected since renderer process startup.
  """
  @spec get_all_time_sampling_profile() :: {String.t(), map()}
  def get_all_time_sampling_profile() do
    {"Memory.getAllTimeSamplingProfile", %{}}
  end

  @doc """
  Retrieve native memory allocations profile
  collected since browser process startup.
  """
  @spec get_browser_sampling_profile() :: {String.t(), map()}
  def get_browser_sampling_profile() do
    {"Memory.getBrowserSamplingProfile", %{}}
  end

  @doc """
  Retrieve native memory allocations profile collected since last
  `startSampling` call.
  """
  @spec get_sampling_profile() :: {String.t(), map()}
  def get_sampling_profile() do
    {"Memory.getSamplingProfile", %{}}
  end
end
