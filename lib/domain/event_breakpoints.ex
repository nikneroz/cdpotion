defmodule CDPotion.Domain.EventBreakpoints do
  @doc """
  Sets breakpoint on particular native event.
  ## Parameters:
  - `eventName:string`: Instrumentation name to stop on.
  """
  def set_instrumentation_breakpoint(event_name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Removes breakpoint on particular native event.
  ## Parameters:
  - `eventName:string`: Instrumentation name to stop on.
  """
  def remove_instrumentation_breakpoint(event_name) do
    execute(session, :navigate, %{"url" => url})
  end
end
