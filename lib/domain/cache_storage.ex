defmodule CDPotion.Domain.CacheStorage do

@doc """
Deletes a cache.
## Parameters:
  - `cacheId:CacheId`: Id of cache for deletion.
"""
def delete_cache(cache_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Deletes a cache entry.
## Parameters:
  - `cacheId:CacheId`: Id of cache where the entry will be deleted.
  - `request:string`: URL spec of the request.
"""
def delete_entry(cache_id, request) do
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
end

@doc """
Fetches cache entry.
## Parameters:
  - `cacheId:CacheId`: Id of cache that contains the entry.
  - `requestURL:string`: URL spec of the request.
  - `requestHeaders:array`: headers of the request.
"""
def request_cached_response(cache_id, request_url, request_headers) do
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
end
end