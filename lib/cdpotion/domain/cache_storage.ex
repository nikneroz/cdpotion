defmodule CDPotion.Domain.CacheStorage do
  use CDPotion.Utils
  @typedoc "Cache identifier."
  @type cache :: %{
          cacheId: CDPotion.Domain.CacheStorage.cache_id(),
          cacheName: String.t(),
          securityOrigin: String.t(),
          storageBucket: CDPotion.Domain.Storage.storage_bucket() | nil,
          storageKey: String.t()
        }

  @typedoc "Unique identifier of the Cache object."
  @type cache_id :: String.t()

  @typedoc "Cached response"
  @type cached_response :: %{
          body: String.t()
        }

  @typedoc "type of HTTP response cached"
  @type cached_response_type ::
          :basic | :cors | :default | :error | :opaqueResponse | :opaqueRedirect

  @typedoc "Data entry."
  @type data_entry :: %{
          requestHeaders: list(CDPotion.Domain.CacheStorage.header()),
          requestMethod: String.t(),
          requestURL: String.t(),
          responseHeaders: list(CDPotion.Domain.CacheStorage.header()),
          responseStatus: integer(),
          responseStatusText: String.t(),
          responseTime: number(),
          responseType: CDPotion.Domain.CacheStorage.cached_response_type()
        }

  @typedoc "description not provided :("
  @type header :: %{
          name: String.t(),
          value: String.t()
        }

  @doc """
  Deletes a cache.
  ## Parameters:
    - (Required) `cache_id`: Id of cache for deletion.
  """
  @spec delete_cache(CDPotion.Domain.CacheStorage.CacheId) :: {String.t(), map()}
  def delete_cache(cache_id) do
    params = as_query([{"cacheId", cache_id}])
    {"CacheStorage.deleteCache", params}
  end

  @doc """
  Deletes a cache entry.
  ## Parameters:
    - (Required) `cache_id`: Id of cache where the entry will be deleted.
  - (Required) `request`: URL spec of the request.
  """
  @spec delete_entry(CDPotion.Domain.CacheStorage.CacheId, String.t()) :: {String.t(), map()}
  def delete_entry(cache_id, request) do
    params = as_query([{"cacheId", cache_id}, {"request", request}])
    {"CacheStorage.deleteEntry", params}
  end

  @doc """
  Requests cache names.
  ## Parameters:
    - (Optional) `security_origin`: At least and at most one of securityOrigin, storageKey, storageBucket must be specified.
  Security origin.
  - (Optional) `storage_key`: Storage key.
  - (Optional) `storage_bucket`: Storage bucket. If not specified, it uses the default bucket.
  """
  @spec request_cache_names(String.t(), String.t(), CDPotion.Domain.Storage.StorageBucket) ::
          {String.t(), map()}
  def request_cache_names(security_origin \\ nil, storage_key \\ nil, storage_bucket \\ nil) do
    params =
      as_query([
        {"securityOrigin", security_origin},
        {"storageKey", storage_key},
        {"storageBucket", storage_bucket}
      ])

    {"CacheStorage.requestCacheNames", params}
  end

  @doc """
  Fetches cache entry.
  ## Parameters:
    - (Required) `cache_id`: Id of cache that contains the entry.
  - (Required) `request_url`: URL spec of the request.
  - (Required) `request_headers`: headers of the request.
  """
  @spec request_cached_response(
          CDPotion.Domain.CacheStorage.CacheId,
          String.t(),
          list(CDPotion.Domain.CacheStorage.Header)
        ) :: {String.t(), map()}
  def request_cached_response(cache_id, request_url, request_headers) do
    params =
      as_query([
        {"cacheId", cache_id},
        {"requestURL", request_url},
        {"requestHeaders", request_headers}
      ])

    {"CacheStorage.requestCachedResponse", params}
  end

  @doc """
  Requests data from cache.
  ## Parameters:
    - (Required) `cache_id`: ID of cache to get entries from.
  - (Optional) `skip_count`: Number of records to skip.
  - (Optional) `page_size`: Number of records to fetch.
  - (Optional) `path_filter`: If present, only return the entries containing this substring in the path
  """
  @spec request_entries(CDPotion.Domain.CacheStorage.CacheId, integer(), integer(), String.t()) ::
          {String.t(), map()}
  def request_entries(cache_id, skip_count \\ nil, page_size \\ nil, path_filter \\ nil) do
    params =
      as_query([
        {"cacheId", cache_id},
        {"skipCount", skip_count},
        {"pageSize", page_size},
        {"pathFilter", path_filter}
      ])

    {"CacheStorage.requestEntries", params}
  end
end
