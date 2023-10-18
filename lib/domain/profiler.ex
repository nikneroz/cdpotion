defmodule CDPotion.Domain.Profiler do

@doc """
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Collect coverage data for the current isolate. The coverage data may be incomplete due to
garbage collection.
"""
def get_best_effort_coverage() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Changes CPU profiler sampling interval. Must be called before CPU profiles recording started.
## Parameters:
- `interval:integer`: New sampling interval in microseconds.
"""
def set_sampling_interval(interval) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def start() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enable precise code coverage. Coverage data for JavaScript executed before enabling precise code
coverage may be incomplete. Enabling prevents running optimized code and resets execution
counters.
## Parameters:
- `callCount:boolean`: (Optional) Collect accurate call counts beyond simple 'covered' or 'not covered'.
  - `detailed:boolean`: (Optional) Collect block-based coverage.
  - `allowTriggeredUpdates:boolean`: (Optional) Allow the backend to send updates on its own initiative
"""
def start_precise_coverage(call_count \\ nil, detailed \\ nil, allow_triggered_updates \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def stop() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disable precise code coverage. Disabling releases unnecessary execution count records and allows
executing optimized code.
"""
def stop_precise_coverage() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Collect coverage data for the current isolate, and resets execution counters. Precise code
coverage needs to have started.
"""
def take_precise_coverage() do
  execute(session, :navigate, %{"url" => url})
end
end