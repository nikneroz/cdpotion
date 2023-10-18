defmodule CDPotion.Domain.SystemInfo do
  use CDPotion.Utils

  @doc """
  Returns information about the system.
  """
  def get_info() do
    {"SystemInfo.getInfo", %{}}
  end

  @doc """
  Returns information about the feature state.
  ## Parameters:
    - `featureState:string`: description not provided :(
  """
  def get_feature_state(feature_state) do
    params = as_query([{"featureState", feature_state}])
    {"SystemInfo.getFeatureState", params}
  end

  @doc """
  Returns information about all running processes.
  """
  def get_process_info() do
    {"SystemInfo.getProcessInfo", %{}}
  end
end
