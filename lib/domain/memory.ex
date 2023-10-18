defmodule CDPotion.Domain.Memory do

@doc """
"""
def get_dom_counters() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def prepare_for_leak_detection() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Simulate OomIntervention by purging V8 memory.
"""
def forcibly_purge_java_script_memory() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enable/disable suppressing memory pressure notifications in all processes.
## Parameters:
  - `suppressed:boolean`: If true, memory pressure notifications will be suppressed.
"""
def set_pressure_notifications_suppressed(suppressed) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Simulate a memory pressure notification in all processes.
## Parameters:
  - `level:PressureLevel`: Memory pressure level of the notification.
"""
def simulate_pressure_notification(level) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Start collecting native memory profile.
## Parameters:
  - `samplingInterval:integer`: (Optional) Average number of bytes between samples.
  - `suppressRandomness:boolean`: (Optional) Do not randomize intervals between samples.
"""
def start_sampling(sampling_interval \\ nil, suppress_randomness \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Stop collecting native memory profile.
"""
def stop_sampling() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Retrieve native memory allocations profile
collected since renderer process startup.
"""
def get_all_time_sampling_profile() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Retrieve native memory allocations profile
collected since browser process startup.
"""
def get_browser_sampling_profile() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Retrieve native memory allocations profile collected since last
`startSampling` call.
"""
def get_sampling_profile() do
  execute(session, :navigate, %{"url" => url})
end
end