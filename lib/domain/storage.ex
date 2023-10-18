defmodule CDPotion.Domain.Storage do
  @doc """
  Returns a storage key given a frame id.
  ## Parameters:
  - `frameId:Page.FrameId`: description not provided :(
  """
  def get_storage_key_for_frame(frame_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Clears storage for origin.
  ## Parameters:
  - `origin:string`: Security origin.
    - `storageTypes:string`: Comma separated list of StorageType to clear.
  """
  def clear_data_for_origin(origin, storage_types) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Clears storage for storage key.
  ## Parameters:
  - `storageKey:string`: Storage key.
    - `storageTypes:string`: Comma separated list of StorageType to clear.
  """
  def clear_data_for_storage_key(storage_key, storage_types) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns all browser cookies.
  ## Parameters:
  - `browserContextId:Browser.BrowserContextID`: (Optional) Browser context to use when called on the browser endpoint.
  """
  def get_cookies(browser_context_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets given cookies.
  ## Parameters:
  - `cookies:array`: Cookies to be set.
    - `browserContextId:Browser.BrowserContextID`: (Optional) Browser context to use when called on the browser endpoint.
  """
  def set_cookies(cookies, browser_context_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Clears cookies.
  ## Parameters:
  - `browserContextId:Browser.BrowserContextID`: (Optional) Browser context to use when called on the browser endpoint.
  """
  def clear_cookies(browser_context_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns usage and quota in bytes.
  ## Parameters:
  - `origin:string`: Security origin.
  """
  def get_usage_and_quota(origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Override quota for the specified origin
  ## Parameters:
  - `origin:string`: Security origin.
    - `quotaSize:number`: (Optional) The quota size (in bytes) to override the original quota with.
  If this is called multiple times, the overridden quota will be equal to
  the quotaSize provided in the final call. If this is called without
  specifying a quotaSize, the quota will be reset to the default value for
  the specified origin. If this is called multiple times with different
  origins, the override will be maintained for each origin until it is
  disabled (called without a quotaSize).
  """
  def override_quota_for_origin(origin, quota_size \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Registers origin to be notified when an update occurs to its cache storage list.
  ## Parameters:
  - `origin:string`: Security origin.
  """
  def track_cache_storage_for_origin(origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Registers storage key to be notified when an update occurs to its cache storage list.
  ## Parameters:
  - `storageKey:string`: Storage key.
  """
  def track_cache_storage_for_storage_key(storage_key) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Registers origin to be notified when an update occurs to its IndexedDB.
  ## Parameters:
  - `origin:string`: Security origin.
  """
  def track_indexed_db_for_origin(origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Registers storage key to be notified when an update occurs to its IndexedDB.
  ## Parameters:
  - `storageKey:string`: Storage key.
  """
  def track_indexed_db_for_storage_key(storage_key) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Unregisters origin from receiving notifications for cache storage.
  ## Parameters:
  - `origin:string`: Security origin.
  """
  def untrack_cache_storage_for_origin(origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Unregisters storage key from receiving notifications for cache storage.
  ## Parameters:
  - `storageKey:string`: Storage key.
  """
  def untrack_cache_storage_for_storage_key(storage_key) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Unregisters origin from receiving notifications for IndexedDB.
  ## Parameters:
  - `origin:string`: Security origin.
  """
  def untrack_indexed_db_for_origin(origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Unregisters storage key from receiving notifications for IndexedDB.
  ## Parameters:
  - `storageKey:string`: Storage key.
  """
  def untrack_indexed_db_for_storage_key(storage_key) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the number of stored Trust Tokens per issuer for the
  current browsing context.
  """
  def get_trust_tokens() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Removes all Trust Tokens issued by the provided issuerOrigin.
  Leaves other stored data, including the issuer's Redemption Records, intact.
  ## Parameters:
  - `issuerOrigin:string`: description not provided :(
  """
  def clear_trust_tokens(issuer_origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets details for a named interest group.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
    - `name:string`: description not provided :(
  """
  def get_interest_group_details(owner_origin, name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables/Disables issuing of interestGroupAccessed events.
  ## Parameters:
  - `enable:boolean`: description not provided :(
  """
  def set_interest_group_tracking(enable) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets metadata for an origin's shared storage.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
  """
  def get_shared_storage_metadata(owner_origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets the entries in an given origin's shared storage.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
  """
  def get_shared_storage_entries(owner_origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets entry with `key` and `value` for a given origin's shared storage.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
    - `key:string`: description not provided :(
    - `value:string`: description not provided :(
    - `ignoreIfPresent:boolean`: (Optional) If `ignoreIfPresent` is included and true, then only sets the entry if
  `key` doesn't already exist.
  """
  def set_shared_storage_entry(owner_origin, key, value, ignore_if_present \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Deletes entry for `key` (if it exists) for a given origin's shared storage.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
    - `key:string`: description not provided :(
  """
  def delete_shared_storage_entry(owner_origin, key) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Clears all entries for a given origin's shared storage.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
  """
  def clear_shared_storage_entries(owner_origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Resets the budget for `ownerOrigin` by clearing all budget withdrawals.
  ## Parameters:
  - `ownerOrigin:string`: description not provided :(
  """
  def reset_shared_storage_budget(owner_origin) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables/disables issuing of sharedStorageAccessed events.
  ## Parameters:
  - `enable:boolean`: description not provided :(
  """
  def set_shared_storage_tracking(enable) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Set tracking for a storage key's buckets.
  ## Parameters:
  - `storageKey:string`: description not provided :(
    - `enable:boolean`: description not provided :(
  """
  def set_storage_bucket_tracking(storage_key, enable) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Deletes the Storage Bucket with the given storage key and bucket name.
  ## Parameters:
  - `bucket:StorageBucket`: description not provided :(
  """
  def delete_storage_bucket(bucket) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Deletes state for sites identified as potential bounce trackers, immediately.
  """
  def run_bounce_tracking_mitigations() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  https://wicg.github.io/attribution-reporting-api/
  ## Parameters:
  - `enabled:boolean`: If enabled, noise is suppressed and reports are sent immediately.
  """
  def set_attribution_reporting_local_testing_mode(enabled) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables/disables issuing of Attribution Reporting events.
  ## Parameters:
  - `enable:boolean`: description not provided :(
  """
  def set_attribution_reporting_tracking(enable) do
    execute(session, :navigate, %{"url" => url})
  end
end
