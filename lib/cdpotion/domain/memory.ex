defmodule CDPotion.Domain.Memory do
  use CDPotion.Utils

  @doc """
  """
  def get_dom_counters() do
    {"Memory.getDOMCounters", %{}}
  end

  @doc """
  """
  def prepare_for_leak_detection() do
    {"Memory.prepareForLeakDetection", %{}}
  end

  @doc """
  Simulate OomIntervention by purging V8 memory.
  """
  def forcibly_purge_java_script_memory() do
    {"Memory.forciblyPurgeJavaScriptMemory", %{}}
  end

  @doc """
  Enable/disable suppressing memory pressure notifications in all processes.
  ## Parameters:
    - `suppressed:boolean`: If true, memory pressure notifications will be suppressed.
  """
  def set_pressure_notifications_suppressed(suppressed) do
    params = as_query([{"suppressed", suppressed}])
    {"Memory.setPressureNotificationsSuppressed", params}
  end

  @doc """
  Simulate a memory pressure notification in all processes.
  ## Parameters:
    - `level:PressureLevel`: Memory pressure level of the notification.
  """
  def simulate_pressure_notification(level) do
    params = as_query([{"level", level}])
    {"Memory.simulatePressureNotification", params}
  end

  @doc """
  Start collecting native memory profile.
  ## Parameters:
    - `samplingInterval:integer`: (Optional) Average number of bytes between samples.
    - `suppressRandomness:boolean`: (Optional) Do not randomize intervals between samples.
  """
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
  def stop_sampling() do
    {"Memory.stopSampling", %{}}
  end

  @doc """
  Retrieve native memory allocations profile
  collected since renderer process startup.
  """
  def get_all_time_sampling_profile() do
    {"Memory.getAllTimeSamplingProfile", %{}}
  end

  @doc """
  Retrieve native memory allocations profile
  collected since browser process startup.
  """
  def get_browser_sampling_profile() do
    {"Memory.getBrowserSamplingProfile", %{}}
  end

  @doc """
  Retrieve native memory allocations profile collected since last
  `startSampling` call.
  """
  def get_sampling_profile() do
    {"Memory.getSamplingProfile", %{}}
  end
end
