defmodule CDPotion.Domain.Page do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type ad_frame_explanation :: :ParentIsAd | :CreatedByAdScript | :MatchedBlockingRule

  @typedoc "Indicates whether a frame has been identified as an ad and why."
  @type ad_frame_status :: %{
          adFrameType: CDPotion.Domain.Page.ad_frame_type(),
          explanations: list(CDPotion.Domain.Page.ad_frame_explanation()) | nil
        }

  @typedoc "Indicates whether a frame has been identified as an ad."
  @type ad_frame_type :: :none | :child | :root

  @typedoc "Identifies the bottom-most script which caused the frame to be labelled
as an ad."
  @type ad_script_id :: %{
          debuggerId: CDPotion.Domain.Runtime.unique_debugger_id(),
          scriptId: CDPotion.Domain.Runtime.script_id()
        }

  @typedoc "Error while paring app manifest."
  @type app_manifest_error :: %{
          column: integer(),
          critical: integer(),
          line: integer(),
          message: String.t()
        }

  @typedoc "Parsed app manifest properties."
  @type app_manifest_parsed_properties :: %{
          scope: String.t()
        }

  @typedoc "Enum of possible auto-reponse for permisison / prompt dialogs."
  @type auto_response_mode :: :none | :autoAccept | :autoReject | :autoOptOut

  @typedoc "description not provided :("
  @type back_forward_cache_not_restored_explanation :: %{
          context: String.t() | nil,
          reason: CDPotion.Domain.Page.back_forward_cache_not_restored_reason(),
          type: CDPotion.Domain.Page.back_forward_cache_not_restored_reason_type()
        }

  @typedoc "description not provided :("
  @type back_forward_cache_not_restored_explanation_tree :: %{
          children: list(CDPotion.Domain.Page.back_forward_cache_not_restored_explanation_tree()),
          explanations: list(CDPotion.Domain.Page.back_forward_cache_not_restored_explanation()),
          url: String.t()
        }

  @typedoc "List of not restored reasons for back-forward cache."
  @type back_forward_cache_not_restored_reason ::
          :NotPrimaryMainFrame
          | :BackForwardCacheDisabled
          | :RelatedActiveContentsExist
          | :HTTPStatusNotOK
          | :SchemeNotHTTPOrHTTPS
          | :Loading
          | :WasGrantedMediaAccess
          | :DisableForRenderFrameHostCalled
          | :DomainNotAllowed
          | :HTTPMethodNotGET
          | :SubframeIsNavigating
          | :Timeout
          | :CacheLimit
          | :JavaScriptExecution
          | :RendererProcessKilled
          | :RendererProcessCrashed
          | :SchedulerTrackedFeatureUsed
          | :ConflictingBrowsingInstance
          | :CacheFlushed
          | :ServiceWorkerVersionActivation
          | :SessionRestored
          | :ServiceWorkerPostMessage
          | :EnteredBackForwardCacheBeforeServiceWorkerHostAdded
          | :RenderFrameHostReused_SameSite
          | :RenderFrameHostReused_CrossSite
          | :ServiceWorkerClaim
          | :IgnoreEventAndEvict
          | :HaveInnerContents
          | :TimeoutPuttingInCache
          | :BackForwardCacheDisabledByLowMemory
          | :BackForwardCacheDisabledByCommandLine
          | :NetworkRequestDatapipeDrainedAsBytesConsumer
          | :NetworkRequestRedirected
          | :NetworkRequestTimeout
          | :NetworkExceedsBufferLimit
          | :NavigationCancelledWhileRestoring
          | :NotMostRecentNavigationEntry
          | :BackForwardCacheDisabledForPrerender
          | :UserAgentOverrideDiffers
          | :ForegroundCacheLimit
          | :BrowsingInstanceNotSwapped
          | :BackForwardCacheDisabledForDelegate
          | :UnloadHandlerExistsInMainFrame
          | :UnloadHandlerExistsInSubFrame
          | :ServiceWorkerUnregistration
          | :CacheControlNoStore
          | :CacheControlNoStoreCookieModified
          | :CacheControlNoStoreHTTPOnlyCookieModified
          | :NoResponseHead
          | :Unknown
          | :ActivationNavigationsDisallowedForBug1234857
          | :ErrorDocument
          | :FencedFramesEmbedder
          | :CookieDisabled
          | :HTTPAuthRequired
          | :CookieFlushed
          | :WebSocket
          | :WebTransport
          | :WebRTC
          | :MainResourceHasCacheControlNoStore
          | :MainResourceHasCacheControlNoCache
          | :SubresourceHasCacheControlNoStore
          | :SubresourceHasCacheControlNoCache
          | :ContainsPlugins
          | :DocumentLoaded
          | :DedicatedWorkerOrWorklet
          | :OutstandingNetworkRequestOthers
          | :RequestedMIDIPermission
          | :RequestedAudioCapturePermission
          | :RequestedVideoCapturePermission
          | :RequestedBackForwardCacheBlockedSensors
          | :RequestedBackgroundWorkPermission
          | :BroadcastChannel
          | :WebXR
          | :SharedWorker
          | :WebLocks
          | :WebHID
          | :WebShare
          | :RequestedStorageAccessGrant
          | :WebNfc
          | :OutstandingNetworkRequestFetch
          | :OutstandingNetworkRequestXHR
          | :AppBanner
          | :Printing
          | :WebDatabase
          | :PictureInPicture
          | :Portal
          | :SpeechRecognizer
          | :IdleManager
          | :PaymentManager
          | :SpeechSynthesis
          | :KeyboardLock
          | :WebOTPService
          | :OutstandingNetworkRequestDirectSocket
          | :InjectedJavascript
          | :InjectedStyleSheet
          | :KeepaliveRequest
          | :IndexedDBEvent
          | :Dummy
          | :JsNetworkRequestReceivedCacheControlNoStoreResource
          | :WebRTCSticky
          | :WebTransportSticky
          | :WebSocketSticky
          | :ContentSecurityHandler
          | :ContentWebAuthenticationAPI
          | :ContentFileChooser
          | :ContentSerial
          | :ContentFileSystemAccess
          | :ContentMediaDevicesDispatcherHost
          | :ContentWebBluetooth
          | :ContentWebUSB
          | :ContentMediaSessionService
          | :ContentScreenReader
          | :EmbedderPopupBlockerTabHelper
          | :EmbedderSafeBrowsingTriggeredPopupBlocker
          | :EmbedderSafeBrowsingThreatDetails
          | :EmbedderAppBannerManager
          | :EmbedderDomDistillerViewerSource
          | :EmbedderDomDistillerSelfDeletingRequestDelegate
          | :EmbedderOomInterventionTabHelper
          | :EmbedderOfflinePage
          | :EmbedderChromePasswordManagerClientBindCredentialManager
          | :EmbedderPermissionRequestManager
          | :EmbedderModalDialog
          | :EmbedderExtensions
          | :EmbedderExtensionMessaging
          | :EmbedderExtensionMessagingForOpenPort
          | :EmbedderExtensionSentMessageToCachedFrame

  @typedoc "Types of not restored reasons for back-forward cache."
  @type back_forward_cache_not_restored_reason_type ::
          :SupportPending | :PageSupportNeeded | :Circumstantial

  @typedoc "description not provided :("
  @type client_navigation_disposition :: :currentTab | :newTab | :newWindow | :download

  @typedoc "description not provided :("
  @type client_navigation_reason ::
          :formSubmissionGet
          | :formSubmissionPost
          | :httpHeaderRefresh
          | :scriptInitiated
          | :metaTagRefresh
          | :pageBlockInterstitial
          | :reload
          | :anchorClick

  @typedoc "Per-script compilation cache parameters for `Page.produceCompilationCache`"
  @type compilation_cache_params :: %{
          eager: boolean() | nil,
          url: String.t()
        }

  @typedoc "Indicates whether the frame is cross-origin isolated and why it is the case."
  @type cross_origin_isolated_context_type ::
          :Isolated | :NotIsolated | :NotIsolatedFeatureDisabled

  @typedoc "Javascript dialog type."
  @type dialog_type :: :alert | :confirm | :prompt | :beforeunload

  @typedoc "Generic font families collection."
  @type font_families :: %{
          cursive: String.t() | nil,
          fantasy: String.t() | nil,
          fixed: String.t() | nil,
          math: String.t() | nil,
          sansSerif: String.t() | nil,
          serif: String.t() | nil,
          standard: String.t() | nil
        }

  @typedoc "Default font sizes."
  @type font_sizes :: %{
          fixed: integer() | nil,
          standard: integer() | nil
        }

  @typedoc "Information about the Frame on the page."
  @type frame :: %{
          adFrameStatus: CDPotion.Domain.Page.ad_frame_status() | nil,
          crossOriginIsolatedContextType:
            CDPotion.Domain.Page.cross_origin_isolated_context_type(),
          domainAndRegistry: String.t(),
          gatedAPIFeatures: list(CDPotion.Domain.Page.gated_api_features()),
          id: CDPotion.Domain.Page.frame_id(),
          loaderId: CDPotion.Domain.Network.loader_id(),
          mimeType: String.t(),
          name: String.t() | nil,
          parentId: CDPotion.Domain.Page.frame_id() | nil,
          secureContextType: CDPotion.Domain.Page.secure_context_type(),
          securityOrigin: String.t(),
          unreachableUrl: String.t() | nil,
          url: String.t(),
          urlFragment: String.t() | nil
        }

  @typedoc "Unique frame identifier."
  @type frame_id :: String.t()

  @typedoc "Information about the Resource on the page."
  @type frame_resource :: %{
          canceled: boolean() | nil,
          contentSize: number() | nil,
          failed: boolean() | nil,
          lastModified: CDPotion.Domain.Network.time_since_epoch() | nil,
          mimeType: String.t(),
          type: CDPotion.Domain.Network.resource_type(),
          url: String.t()
        }

  @typedoc "Information about the Frame hierarchy along with their cached resources."
  @type frame_resource_tree :: %{
          childFrames: list(CDPotion.Domain.Page.frame_resource_tree()) | nil,
          frame: CDPotion.Domain.Page.frame(),
          resources: list(CDPotion.Domain.Page.frame_resource())
        }

  @typedoc "Information about the Frame hierarchy."
  @type frame_tree :: %{
          childFrames: list(CDPotion.Domain.Page.frame_tree()) | nil,
          frame: CDPotion.Domain.Page.frame()
        }

  @typedoc "description not provided :("
  @type gated_api_features ::
          :SharedArrayBuffers
          | :SharedArrayBuffersTransferAllowed
          | :PerformanceMeasureMemory
          | :PerformanceProfile

  @typedoc "The installability error"
  @type installability_error :: %{
          errorArguments: list(CDPotion.Domain.Page.installability_error_argument()),
          errorId: String.t()
        }

  @typedoc "description not provided :("
  @type installability_error_argument :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "Layout viewport position and dimensions."
  @type layout_viewport :: %{
          clientHeight: integer(),
          clientWidth: integer(),
          pageX: integer(),
          pageY: integer()
        }

  @typedoc "Navigation history entry."
  @type navigation_entry :: %{
          id: integer(),
          title: String.t(),
          transitionType: CDPotion.Domain.Page.transition_type(),
          url: String.t(),
          userTypedURL: String.t()
        }

  @typedoc "The type of a frameNavigated event."
  @type navigation_type :: :Navigation | :BackForwardCacheRestore

  @typedoc "description not provided :("
  @type origin_trial :: %{
          status: CDPotion.Domain.Page.origin_trial_status(),
          tokensWithStatus: list(CDPotion.Domain.Page.origin_trial_token_with_status()),
          trialName: String.t()
        }

  @typedoc "Status for an Origin Trial."
  @type origin_trial_status ::
          :Enabled | :ValidTokenNotProvided | :OSNotSupported | :TrialNotAllowed

  @typedoc "description not provided :("
  @type origin_trial_token :: %{
          expiryTime: CDPotion.Domain.Network.time_since_epoch(),
          isThirdParty: boolean(),
          matchSubDomains: boolean(),
          origin: String.t(),
          trialName: String.t(),
          usageRestriction: CDPotion.Domain.Page.origin_trial_usage_restriction()
        }

  @typedoc "Origin Trial(https://www.chromium.org/blink/origin-trials) support.
Status for an Origin Trial token."
  @type origin_trial_token_status ::
          :Success
          | :NotSupported
          | :Insecure
          | :Expired
          | :WrongOrigin
          | :InvalidSignature
          | :Malformed
          | :WrongVersion
          | :FeatureDisabled
          | :TokenDisabled
          | :FeatureDisabledForUser
          | :UnknownTrial

  @typedoc "description not provided :("
  @type origin_trial_token_with_status :: %{
          parsedToken: CDPotion.Domain.Page.origin_trial_token() | nil,
          rawTokenText: String.t(),
          status: CDPotion.Domain.Page.origin_trial_token_status()
        }

  @typedoc "description not provided :("
  @type origin_trial_usage_restriction :: :None | :Subset

  @typedoc "description not provided :("
  @type permissions_policy_block_locator :: %{
          blockReason: CDPotion.Domain.Page.permissions_policy_block_reason(),
          frameId: CDPotion.Domain.Page.frame_id()
        }

  @typedoc "Reason for a permissions policy feature to be disabled."
  @type permissions_policy_block_reason ::
          :Header | :IframeAttribute | :InFencedFrameTree | :InIsolatedApp

  @typedoc "All Permissions Policy features. This enum should match the one defined
in third_party/blink/renderer/core/permissions_policy/permissions_policy_features.json5."
  @type permissions_policy_feature ::
          :accelerometer
          | :"ambient-light-sensor"
          | :"attribution-reporting"
          | :autoplay
          | :bluetooth
          | :"browsing-topics"
          | :camera
          | :"ch-dpr"
          | :"ch-device-memory"
          | :"ch-downlink"
          | :"ch-ect"
          | :"ch-prefers-color-scheme"
          | :"ch-prefers-reduced-motion"
          | :"ch-rtt"
          | :"ch-save-data"
          | :"ch-ua"
          | :"ch-ua-arch"
          | :"ch-ua-bitness"
          | :"ch-ua-platform"
          | :"ch-ua-model"
          | :"ch-ua-mobile"
          | :"ch-ua-form-factor"
          | :"ch-ua-full-version"
          | :"ch-ua-full-version-list"
          | :"ch-ua-platform-version"
          | :"ch-ua-wow64"
          | :"ch-viewport-height"
          | :"ch-viewport-width"
          | :"ch-width"
          | :"clipboard-read"
          | :"clipboard-write"
          | :"compute-pressure"
          | :"cross-origin-isolated"
          | :"direct-sockets"
          | :"display-capture"
          | :"document-domain"
          | :"encrypted-media"
          | :"execution-while-out-of-viewport"
          | :"execution-while-not-rendered"
          | :"focus-without-user-activation"
          | :fullscreen
          | :frobulate
          | :gamepad
          | :geolocation
          | :gyroscope
          | :hid
          | :"identity-credentials-get"
          | :"idle-detection"
          | :"interest-cohort"
          | :"join-ad-interest-group"
          | :"keyboard-map"
          | :"local-fonts"
          | :magnetometer
          | :microphone
          | :midi
          | :"otp-credentials"
          | :payment
          | :"picture-in-picture"
          | :"private-aggregation"
          | :"private-state-token-issuance"
          | :"private-state-token-redemption"
          | :"publickey-credentials-get"
          | :"run-ad-auction"
          | :"screen-wake-lock"
          | :serial
          | :"shared-autofill"
          | :"shared-storage"
          | :"shared-storage-select-url"
          | :"smart-card"
          | :"storage-access"
          | :"sync-xhr"
          | :unload
          | :usb
          | :"vertical-scroll"
          | :"web-share"
          | :"window-management"
          | :"window-placement"
          | :"xr-spatial-tracking"

  @typedoc "description not provided :("
  @type permissions_policy_feature_state :: %{
          allowed: boolean(),
          feature: CDPotion.Domain.Page.permissions_policy_feature(),
          locator: CDPotion.Domain.Page.permissions_policy_block_locator() | nil
        }

  @typedoc "The referring-policy used for the navigation."
  @type referrer_policy ::
          :noReferrer
          | :noReferrerWhenDowngrade
          | :origin
          | :originWhenCrossOrigin
          | :sameOrigin
          | :strictOrigin
          | :strictOriginWhenCrossOrigin
          | :unsafeUrl

  @typedoc "Screencast frame metadata."
  @type screencast_frame_metadata :: %{
          deviceHeight: number(),
          deviceWidth: number(),
          offsetTop: number(),
          pageScaleFactor: number(),
          scrollOffsetX: number(),
          scrollOffsetY: number(),
          timestamp: CDPotion.Domain.Network.time_since_epoch() | nil
        }

  @typedoc "Font families collection for a script."
  @type script_font_families :: %{
          fontFamilies: CDPotion.Domain.Page.font_families(),
          script: String.t()
        }

  @typedoc "Unique script identifier."
  @type script_identifier :: String.t()

  @typedoc "Indicates whether the frame is a secure context and why it is the case."
  @type secure_context_type :: :Secure | :SecureLocalhost | :InsecureScheme | :InsecureAncestor

  @typedoc "Transition type."
  @type transition_type ::
          :link
          | :typed
          | :address_bar
          | :auto_bookmark
          | :auto_subframe
          | :manual_subframe
          | :generated
          | :auto_toplevel
          | :form_submit
          | :reload
          | :keyword
          | :keyword_generated
          | :other

  @typedoc "Viewport for capturing screenshot."
  @type viewport :: %{
          height: number(),
          scale: number(),
          width: number(),
          x: number(),
          y: number()
        }

  @typedoc "Visual viewport position, dimensions, and scale."
  @type visual_viewport :: %{
          clientHeight: number(),
          clientWidth: number(),
          offsetX: number(),
          offsetY: number(),
          pageX: number(),
          pageY: number(),
          scale: number(),
          zoom: number() | nil
        }

  @doc """
  Deprecated, please use addScriptToEvaluateOnNewDocument instead.
  ## Parameters:
    - (Required) `script_source`: description not provided :(
  """
  @spec add_script_to_evaluate_on_load(String.t()) :: {String.t(), map()}
  def add_script_to_evaluate_on_load(script_source) do
    params = as_query([{"scriptSource", script_source}])
    {"Page.addScriptToEvaluateOnLoad", params}
  end

  @doc """
  Evaluates given script in every frame upon creation (before loading frame's scripts).
  ## Parameters:
    - (Required) `source`: description not provided :(
  - (Optional) `world_name`: If specified, creates an isolated world with the given name and evaluates given script in it.
  This world name will be used as the ExecutionContextDescription::name when the corresponding
  event is emitted.
  - (Optional) `include_command_line_api`: Specifies whether command line API should be available to the script, defaults
  to false.
  - (Optional) `run_immediately`: If true, runs the script immediately on existing execution contexts or worlds.
  Default: false.
  """
  @spec add_script_to_evaluate_on_new_document(String.t(), String.t(), boolean(), boolean()) ::
          {String.t(), map()}
  def add_script_to_evaluate_on_new_document(
        source,
        world_name \\ nil,
        include_command_line_api \\ nil,
        run_immediately \\ nil
      ) do
    params =
      as_query([
        {"source", source},
        {"worldName", world_name},
        {"includeCommandLineAPI", include_command_line_api},
        {"runImmediately", run_immediately}
      ])

    {"Page.addScriptToEvaluateOnNewDocument", params}
  end

  @doc """
  Brings page to front (activates tab).
  """
  @spec bring_to_front() :: {String.t(), map()}
  def bring_to_front() do
    {"Page.bringToFront", %{}}
  end

  @doc """
  Capture page screenshot.
  ## Parameters:
    - (Optional) `format`: Image compression format (defaults to png).
  - (Optional) `quality`: Compression quality from range [0..100] (jpeg only).
  - (Optional) `clip`: Capture the screenshot of a given region only.
  - (Optional) `from_surface`: Capture the screenshot from the surface, rather than the view. Defaults to true.
  - (Optional) `capture_beyond_viewport`: Capture the screenshot beyond the viewport. Defaults to false.
  - (Optional) `optimize_for_speed`: Optimize image encoding for speed, not for resulting size (defaults to false)
  """
  @spec capture_screenshot(
          String.t(),
          integer(),
          CDPotion.Domain.Page.Viewport,
          boolean(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
  def capture_screenshot(
        format \\ nil,
        quality \\ nil,
        clip \\ nil,
        from_surface \\ nil,
        capture_beyond_viewport \\ nil,
        optimize_for_speed \\ nil
      ) do
    params =
      as_query([
        {"format", format},
        {"quality", quality},
        {"clip", clip},
        {"fromSurface", from_surface},
        {"captureBeyondViewport", capture_beyond_viewport},
        {"optimizeForSpeed", optimize_for_speed}
      ])

    {"Page.captureScreenshot", params}
  end

  @doc """
  Returns a snapshot of the page as a string. For MHTML format, the serialization includes
  iframes, shadow DOM, external resources, and element-inline styles.
  ## Parameters:
    - (Optional) `format`: Format (defaults to mhtml).
  """
  @spec capture_snapshot(String.t()) :: {String.t(), map()}
  def capture_snapshot(format \\ nil) do
    params = as_query([{"format", format}])
    {"Page.captureSnapshot", params}
  end

  @doc """
  Clears the overridden device metrics.
  """
  @spec clear_device_metrics_override() :: {String.t(), map()}
  def clear_device_metrics_override() do
    {"Page.clearDeviceMetricsOverride", %{}}
  end

  @doc """
  Clears the overridden Device Orientation.
  """
  @spec clear_device_orientation_override() :: {String.t(), map()}
  def clear_device_orientation_override() do
    {"Page.clearDeviceOrientationOverride", %{}}
  end

  @doc """
  Clears the overridden Geolocation Position and Error.
  """
  @spec clear_geolocation_override() :: {String.t(), map()}
  def clear_geolocation_override() do
    {"Page.clearGeolocationOverride", %{}}
  end

  @doc """
  Creates an isolated world for the given frame.
  ## Parameters:
    - (Required) `frame_id`: Id of the frame in which the isolated world should be created.
  - (Optional) `world_name`: An optional name which is reported in the Execution Context.
  - (Optional) `grant_univeral_access`: Whether or not universal access should be granted to the isolated world. This is a powerful
  option, use with caution.
  """
  @spec create_isolated_world(CDPotion.Domain.Page.FrameId, String.t(), boolean()) ::
          {String.t(), map()}
  def create_isolated_world(frame_id, world_name \\ nil, grant_univeral_access \\ nil) do
    params =
      as_query([
        {"frameId", frame_id},
        {"worldName", world_name},
        {"grantUniveralAccess", grant_univeral_access}
      ])

    {"Page.createIsolatedWorld", params}
  end

  @doc """
  Deletes browser cookie with given name, domain and path.
  ## Parameters:
    - (Required) `cookie_name`: Name of the cookie to remove.
  - (Required) `url`: URL to match cooke domain and path.
  """
  @spec delete_cookie(String.t(), String.t()) :: {String.t(), map()}
  def delete_cookie(cookie_name, url) do
    params = as_query([{"cookieName", cookie_name}, {"url", url}])
    {"Page.deleteCookie", params}
  end

  @doc """
  Disables page domain notifications.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Page.disable", %{}}
  end

  @doc """
  Enables page domain notifications.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Page.enable", %{}}
  end

  @doc """

  """
  @spec get_app_manifest() :: {String.t(), map()}
  def get_app_manifest() do
    {"Page.getAppManifest", %{}}
  end

  @doc """

  """
  @spec get_installability_errors() :: {String.t(), map()}
  def get_installability_errors() do
    {"Page.getInstallabilityErrors", %{}}
  end

  @doc """
  Deprecated because it's not guaranteed that the returned icon is in fact the one used for PWA installation.
  """
  @spec get_manifest_icons() :: {String.t(), map()}
  def get_manifest_icons() do
    {"Page.getManifestIcons", %{}}
  end

  @doc """
  Returns the unique (PWA) app id.
  Only returns values if the feature flag 'WebAppEnableManifestId' is enabled
  """
  @spec get_app_id() :: {String.t(), map()}
  def get_app_id() do
    {"Page.getAppId", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `frame_id`: description not provided :(
  """
  @spec get_ad_script_id(CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_ad_script_id(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Page.getAdScriptId", params}
  end

  @doc """
  Returns all browser cookies for the page and all of its subframes. Depending
  on the backend support, will return detailed cookie information in the
  `cookies` field.
  """
  @spec get_cookies() :: {String.t(), map()}
  def get_cookies() do
    {"Page.getCookies", %{}}
  end

  @doc """
  Returns present frame tree structure.
  """
  @spec get_frame_tree() :: {String.t(), map()}
  def get_frame_tree() do
    {"Page.getFrameTree", %{}}
  end

  @doc """
  Returns metrics relating to the layouting of the page, such as viewport bounds/scale.
  """
  @spec get_layout_metrics() :: {String.t(), map()}
  def get_layout_metrics() do
    {"Page.getLayoutMetrics", %{}}
  end

  @doc """
  Returns navigation history for the current page.
  """
  @spec get_navigation_history() :: {String.t(), map()}
  def get_navigation_history() do
    {"Page.getNavigationHistory", %{}}
  end

  @doc """
  Resets navigation history for the current page.
  """
  @spec reset_navigation_history() :: {String.t(), map()}
  def reset_navigation_history() do
    {"Page.resetNavigationHistory", %{}}
  end

  @doc """
  Returns content of the given resource.
  ## Parameters:
    - (Required) `frame_id`: Frame id to get resource for.
  - (Required) `url`: URL of the resource to get content for.
  """
  @spec get_resource_content(CDPotion.Domain.Page.FrameId, String.t()) :: {String.t(), map()}
  def get_resource_content(frame_id, url) do
    params = as_query([{"frameId", frame_id}, {"url", url}])
    {"Page.getResourceContent", params}
  end

  @doc """
  Returns present frame / resource tree structure.
  """
  @spec get_resource_tree() :: {String.t(), map()}
  def get_resource_tree() do
    {"Page.getResourceTree", %{}}
  end

  @doc """
  Accepts or dismisses a JavaScript initiated dialog (alert, confirm, prompt, or onbeforeunload).
  ## Parameters:
    - (Required) `accept`: Whether to accept or dismiss the dialog.
  - (Optional) `prompt_text`: The text to enter into the dialog prompt before accepting. Used only if this is a prompt
  dialog.
  """
  @spec handle_java_script_dialog(boolean(), String.t()) :: {String.t(), map()}
  def handle_java_script_dialog(accept, prompt_text \\ nil) do
    params = as_query([{"accept", accept}, {"promptText", prompt_text}])
    {"Page.handleJavaScriptDialog", params}
  end

  @doc """
  Navigates current page to the given URL.
  ## Parameters:
    - (Required) `url`: URL to navigate the page to.
  - (Optional) `referrer`: Referrer URL.
  - (Optional) `transition_type`: Intended transition type.
  - (Optional) `frame_id`: Frame id to navigate, if not specified navigates the top frame.
  - (Optional) `referrer_policy`: Referrer-policy used for the navigation.
  """
  @spec navigate(
          String.t(),
          String.t(),
          CDPotion.Domain.Page.TransitionType,
          CDPotion.Domain.Page.FrameId,
          CDPotion.Domain.Page.ReferrerPolicy
        ) :: {String.t(), map()}
  def navigate(
        url,
        referrer \\ nil,
        transition_type \\ nil,
        frame_id \\ nil,
        referrer_policy \\ nil
      ) do
    params =
      as_query([
        {"url", url},
        {"referrer", referrer},
        {"transitionType", transition_type},
        {"frameId", frame_id},
        {"referrerPolicy", referrer_policy}
      ])

    {"Page.navigate", params}
  end

  @doc """
  Navigates current page to the given history entry.
  ## Parameters:
    - (Required) `entry_id`: Unique id of the entry to navigate to.
  """
  @spec navigate_to_history_entry(integer()) :: {String.t(), map()}
  def navigate_to_history_entry(entry_id) do
    params = as_query([{"entryId", entry_id}])
    {"Page.navigateToHistoryEntry", params}
  end

  @doc """
  Print page as PDF.
  ## Parameters:
    - (Optional) `landscape`: Paper orientation. Defaults to false.
  - (Optional) `display_header_footer`: Display header and footer. Defaults to false.
  - (Optional) `print_background`: Print background graphics. Defaults to false.
  - (Optional) `scale`: Scale of the webpage rendering. Defaults to 1.
  - (Optional) `paper_width`: Paper width in inches. Defaults to 8.5 inches.
  - (Optional) `paper_height`: Paper height in inches. Defaults to 11 inches.
  - (Optional) `margin_top`: Top margin in inches. Defaults to 1cm (~0.4 inches).
  - (Optional) `margin_bottom`: Bottom margin in inches. Defaults to 1cm (~0.4 inches).
  - (Optional) `margin_left`: Left margin in inches. Defaults to 1cm (~0.4 inches).
  - (Optional) `margin_right`: Right margin in inches. Defaults to 1cm (~0.4 inches).
  - (Optional) `page_ranges`: Paper ranges to print, one based, e.g., '1-5, 8, 11-13'. Pages are
  printed in the document order, not in the order specified, and no
  more than once.
  Defaults to empty string, which implies the entire document is printed.
  The page numbers are quietly capped to actual page count of the
  document, and ranges beyond the end of the document are ignored.
  If this results in no pages to print, an error is reported.
  It is an error to specify a range with start greater than end.
  - (Optional) `header_template`: HTML template for the print header. Should be valid HTML markup with following
  classes used to inject printing values into them:
  - `date`: formatted print date
  - `title`: document title
  - `url`: document location
  - `pageNumber`: current page number
  - `totalPages`: total pages in the document
  For example, `<span class=title></span>` would generate span containing the title.
  - (Optional) `footer_template`: HTML template for the print footer. Should use the same format as the `headerTemplate`.
  - (Optional) `prefer_css_page_size`: Whether or not to prefer page size as defined by css. Defaults to false,
  in which case the content will be scaled to fit the paper size.
  - (Optional) `transfer_mode`: return as stream
  """
  @spec print_to_pdf(
          boolean(),
          boolean(),
          boolean(),
          number(),
          number(),
          number(),
          number(),
          number(),
          number(),
          number(),
          String.t(),
          String.t(),
          String.t(),
          boolean(),
          String.t()
        ) :: {String.t(), map()}
  def print_to_pdf(
        landscape \\ nil,
        display_header_footer \\ nil,
        print_background \\ nil,
        scale \\ nil,
        paper_width \\ nil,
        paper_height \\ nil,
        margin_top \\ nil,
        margin_bottom \\ nil,
        margin_left \\ nil,
        margin_right \\ nil,
        page_ranges \\ nil,
        header_template \\ nil,
        footer_template \\ nil,
        prefer_css_page_size \\ nil,
        transfer_mode \\ nil
      ) do
    params =
      as_query([
        {"landscape", landscape},
        {"displayHeaderFooter", display_header_footer},
        {"printBackground", print_background},
        {"scale", scale},
        {"paperWidth", paper_width},
        {"paperHeight", paper_height},
        {"marginTop", margin_top},
        {"marginBottom", margin_bottom},
        {"marginLeft", margin_left},
        {"marginRight", margin_right},
        {"pageRanges", page_ranges},
        {"headerTemplate", header_template},
        {"footerTemplate", footer_template},
        {"preferCSSPageSize", prefer_css_page_size},
        {"transferMode", transfer_mode}
      ])

    {"Page.printToPDF", params}
  end

  @doc """
  Reloads given page optionally ignoring the cache.
  ## Parameters:
    - (Optional) `ignore_cache`: If true, browser cache is ignored (as if the user pressed Shift+refresh).
  - (Optional) `script_to_evaluate_on_load`: If set, the script will be injected into all frames of the inspected page after reload.
  Argument will be ignored if reloading dataURL origin.
  """
  @spec reload(boolean(), String.t()) :: {String.t(), map()}
  def reload(ignore_cache \\ nil, script_to_evaluate_on_load \\ nil) do
    params =
      as_query([
        {"ignoreCache", ignore_cache},
        {"scriptToEvaluateOnLoad", script_to_evaluate_on_load}
      ])

    {"Page.reload", params}
  end

  @doc """
  Deprecated, please use removeScriptToEvaluateOnNewDocument instead.
  ## Parameters:
    - (Required) `identifier`: description not provided :(
  """
  @spec remove_script_to_evaluate_on_load(CDPotion.Domain.Page.ScriptIdentifier) ::
          {String.t(), map()}
  def remove_script_to_evaluate_on_load(identifier) do
    params = as_query([{"identifier", identifier}])
    {"Page.removeScriptToEvaluateOnLoad", params}
  end

  @doc """
  Removes given script from the list.
  ## Parameters:
    - (Required) `identifier`: description not provided :(
  """
  @spec remove_script_to_evaluate_on_new_document(CDPotion.Domain.Page.ScriptIdentifier) ::
          {String.t(), map()}
  def remove_script_to_evaluate_on_new_document(identifier) do
    params = as_query([{"identifier", identifier}])
    {"Page.removeScriptToEvaluateOnNewDocument", params}
  end

  @doc """
  Acknowledges that a screencast frame has been received by the frontend.
  ## Parameters:
    - (Required) `session_id`: Frame number.
  """
  @spec screencast_frame_ack(integer()) :: {String.t(), map()}
  def screencast_frame_ack(session_id) do
    params = as_query([{"sessionId", session_id}])
    {"Page.screencastFrameAck", params}
  end

  @doc """
  Searches for given string in resource content.
  ## Parameters:
    - (Required) `frame_id`: Frame id for resource to search in.
  - (Required) `url`: URL of the resource to search in.
  - (Required) `query`: String to search for.
  - (Optional) `case_sensitive`: If true, search is case sensitive.
  - (Optional) `is_regex`: If true, treats string parameter as regex.
  """
  @spec search_in_resource(
          CDPotion.Domain.Page.FrameId,
          String.t(),
          String.t(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
  def search_in_resource(frame_id, url, query, case_sensitive \\ nil, is_regex \\ nil) do
    params =
      as_query([
        {"frameId", frame_id},
        {"url", url},
        {"query", query},
        {"caseSensitive", case_sensitive},
        {"isRegex", is_regex}
      ])

    {"Page.searchInResource", params}
  end

  @doc """
  Enable Chrome's experimental ad filter on all sites.
  ## Parameters:
    - (Required) `enabled`: Whether to block ads.
  """
  @spec set_ad_blocking_enabled(boolean()) :: {String.t(), map()}
  def set_ad_blocking_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setAdBlockingEnabled", params}
  end

  @doc """
  Enable page Content Security Policy by-passing.
  ## Parameters:
    - (Required) `enabled`: Whether to bypass page CSP.
  """
  @spec set_bypass_csp(boolean()) :: {String.t(), map()}
  def set_bypass_csp(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setBypassCSP", params}
  end

  @doc """
  Get Permissions Policy state on given frame.
  ## Parameters:
    - (Required) `frame_id`: description not provided :(
  """
  @spec get_permissions_policy_state(CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_permissions_policy_state(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Page.getPermissionsPolicyState", params}
  end

  @doc """
  Get Origin Trials on given frame.
  ## Parameters:
    - (Required) `frame_id`: description not provided :(
  """
  @spec get_origin_trials(CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_origin_trials(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Page.getOriginTrials", params}
  end

  @doc """
  Overrides the values of device screen dimensions (window.screen.width, window.screen.height,
  window.innerWidth, window.innerHeight, and "device-width"/"device-height"-related CSS media
  query results).
  ## Parameters:
    - (Required) `width`: Overriding width value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  - (Required) `height`: Overriding height value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  - (Required) `device_scale_factor`: Overriding device scale factor value. 0 disables the override.
  - (Required) `mobile`: Whether to emulate mobile device. This includes viewport meta tag, overlay scrollbars, text
  autosizing and more.
  - (Optional) `scale`: Scale to apply to resulting view image.
  - (Optional) `screen_width`: Overriding screen width value in pixels (minimum 0, maximum 10000000).
  - (Optional) `screen_height`: Overriding screen height value in pixels (minimum 0, maximum 10000000).
  - (Optional) `position_x`: Overriding view X position on screen in pixels (minimum 0, maximum 10000000).
  - (Optional) `position_y`: Overriding view Y position on screen in pixels (minimum 0, maximum 10000000).
  - (Optional) `dont_set_visible_size`: Do not set visible view size, rely upon explicit setVisibleSize call.
  - (Optional) `screen_orientation`: Screen orientation override.
  - (Optional) `viewport`: The viewport dimensions and scale. If not set, the override is cleared.
  """
  @spec set_device_metrics_override(
          integer(),
          integer(),
          number(),
          boolean(),
          number(),
          integer(),
          integer(),
          integer(),
          integer(),
          boolean(),
          CDPotion.Domain.Emulation.ScreenOrientation,
          CDPotion.Domain.Page.Viewport
        ) :: {String.t(), map()}
  def set_device_metrics_override(
        width,
        height,
        device_scale_factor,
        mobile,
        scale \\ nil,
        screen_width \\ nil,
        screen_height \\ nil,
        position_x \\ nil,
        position_y \\ nil,
        dont_set_visible_size \\ nil,
        screen_orientation \\ nil,
        viewport \\ nil
      ) do
    params =
      as_query([
        {"width", width},
        {"height", height},
        {"deviceScaleFactor", device_scale_factor},
        {"mobile", mobile},
        {"scale", scale},
        {"screenWidth", screen_width},
        {"screenHeight", screen_height},
        {"positionX", position_x},
        {"positionY", position_y},
        {"dontSetVisibleSize", dont_set_visible_size},
        {"screenOrientation", screen_orientation},
        {"viewport", viewport}
      ])

    {"Page.setDeviceMetricsOverride", params}
  end

  @doc """
  Overrides the Device Orientation.
  ## Parameters:
    - (Required) `alpha`: Mock alpha
  - (Required) `beta`: Mock beta
  - (Required) `gamma`: Mock gamma
  """
  @spec set_device_orientation_override(number(), number(), number()) :: {String.t(), map()}
  def set_device_orientation_override(alpha, beta, gamma) do
    params = as_query([{"alpha", alpha}, {"beta", beta}, {"gamma", gamma}])
    {"Page.setDeviceOrientationOverride", params}
  end

  @doc """
  Set generic font families.
  ## Parameters:
    - (Required) `font_families`: Specifies font families to set. If a font family is not specified, it won't be changed.
  - (Optional) `for_scripts`: Specifies font families to set for individual scripts.
  """
  @spec set_font_families(
          CDPotion.Domain.Page.FontFamilies,
          list(CDPotion.Domain.Page.ScriptFontFamilies)
        ) :: {String.t(), map()}
  def set_font_families(font_families, for_scripts \\ nil) do
    params = as_query([{"fontFamilies", font_families}, {"forScripts", for_scripts}])
    {"Page.setFontFamilies", params}
  end

  @doc """
  Set default font sizes.
  ## Parameters:
    - (Required) `font_sizes`: Specifies font sizes to set. If a font size is not specified, it won't be changed.
  """
  @spec set_font_sizes(CDPotion.Domain.Page.FontSizes) :: {String.t(), map()}
  def set_font_sizes(font_sizes) do
    params = as_query([{"fontSizes", font_sizes}])
    {"Page.setFontSizes", params}
  end

  @doc """
  Sets given markup as the document's HTML.
  ## Parameters:
    - (Required) `frame_id`: Frame id to set HTML for.
  - (Required) `html`: HTML content to set.
  """
  @spec set_document_content(CDPotion.Domain.Page.FrameId, String.t()) :: {String.t(), map()}
  def set_document_content(frame_id, html) do
    params = as_query([{"frameId", frame_id}, {"html", html}])
    {"Page.setDocumentContent", params}
  end

  @doc """
  Set the behavior when downloading a file.
  ## Parameters:
    - (Required) `behavior`: Whether to allow all or deny all download requests, or use default Chrome behavior if
  available (otherwise deny).
  - (Optional) `download_path`: The default path to save downloaded files to. This is required if behavior is set to 'allow'
  """
  @spec set_download_behavior(String.t(), String.t()) :: {String.t(), map()}
  def set_download_behavior(behavior, download_path \\ nil) do
    params = as_query([{"behavior", behavior}, {"downloadPath", download_path}])
    {"Page.setDownloadBehavior", params}
  end

  @doc """
  Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  unavailable.
  ## Parameters:
    - (Optional) `latitude`: Mock latitude
  - (Optional) `longitude`: Mock longitude
  - (Optional) `accuracy`: Mock accuracy
  """
  @spec set_geolocation_override(number(), number(), number()) :: {String.t(), map()}
  def set_geolocation_override(latitude \\ nil, longitude \\ nil, accuracy \\ nil) do
    params = as_query([{"latitude", latitude}, {"longitude", longitude}, {"accuracy", accuracy}])
    {"Page.setGeolocationOverride", params}
  end

  @doc """
  Controls whether page will emit lifecycle events.
  ## Parameters:
    - (Required) `enabled`: If true, starts emitting lifecycle events.
  """
  @spec set_lifecycle_events_enabled(boolean()) :: {String.t(), map()}
  def set_lifecycle_events_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setLifecycleEventsEnabled", params}
  end

  @doc """
  Toggles mouse event-based touch event emulation.
  ## Parameters:
    - (Required) `enabled`: Whether the touch event emulation should be enabled.
  - (Optional) `configuration`: Touch/gesture events configuration. Default: current platform.
  """
  @spec set_touch_emulation_enabled(boolean(), String.t()) :: {String.t(), map()}
  def set_touch_emulation_enabled(enabled, configuration \\ nil) do
    params = as_query([{"enabled", enabled}, {"configuration", configuration}])
    {"Page.setTouchEmulationEnabled", params}
  end

  @doc """
  Starts sending each frame using the `screencastFrame` event.
  ## Parameters:
    - (Optional) `format`: Image compression format.
  - (Optional) `quality`: Compression quality from range [0..100].
  - (Optional) `max_width`: Maximum screenshot width.
  - (Optional) `max_height`: Maximum screenshot height.
  - (Optional) `every_nth_frame`: Send every n-th frame.
  """
  @spec start_screencast(String.t(), integer(), integer(), integer(), integer()) ::
          {String.t(), map()}
  def start_screencast(
        format \\ nil,
        quality \\ nil,
        max_width \\ nil,
        max_height \\ nil,
        every_nth_frame \\ nil
      ) do
    params =
      as_query([
        {"format", format},
        {"quality", quality},
        {"maxWidth", max_width},
        {"maxHeight", max_height},
        {"everyNthFrame", every_nth_frame}
      ])

    {"Page.startScreencast", params}
  end

  @doc """
  Force the page stop all navigations and pending resource fetches.
  """
  @spec stop_loading() :: {String.t(), map()}
  def stop_loading() do
    {"Page.stopLoading", %{}}
  end

  @doc """
  Crashes renderer on the IO thread, generates minidumps.
  """
  @spec crash() :: {String.t(), map()}
  def crash() do
    {"Page.crash", %{}}
  end

  @doc """
  Tries to close page, running its beforeunload hooks, if any.
  """
  @spec close() :: {String.t(), map()}
  def close() do
    {"Page.close", %{}}
  end

  @doc """
  Tries to update the web lifecycle state of the page.
  It will transition the page to the given state according to:
  https://github.com/WICG/web-lifecycle/
  ## Parameters:
    - (Required) `state`: Target lifecycle state
  """
  @spec set_web_lifecycle_state(String.t()) :: {String.t(), map()}
  def set_web_lifecycle_state(state) do
    params = as_query([{"state", state}])
    {"Page.setWebLifecycleState", params}
  end

  @doc """
  Stops sending each frame in the `screencastFrame`.
  """
  @spec stop_screencast() :: {String.t(), map()}
  def stop_screencast() do
    {"Page.stopScreencast", %{}}
  end

  @doc """
  Requests backend to produce compilation cache for the specified scripts.
  `scripts` are appeneded to the list of scripts for which the cache
  would be produced. The list may be reset during page navigation.
  When script with a matching URL is encountered, the cache is optionally
  produced upon backend discretion, based on internal heuristics.
  See also: `Page.compilationCacheProduced`.
  ## Parameters:
    - (Required) `scripts`: description not provided :(
  """
  @spec produce_compilation_cache(list(CDPotion.Domain.Page.CompilationCacheParams)) ::
          {String.t(), map()}
  def produce_compilation_cache(scripts) do
    params = as_query([{"scripts", scripts}])
    {"Page.produceCompilationCache", params}
  end

  @doc """
  Seeds compilation cache for given url. Compilation cache does not survive
  cross-process navigation.
  ## Parameters:
    - (Required) `url`: description not provided :(
  - (Required) `data`: Base64-encoded data (Encoded as a base64 string when passed over JSON)
  """
  @spec add_compilation_cache(String.t(), String.t()) :: {String.t(), map()}
  def add_compilation_cache(url, data) do
    params = as_query([{"url", url}, {"data", data}])
    {"Page.addCompilationCache", params}
  end

  @doc """
  Clears seeded compilation cache.
  """
  @spec clear_compilation_cache() :: {String.t(), map()}
  def clear_compilation_cache() do
    {"Page.clearCompilationCache", %{}}
  end

  @doc """
  Sets the Secure Payment Confirmation transaction mode.
  https://w3c.github.io/secure-payment-confirmation/#sctn-automation-set-spc-transaction-mode
  ## Parameters:
    - (Required) `mode`: description not provided :(
  """
  @spec set_spc_transaction_mode(CDPotion.Domain.Page.AutoResponseMode) :: {String.t(), map()}
  def set_spc_transaction_mode(mode) do
    params = as_query([{"mode", mode}])
    {"Page.setSPCTransactionMode", params}
  end

  @doc """
  Extensions for Custom Handlers API:
  https://html.spec.whatwg.org/multipage/system-state.html#rph-automation
  ## Parameters:
    - (Required) `mode`: description not provided :(
  """
  @spec set_rph_registration_mode(CDPotion.Domain.Page.AutoResponseMode) :: {String.t(), map()}
  def set_rph_registration_mode(mode) do
    params = as_query([{"mode", mode}])
    {"Page.setRPHRegistrationMode", params}
  end

  @doc """
  Generates a report for testing.
  ## Parameters:
    - (Required) `message`: Message to be displayed in the report.
  - (Optional) `group`: Specifies the endpoint group to deliver the report to.
  """
  @spec generate_test_report(String.t(), String.t()) :: {String.t(), map()}
  def generate_test_report(message, group \\ nil) do
    params = as_query([{"message", message}, {"group", group}])
    {"Page.generateTestReport", params}
  end

  @doc """
  Pauses page execution. Can be resumed using generic Runtime.runIfWaitingForDebugger.
  """
  @spec wait_for_debugger() :: {String.t(), map()}
  def wait_for_debugger() do
    {"Page.waitForDebugger", %{}}
  end

  @doc """
  Intercept file chooser requests and transfer control to protocol clients.
  When file chooser interception is enabled, native file chooser dialog is not shown.
  Instead, a protocol event `Page.fileChooserOpened` is emitted.
  ## Parameters:
    - (Required) `enabled`: description not provided :(
  """
  @spec set_intercept_file_chooser_dialog(boolean()) :: {String.t(), map()}
  def set_intercept_file_chooser_dialog(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setInterceptFileChooserDialog", params}
  end

  @doc """
  Enable/disable prerendering manually.
  This command is a short-term solution for https://crbug.com/1440085.
  See https://docs.google.com/document/d/12HVmFxYj5Jc-eJr5OmWsa2bqTJsbgGLKI6ZIyx0_wpA
  for more details.
  TODO(https://crbug.com/1440085): Remove this once Puppeteer supports tab targets.
  ## Parameters:
    - (Required) `is_allowed`: description not provided :(
  """
  @spec set_prerendering_allowed(boolean()) :: {String.t(), map()}
  def set_prerendering_allowed(is_allowed) do
    params = as_query([{"isAllowed", is_allowed}])
    {"Page.setPrerenderingAllowed", params}
  end
end
