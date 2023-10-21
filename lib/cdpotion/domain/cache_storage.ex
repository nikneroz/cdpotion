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
    - `cacheId:CacheId`: Id of cache for deletion.
  """
  def delete_cache(cache_id) do
    params = as_query([{"cacheId", cache_id}])
    {"CacheStorage.deleteCache", params}
  end

  @doc """
  Deletes a cache entry.
  ## Parameters:
    - `cacheId:CacheId`: Id of cache where the entry will be deleted.
    - `request:string`: URL spec of the request.
  """
  def delete_entry(cache_id, request) do
    params = as_query([{"cacheId", cache_id}, {"request", request}])
    {"CacheStorage.deleteEntry", params}
  end

  @doc """
  Requests cache names.
  ## Parameters:
    - `securityOrigin:string`: (Optional) At least and at most one of securityOrigin, storageKey, storageBucket must be specified.
  Security origin.
    - `storageKey:string`: (Optional) Storage key.
    - `storageBucket:Storage.StorageBucket`: (Optional) Storage bucket. If not specified, it uses the default bucket.
  """
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
    - `cacheId:CacheId`: Id of cache that contains the entry.
    - `requestURL:string`: URL spec of the request.
    - `requestHeaders:array`: headers of the request.
  """
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
    - `cacheId:CacheId`: ID of cache to get entries from.
    - `skipCount:integer`: (Optional) Number of records to skip.
    - `pageSize:integer`: (Optional) Number of records to fetch.
    - `pathFilter:string`: (Optional) If present, only return the entries containing this substring in the path
  """
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
