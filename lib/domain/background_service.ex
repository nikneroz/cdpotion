defmodule CDPotion.Domain.BackgroundService do
  @doc """
  Enables event updates for the service.
  ## Parameters:
    - `service:ServiceName`: description not provided :(
  """
  def start_observing(service) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disables event updates for the service.
  ## Parameters:
    - `service:ServiceName`: description not provided :(
  """
  def stop_observing(service) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Set the recording state for the service.
  ## Parameters:
    - `shouldRecord:boolean`: description not provided :(
    - `service:ServiceName`: description not provided :(
  """
  def set_recording(should_record, service) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Clears all stored data for the service.
  ## Parameters:
    - `service:ServiceName`: description not provided :(
  """
  def clear_events(service) do
    execute(session, :navigate, %{"url" => url})
  end
end
