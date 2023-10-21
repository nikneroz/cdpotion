defmodule CDPotion.Domain.IndexedDB do
  use CDPotion.Utils
  @doc "Data entry."
  @type DataEntry :: %{
          key: Runtime.RemoteObject,
          primaryKey: Runtime.RemoteObject,
          value: Runtime.RemoteObject
        }

  @doc "Database with an array of object stores."
  @type DatabaseWithObjectStores :: %{
          name: String.t(),
          objectStores: list(IndexedDB.ObjectStore),
          version: number()
        }

  @doc "Key."
  @type Key :: %{
          array: list(IndexedDB.Key) | nil,
          date: number() | nil,
          number: number() | nil,
          string: String.t() | nil,
          type: :number | :string | :date | :array
        }

  @doc "Key path."
  @type KeyPath :: %{
          array: list(String.t()) | nil,
          string: String.t() | nil,
          type: :null | :string | :array
        }

  @doc "Key range."
  @type KeyRange :: %{
          lower: IndexedDB.Key | nil,
          lowerOpen: boolean(),
          upper: IndexedDB.Key | nil,
          upperOpen: boolean()
        }

  @doc "Object store."
  @type ObjectStore :: %{
          autoIncrement: boolean(),
          indexes: list(IndexedDB.ObjectStoreIndex),
          keyPath: IndexedDB.KeyPath,
          name: String.t()
        }

  @doc "Object store index."
  @type ObjectStoreIndex :: %{
          keyPath: IndexedDB.KeyPath,
          multiEntry: boolean(),
          name: String.t(),
          unique: boolean()
        }

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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket},
        {"databaseName", database_name},
        {"objectStoreName", object_store_name}
      ])

    {"IndexedDB.clearObjectStore", params}
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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket},
        {"databaseName", database_name}
      ])

    {"IndexedDB.deleteDatabase", params}
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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket},
        {"databaseName", database_name},
        {"objectStoreName", object_store_name},
        {"keyRange", key_range}
      ])

    {"IndexedDB.deleteObjectStoreEntries", params}
  end

  @doc """
  Disables events from backend.
  """
  def disable() do
    {"IndexedDB.disable", %{}}
  end

  @doc """
  Enables events from backend.
  """
  def enable() do
    {"IndexedDB.enable", %{}}
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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket},
        {"databaseName", database_name},
        {"objectStoreName", object_store_name},
        {"indexName", index_name},
        {"skipCount", skip_count},
        {"pageSize", page_size},
        {"keyRange", key_range}
      ])

    {"IndexedDB.requestData", params}
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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket},
        {"databaseName", database_name},
        {"objectStoreName", object_store_name}
      ])

    {"IndexedDB.getMetadata", params}
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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket},
        {"databaseName", database_name}
      ])

    {"IndexedDB.requestDatabase", params}
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
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket}
      ])

    {"IndexedDB.requestDatabaseNames", params}
  end
end
