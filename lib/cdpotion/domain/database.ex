defmodule CDPotion.Domain.Database do
  use CDPotion.Utils

  @doc """
  Disables database tracking, prevents database events from being sent to the client.
  """
  def disable() do
    {"Database.disable", %{}}
  end

  @doc """
  Enables database tracking, database events will now be delivered to the client.
  """
  def enable() do
    {"Database.enable", %{}}
  end

  @doc """
  ## Parameters:
    - `databaseId:DatabaseId`: description not provided :(
    - `query:string`: description not provided :(
  """
  def execute_sql(database_id, query) do
    params = as_query([{"databaseId", database_id}, {"query", query}])
    {"Database.executeSQL", params}
  end

  @doc """
  ## Parameters:
    - `databaseId:DatabaseId`: description not provided :(
  """
  def get_database_table_names(database_id) do
    params = as_query([{"databaseId", database_id}])
    {"Database.getDatabaseTableNames", params}
  end
end