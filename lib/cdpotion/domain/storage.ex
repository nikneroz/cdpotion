defmodule CDPotion.Domain.Storage do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type attribution_reporting_aggregation_keys_entry :: %{
          key: String.t(),
          value: CDPotion.Domain.Storage.unsigned_int128_as_base16()
        }

  @typedoc "description not provided :("
  @type attribution_reporting_filter_data_entry :: %{
          key: String.t(),
          values: list(String.t())
        }

  @typedoc "description not provided :("
  @type attribution_reporting_source_registration :: %{
          aggregatableReportWindow: integer() | nil,
          aggregationKeys:
            list(CDPotion.Domain.Storage.attribution_reporting_aggregation_keys_entry()),
          debugKey: CDPotion.Domain.Storage.unsigned_int64_as_base10() | nil,
          destinationSites: list(String.t()),
          eventId: CDPotion.Domain.Storage.unsigned_int64_as_base10(),
          eventReportWindow: integer() | nil,
          expiry: integer() | nil,
          filterData: list(CDPotion.Domain.Storage.attribution_reporting_filter_data_entry()),
          priority: CDPotion.Domain.Storage.signed_int64_as_base10(),
          reportingOrigin: String.t(),
          sourceOrigin: String.t(),
          time: CDPotion.Domain.Network.time_since_epoch(),
          type: CDPotion.Domain.Storage.attribution_reporting_source_type()
        }

  @typedoc "description not provided :("
  @type attribution_reporting_source_registration_result ::
          :success
          | :internalError
          | :insufficientSourceCapacity
          | :insufficientUniqueDestinationCapacity
          | :excessiveReportingOrigins
          | :prohibitedByBrowserPolicy
          | :successNoised
          | :destinationReportingLimitReached
          | :destinationGlobalLimitReached
          | :destinationBothLimitsReached
          | :reportingOriginsPerSiteLimitReached

  @typedoc "description not provided :("
  @type attribution_reporting_source_type :: :navigation | :event

  @typedoc "Enum of interest group access types."
  @type interest_group_access_type :: :join | :leave | :update | :loaded | :bid | :win

  @typedoc "Ad advertising element inside an interest group."
  @type interest_group_ad :: %{
          metadata: String.t() | nil,
          renderUrl: String.t()
        }

  @typedoc "The full details of an interest group."
  @type interest_group_details :: %{
          adComponents: list(CDPotion.Domain.Storage.interest_group_ad()),
          ads: list(CDPotion.Domain.Storage.interest_group_ad()),
          biddingUrl: String.t() | nil,
          biddingWasmHelperUrl: String.t() | nil,
          expirationTime: CDPotion.Domain.Network.time_since_epoch(),
          joiningOrigin: String.t(),
          name: String.t(),
          ownerOrigin: String.t(),
          trustedBiddingSignalsKeys: list(String.t()),
          trustedBiddingSignalsUrl: String.t() | nil,
          updateUrl: String.t() | nil,
          userBiddingSignals: String.t() | nil
        }

  @typedoc "description not provided :("
  @type serialized_storage_key :: String.t()

  @typedoc "Bundles the parameters for shared storage access events whose
presence/absence can vary according to SharedStorageAccessType."
  @type shared_storage_access_params :: %{
          ignoreIfPresent: boolean() | nil,
          key: String.t() | nil,
          operationName: String.t() | nil,
          scriptSourceUrl: String.t() | nil,
          serializedData: String.t() | nil,
          urlsWithMetadata:
            list(CDPotion.Domain.Storage.shared_storage_url_with_metadata()) | nil,
          value: String.t() | nil
        }

  @typedoc "Enum of shared storage access types."
  @type shared_storage_access_type ::
          :documentAddModule
          | :documentSelectURL
          | :documentRun
          | :documentSet
          | :documentAppend
          | :documentDelete
          | :documentClear
          | :workletSet
          | :workletAppend
          | :workletDelete
          | :workletClear
          | :workletGet
          | :workletKeys
          | :workletEntries
          | :workletLength
          | :workletRemainingBudget

  @typedoc "Struct for a single key-value pair in an origin's shared storage."
  @type shared_storage_entry :: %{
          key: String.t(),
          value: String.t()
        }

  @typedoc "Details for an origin's shared storage."
  @type shared_storage_metadata :: %{
          creationTime: CDPotion.Domain.Network.time_since_epoch(),
          length: integer(),
          remainingBudget: number()
        }

  @typedoc "Pair of reporting metadata details for a candidate URL for `selectURL()`."
  @type shared_storage_reporting_metadata :: %{
          eventType: String.t(),
          reportingUrl: String.t()
        }

  @typedoc "Bundles a candidate URL with its reporting metadata."
  @type shared_storage_url_with_metadata :: %{
          reportingMetadata: list(CDPotion.Domain.Storage.shared_storage_reporting_metadata()),
          url: String.t()
        }

  @typedoc "description not provided :("
  @type signed_int64_as_base10 :: String.t()

  @typedoc "description not provided :("
  @type storage_bucket :: %{
          name: String.t() | nil,
          storageKey: CDPotion.Domain.Storage.serialized_storage_key()
        }

  @typedoc "description not provided :("
  @type storage_bucket_info :: %{
          bucket: CDPotion.Domain.Storage.storage_bucket(),
          durability: CDPotion.Domain.Storage.storage_buckets_durability(),
          expiration: CDPotion.Domain.Network.time_since_epoch(),
          id: String.t(),
          persistent: boolean(),
          quota: number()
        }

  @typedoc "description not provided :("
  @type storage_buckets_durability :: :relaxed | :strict

  @typedoc "Enum of possible storage types."
  @type storage_type ::
          :appcache
          | :cookies
          | :file_systems
          | :indexeddb
          | :local_storage
          | :shader_cache
          | :websql
          | :service_workers
          | :cache_storage
          | :interest_groups
          | :shared_storage
          | :storage_buckets
          | :all
          | :other

  @typedoc "Pair of issuer origin and number of available (signed, but not used) Trust
Tokens from that issuer."
  @type trust_tokens :: %{
          count: number(),
          issuerOrigin: String.t()
        }

  @typedoc "description not provided :("
  @type unsigned_int128_as_base16 :: String.t()

  @typedoc "description not provided :("
  @type unsigned_int64_as_base10 :: String.t()

  @typedoc "Usage for a storage type."
  @type usage_for_type :: %{
          storageType: CDPotion.Domain.Storage.storage_type(),
          usage: number()
        }

  @doc """
  Returns a storage key given a frame id.
  ## Parameters:
    - `frameId:Page.FrameId`: description not provided :(
  """
  def get_storage_key_for_frame(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Storage.getStorageKeyForFrame", params}
  end

  @doc """
  Clears storage for origin.
  ## Parameters:
    - `origin:string`: Security origin.
    - `storageTypes:string`: Comma separated list of StorageType to clear.
  """
  def clear_data_for_origin(origin, storage_types) do
    params = as_query([{"origin", origin}, {"storageTypes", storage_types}])
    {"Storage.clearDataForOrigin", params}
  end

  @doc """
  Clears storage for storage key.
  ## Parameters:
    - `storageKey:string`: Storage key.
    - `storageTypes:string`: Comma separated list of StorageType to clear.
  """
  def clear_data_for_storage_key(storage_key, storage_types) do
    params = as_query([{"storageKey", storage_key}, {"storageTypes", storage_types}])
    {"Storage.clearDataForStorageKey", params}
  end

  @doc """
  Returns all browser cookies.
  ## Parameters:
    - `browserContextId:Browser.BrowserContextID`: (Optional) Browser context to use when called on the browser endpoint.
  """
  def get_cookies(browser_context_id \\ nil) do
    params = as_query([{"browserContextId", browser_context_id}])
    {"Storage.getCookies", params}
  end

  @doc """
  Sets given cookies.
  ## Parameters:
    - `cookies:array`: Cookies to be set.
    - `browserContextId:Browser.BrowserContextID`: (Optional) Browser context to use when called on the browser endpoint.
  """
  def set_cookies(cookies, browser_context_id \\ nil) do
    params = as_query([{"cookies", cookies}, {"browserContextId", browser_context_id}])
    {"Storage.setCookies", params}
  end

  @doc """
  Clears cookies.
  ## Parameters:
    - `browserContextId:Browser.BrowserContextID`: (Optional) Browser context to use when called on the browser endpoint.
  """
  def clear_cookies(browser_context_id \\ nil) do
    params = as_query([{"browserContextId", browser_context_id}])
    {"Storage.clearCookies", params}
  end

  @doc """
  Returns usage and quota in bytes.
  ## Parameters:
    - `origin:string`: Security origin.
  """
  def get_usage_and_quota(origin) do
    params = as_query([{"origin", origin}])
    {"Storage.getUsageAndQuota", params}
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
    params = as_query([{"origin", origin}, {"quotaSize", quota_size}])
    {"Storage.overrideQuotaForOrigin", params}
  end

  @doc """
  Registers origin to be notified when an update occurs to its cache storage list.
  ## Parameters:
    - `origin:string`: Security origin.
  """
  def track_cache_storage_for_origin(origin) do
    params = as_query([{"origin", origin}])
    {"Storage.trackCacheStorageForOrigin", params}
  end

  @doc """
  Registers storage key to be notified when an update occurs to its cache storage list.
  ## Parameters:
    - `storageKey:string`: Storage key.
  """
  def track_cache_storage_for_storage_key(storage_key) do
    params = as_query([{"storageKey", storage_key}])
    {"Storage.trackCacheStorageForStorageKey", params}
  end

  @doc """
  Registers origin to be notified when an update occurs to its IndexedDB.
  ## Parameters:
    - `origin:string`: Security origin.
  """
  def track_indexed_db_for_origin(origin) do
    params = as_query([{"origin", origin}])
    {"Storage.trackIndexedDBForOrigin", params}
  end

  @doc """
  Registers storage key to be notified when an update occurs to its IndexedDB.
  ## Parameters:
    - `storageKey:string`: Storage key.
  """
  def track_indexed_db_for_storage_key(storage_key) do
    params = as_query([{"storageKey", storage_key}])
    {"Storage.trackIndexedDBForStorageKey", params}
  end

  @doc """
  Unregisters origin from receiving notifications for cache storage.
  ## Parameters:
    - `origin:string`: Security origin.
  """
  def untrack_cache_storage_for_origin(origin) do
    params = as_query([{"origin", origin}])
    {"Storage.untrackCacheStorageForOrigin", params}
  end

  @doc """
  Unregisters storage key from receiving notifications for cache storage.
  ## Parameters:
    - `storageKey:string`: Storage key.
  """
  def untrack_cache_storage_for_storage_key(storage_key) do
    params = as_query([{"storageKey", storage_key}])
    {"Storage.untrackCacheStorageForStorageKey", params}
  end

  @doc """
  Unregisters origin from receiving notifications for IndexedDB.
  ## Parameters:
    - `origin:string`: Security origin.
  """
  def untrack_indexed_db_for_origin(origin) do
    params = as_query([{"origin", origin}])
    {"Storage.untrackIndexedDBForOrigin", params}
  end

  @doc """
  Unregisters storage key from receiving notifications for IndexedDB.
  ## Parameters:
    - `storageKey:string`: Storage key.
  """
  def untrack_indexed_db_for_storage_key(storage_key) do
    params = as_query([{"storageKey", storage_key}])
    {"Storage.untrackIndexedDBForStorageKey", params}
  end

  @doc """
  Returns the number of stored Trust Tokens per issuer for the
  current browsing context.
  """
  def get_trust_tokens() do
    {"Storage.getTrustTokens", %{}}
  end

  @doc """
  Removes all Trust Tokens issued by the provided issuerOrigin.
  Leaves other stored data, including the issuer's Redemption Records, intact.
  ## Parameters:
    - `issuerOrigin:string`: description not provided :(
  """
  def clear_trust_tokens(issuer_origin) do
    params = as_query([{"issuerOrigin", issuer_origin}])
    {"Storage.clearTrustTokens", params}
  end

  @doc """
  Gets details for a named interest group.
  ## Parameters:
    - `ownerOrigin:string`: description not provided :(
    - `name:string`: description not provided :(
  """
  def get_interest_group_details(owner_origin, name) do
    params = as_query([{"ownerOrigin", owner_origin}, {"name", name}])
    {"Storage.getInterestGroupDetails", params}
  end

  @doc """
  Enables/Disables issuing of interestGroupAccessed events.
  ## Parameters:
    - `enable:boolean`: description not provided :(
  """
  def set_interest_group_tracking(enable) do
    params = as_query([{"enable", enable}])
    {"Storage.setInterestGroupTracking", params}
  end

  @doc """
  Gets metadata for an origin's shared storage.
  ## Parameters:
    - `ownerOrigin:string`: description not provided :(
  """
  def get_shared_storage_metadata(owner_origin) do
    params = as_query([{"ownerOrigin", owner_origin}])
    {"Storage.getSharedStorageMetadata", params}
  end

  @doc """
  Gets the entries in an given origin's shared storage.
  ## Parameters:
    - `ownerOrigin:string`: description not provided :(
  """
  def get_shared_storage_entries(owner_origin) do
    params = as_query([{"ownerOrigin", owner_origin}])
    {"Storage.getSharedStorageEntries", params}
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
    params =
      as_query([
        {"ownerOrigin", owner_origin},
        {"key", key},
        {"value", value},
        {"ignoreIfPresent", ignore_if_present}
      ])

    {"Storage.setSharedStorageEntry", params}
  end

  @doc """
  Deletes entry for `key` (if it exists) for a given origin's shared storage.
  ## Parameters:
    - `ownerOrigin:string`: description not provided :(
    - `key:string`: description not provided :(
  """
  def delete_shared_storage_entry(owner_origin, key) do
    params = as_query([{"ownerOrigin", owner_origin}, {"key", key}])
    {"Storage.deleteSharedStorageEntry", params}
  end

  @doc """
  Clears all entries for a given origin's shared storage.
  ## Parameters:
    - `ownerOrigin:string`: description not provided :(
  """
  def clear_shared_storage_entries(owner_origin) do
    params = as_query([{"ownerOrigin", owner_origin}])
    {"Storage.clearSharedStorageEntries", params}
  end

  @doc """
  Resets the budget for `ownerOrigin` by clearing all budget withdrawals.
  ## Parameters:
    - `ownerOrigin:string`: description not provided :(
  """
  def reset_shared_storage_budget(owner_origin) do
    params = as_query([{"ownerOrigin", owner_origin}])
    {"Storage.resetSharedStorageBudget", params}
  end

  @doc """
  Enables/disables issuing of sharedStorageAccessed events.
  ## Parameters:
    - `enable:boolean`: description not provided :(
  """
  def set_shared_storage_tracking(enable) do
    params = as_query([{"enable", enable}])
    {"Storage.setSharedStorageTracking", params}
  end

  @doc """
  Set tracking for a storage key's buckets.
  ## Parameters:
    - `storageKey:string`: description not provided :(
    - `enable:boolean`: description not provided :(
  """
  def set_storage_bucket_tracking(storage_key, enable) do
    params = as_query([{"storageKey", storage_key}, {"enable", enable}])
    {"Storage.setStorageBucketTracking", params}
  end

  @doc """
  Deletes the Storage Bucket with the given storage key and bucket name.
  ## Parameters:
    - `bucket:StorageBucket`: description not provided :(
  """
  def delete_storage_bucket(bucket) do
    params = as_query([{"bucket", bucket}])
    {"Storage.deleteStorageBucket", params}
  end

  @doc """
  Deletes state for sites identified as potential bounce trackers, immediately.
  """
  def run_bounce_tracking_mitigations() do
    {"Storage.runBounceTrackingMitigations", %{}}
  end

  @doc """
  https://wicg.github.io/attribution-reporting-api/
  ## Parameters:
    - `enabled:boolean`: If enabled, noise is suppressed and reports are sent immediately.
  """
  def set_attribution_reporting_local_testing_mode(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Storage.setAttributionReportingLocalTestingMode", params}
  end

  @doc """
  Enables/disables issuing of Attribution Reporting events.
  ## Parameters:
    - `enable:boolean`: description not provided :(
  """
  def set_attribution_reporting_tracking(enable) do
    params = as_query([{"enable", enable}])
    {"Storage.setAttributionReportingTracking", params}
  end
end
