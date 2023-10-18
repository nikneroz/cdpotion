defmodule CDPotion.Domain.IndexedDB do
  @doc """
  Clears all entries from an object store.
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
    - `databaseName:string`: Database name.
    - `objectStoreName:string`: Object store name.
  """
  def clear_object_store(
        security_origin \\ nil,
        storage_key \\ nil,
        storage_bucket \\ nil,
        database_name,
        object_store_name
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Deletes a database.
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
    - `databaseName:string`: Database name.
  """
  def delete_database(
        security_origin \\ nil,
        storage_key \\ nil,
        storage_bucket \\ nil,
        database_name
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Delete a range of entries from an object store
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
    - `databaseName:string`: description not provided :(
    - `objectStoreName:string`: description not provided :(
    - `keyRange:KeyRange`: Range of entry keys to delete
  """
  def delete_object_store_entries(
        security_origin \\ nil,
        storage_key \\ nil,
        storage_bucket \\ nil,
        database_name,
        object_store_name,
        key_range
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disables events from backend.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables events from backend.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests data from object store or index.
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
    - `databaseName:string`: Database name.
    - `objectStoreName:string`: Object store name.
    - `indexName:string`: Index name, empty string for object store data requests.
    - `skipCount:integer`: Number of records to skip.
    - `pageSize:integer`: Number of records to fetch.
    - `keyRange:KeyRange`: (Optional) Key range.
  """
  def request_data(
        security_origin \\ nil,
        storage_key \\ nil,
        storage_bucket \\ nil,
        database_name,
        object_store_name,
        index_name,
        skip_count,
        page_size,
        key_range \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets metadata of an object store.
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
    - `databaseName:string`: Database name.
    - `objectStoreName:string`: Object store name.
  """
  def get_metadata(
        security_origin \\ nil,
        storage_key \\ nil,
        storage_bucket \\ nil,
        database_name,
        object_store_name
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests database with given name in given frame.
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
    - `databaseName:string`: Database name.
  """
  def request_database(
        security_origin \\ nil,
        storage_key \\ nil,
        storage_bucket \\ nil,
        database_name
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests database names for given security origin.
  ## Parameters:
  - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
  """
  def request_database_names(security_origin \\ nil, storage_key \\ nil, storage_bucket \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end
end
