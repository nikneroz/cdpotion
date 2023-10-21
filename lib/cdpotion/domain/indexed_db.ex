defmodule CDPotion.Domain.IndexedDB do
  use CDPotion.Utils
  @typedoc "Data entry."
  @type data_entry :: %{
          key: CDPotion.Domain.Runtime.remote_object(),
          primaryKey: CDPotion.Domain.Runtime.remote_object(),
          value: CDPotion.Domain.Runtime.remote_object()
        }

  @typedoc "Database with an array of object stores."
  @type database_with_object_stores :: %{
          name: String.t(),
          objectStores: list(CDPotion.Domain.IndexedDB.object_store()),
          version: number()
        }

  @typedoc "Key."
  @type key :: %{
          array: list(CDPotion.Domain.IndexedDB.key()) | nil,
          date: number() | nil,
          number: number() | nil,
          string: String.t() | nil,
          type: :number | :string | :date | :array
        }

  @typedoc "Key path."
  @type key_path :: %{
          array: list(String.t()) | nil,
          string: String.t() | nil,
          type: :null | :string | :array
        }

  @typedoc "Key range."
  @type key_range :: %{
          lower: CDPotion.Domain.IndexedDB.key() | nil,
          lowerOpen: boolean(),
          upper: CDPotion.Domain.IndexedDB.key() | nil,
          upperOpen: boolean()
        }

  @typedoc "Object store."
  @type object_store :: %{
          autoIncrement: boolean(),
          indexes: list(CDPotion.Domain.IndexedDB.object_store_index()),
          keyPath: CDPotion.Domain.IndexedDB.key_path(),
          name: String.t()
        }

  @typedoc "Object store index."
  @type object_store_index :: %{
          keyPath: CDPotion.Domain.IndexedDB.key_path(),
          multiEntry: boolean(),
          name: String.t(),
          unique: boolean()
        }

  @doc """
  Clears all entries from an object store.
  ## Parameters:
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  - `database_name`:Database name.
  - `object_store_name`:Object store name.
  """
  @spec clear_object_store(
          String.t(),
          String.t(),
          CDPotion.Domain.Storage.StorageBucket,
          String.t(),
          String.t()
        ) :: {String.t(), map()}
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
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  - `database_name`:Database name.
  """
  @spec delete_database(String.t(), String.t(), CDPotion.Domain.Storage.StorageBucket, String.t()) ::
          {String.t(), map()}
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
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  - `database_name`:description not provided :(
  - `object_store_name`:description not provided :(
  - `key_range`:Range of entry keys to delete
  """
  @spec delete_object_store_entries(
          String.t(),
          String.t(),
          CDPotion.Domain.Storage.StorageBucket,
          String.t(),
          String.t(),
          CDPotion.Domain.IndexedDB.KeyRange
        ) :: {String.t(), map()}
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
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"IndexedDB.disable", %{}}
  end

  @doc """
  Enables events from backend.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"IndexedDB.enable", %{}}
  end

  @doc """
  Requests data from object store or index.
  ## Parameters:
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  - `database_name`:Database name.
  - `object_store_name`:Object store name.
  - `index_name`:Index name, empty string for object store data requests.
  - `skip_count`:Number of records to skip.
  - `page_size`:Number of records to fetch.
  - `key_range`:(Optional) Key range.
  """
  @spec request_data(
          String.t(),
          String.t(),
          CDPotion.Domain.Storage.StorageBucket,
          String.t(),
          String.t(),
          String.t(),
          integer(),
          integer(),
          CDPotion.Domain.IndexedDB.KeyRange
        ) :: {String.t(), map()}
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
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  - `database_name`:Database name.
  - `object_store_name`:Object store name.
  """
  @spec get_metadata(
          String.t(),
          String.t(),
          CDPotion.Domain.Storage.StorageBucket,
          String.t(),
          String.t()
        ) :: {String.t(), map()}
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
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  - `database_name`:Database name.
  """
  @spec request_database(
          String.t(),
          String.t(),
          CDPotion.Domain.Storage.StorageBucket,
          String.t()
        ) :: {String.t(), map()}
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
    - `security_origin`:(Optional) At least and at most one of securityOrigin, storageKey, or storageBucket must be specified.
  Security origin.
  - `storage_key`:(Optional) Storage key.
  - `storage_bucket`:(Optional) Storage bucket. If not specified, it uses the default bucket.
  """
  @spec request_database_names(String.t(), String.t(), CDPotion.Domain.Storage.StorageBucket) ::
          {String.t(), map()}
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
