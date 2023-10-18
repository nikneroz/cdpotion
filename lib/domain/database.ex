defmodule CDPotion.Domain.Database do
  @doc """
  Disables database tracking, prevents database events from being sent to the client.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables database tracking, database events will now be delivered to the client.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  ## Parameters:
  - `databaseId:DatabaseId`: description not provided :(
    - `query:string`: description not provided :(
  """
  def execute_sql(database_id, query) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  ## Parameters:
  - `databaseId:DatabaseId`: description not provided :(
  """
  def get_database_table_names(database_id) do
    execute(session, :navigate, %{"url" => url})
  end
end
