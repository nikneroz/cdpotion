defmodule CDPotion.Domain.Page do
  use CDPotion.Utils
  @doc "description not provided :("
  @type AdFrameExplanation :: :ParentIsAd | :CreatedByAdScript | :MatchedBlockingRule

  @doc "Indicates whether a frame has been identified as an ad and why."
  @type AdFrameStatus :: %{
          adFrameType: Page.AdFrameType,
          explanations: list(Page.AdFrameExplanation) | nil
        }

  @doc "Indicates whether a frame has been identified as an ad."
  @type AdFrameType :: :none | :child | :root

  @doc "Identifies the bottom-most script which caused the frame to be labelled
as an ad."
  @type AdScriptId :: %{
          debuggerId: Runtime.UniqueDebuggerId,
          scriptId: Runtime.ScriptId
        }

  @doc "Error while paring app manifest."
  @type AppManifestError :: %{
          column: integer(),
          critical: integer(),
          line: integer(),
          message: String.t()
        }

  @doc "Parsed app manifest properties."
  @type AppManifestParsedProperties :: %{
          scope: String.t()
        }

  @doc "Enum of possible auto-reponse for permisison / prompt dialogs."
  @type AutoResponseMode :: :none | :autoAccept | :autoReject | :autoOptOut

  @doc "description not provided :("
  @type BackForwardCacheNotRestoredExplanation :: %{
          context: String.t() | nil,
          reason: Page.BackForwardCacheNotRestoredReason,
          type: Page.BackForwardCacheNotRestoredReasonType
        }

  @doc "description not provided :("
  @type BackForwardCacheNotRestoredExplanationTree :: %{
          children: list(Page.BackForwardCacheNotRestoredExplanationTree),
          explanations: list(Page.BackForwardCacheNotRestoredExplanation),
          url: String.t()
        }

  @doc "List of not restored reasons for back-forward cache."
  @type BackForwardCacheNotRestoredReason ::
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

  @doc "Types of not restored reasons for back-forward cache."
  @type BackForwardCacheNotRestoredReasonType ::
          :SupportPending | :PageSupportNeeded | :Circumstantial

  @doc "description not provided :("
  @type ClientNavigationDisposition :: :currentTab | :newTab | :newWindow | :download

  @doc "description not provided :("
  @type ClientNavigationReason ::
          :formSubmissionGet
          | :formSubmissionPost
          | :httpHeaderRefresh
          | :scriptInitiated
          | :metaTagRefresh
          | :pageBlockInterstitial
          | :reload
          | :anchorClick

  @doc "Per-script compilation cache parameters for `Page.produceCompilationCache`"
  @type CompilationCacheParams :: %{
          eager: boolean() | nil,
          url: String.t()
        }

  @doc "Indicates whether the frame is cross-origin isolated and why it is the case."
  @type CrossOriginIsolatedContextType :: :Isolated | :NotIsolated | :NotIsolatedFeatureDisabled

  @doc "Javascript dialog type."
  @type DialogType :: :alert | :confirm | :prompt | :beforeunload

  @doc "Generic font families collection."
  @type FontFamilies :: %{
          cursive: String.t() | nil,
          fantasy: String.t() | nil,
          fixed: String.t() | nil,
          math: String.t() | nil,
          sansSerif: String.t() | nil,
          serif: String.t() | nil,
          standard: String.t() | nil
        }

  @doc "Default font sizes."
  @type FontSizes :: %{
          fixed: integer() | nil,
          standard: integer() | nil
        }

  @doc "Information about the Frame on the page."
  @type Frame :: %{
          adFrameStatus: Page.AdFrameStatus | nil,
          crossOriginIsolatedContextType: Page.CrossOriginIsolatedContextType,
          domainAndRegistry: String.t(),
          gatedAPIFeatures: list(Page.GatedAPIFeatures),
          id: Page.FrameId,
          loaderId: Network.LoaderId,
          mimeType: String.t(),
          name: String.t() | nil,
          parentId: Page.FrameId | nil,
          secureContextType: Page.SecureContextType,
          securityOrigin: String.t(),
          unreachableUrl: String.t() | nil,
          url: String.t(),
          urlFragment: String.t() | nil
        }

  @doc "Unique frame identifier."
  @type FrameId :: String.t()

  @doc "Information about the Resource on the page."
  @type FrameResource :: %{
          canceled: boolean() | nil,
          contentSize: number() | nil,
          failed: boolean() | nil,
          lastModified: Network.TimeSinceEpoch | nil,
          mimeType: String.t(),
          type: Network.ResourceType,
          url: String.t()
        }

  @doc "Information about the Frame hierarchy along with their cached resources."
  @type FrameResourceTree :: %{
          childFrames: list(Page.FrameResourceTree) | nil,
          frame: Page.Frame,
          resources: list(Page.FrameResource)
        }

  @doc "Information about the Frame hierarchy."
  @type FrameTree :: %{
          childFrames: list(Page.FrameTree) | nil,
          frame: Page.Frame
        }

  @doc "description not provided :("
  @type GatedAPIFeatures ::
          :SharedArrayBuffers
          | :SharedArrayBuffersTransferAllowed
          | :PerformanceMeasureMemory
          | :PerformanceProfile

  @doc "The installability error"
  @type InstallabilityError :: %{
          errorArguments: list(Page.InstallabilityErrorArgument),
          errorId: String.t()
        }

  @doc "description not provided :("
  @type InstallabilityErrorArgument :: %{
          name: String.t(),
          value: String.t()
        }

  @doc "Layout viewport position and dimensions."
  @type LayoutViewport :: %{
          clientHeight: integer(),
          clientWidth: integer(),
          pageX: integer(),
          pageY: integer()
        }

  @doc "Navigation history entry."
  @type NavigationEntry :: %{
          id: integer(),
          title: String.t(),
          transitionType: Page.TransitionType,
          url: String.t(),
          userTypedURL: String.t()
        }

  @doc "The type of a frameNavigated event."
  @type NavigationType :: :Navigation | :BackForwardCacheRestore

  @doc "description not provided :("
  @type OriginTrial :: %{
          status: Page.OriginTrialStatus,
          tokensWithStatus: list(Page.OriginTrialTokenWithStatus),
          trialName: String.t()
        }

  @doc "Status for an Origin Trial."
  @type OriginTrialStatus ::
          :Enabled | :ValidTokenNotProvided | :OSNotSupported | :TrialNotAllowed

  @doc "description not provided :("
  @type OriginTrialToken :: %{
          expiryTime: Network.TimeSinceEpoch,
          isThirdParty: boolean(),
          matchSubDomains: boolean(),
          origin: String.t(),
          trialName: String.t(),
          usageRestriction: Page.OriginTrialUsageRestriction
        }

  @doc "Origin Trial(https://www.chromium.org/blink/origin-trials) support.
Status for an Origin Trial token."
  @type OriginTrialTokenStatus ::
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

  @doc "description not provided :("
  @type OriginTrialTokenWithStatus :: %{
          parsedToken: Page.OriginTrialToken | nil,
          rawTokenText: String.t(),
          status: Page.OriginTrialTokenStatus
        }

  @doc "description not provided :("
  @type OriginTrialUsageRestriction :: :None | :Subset

  @doc "description not provided :("
  @type PermissionsPolicyBlockLocator :: %{
          blockReason: Page.PermissionsPolicyBlockReason,
          frameId: Page.FrameId
        }

  @doc "Reason for a permissions policy feature to be disabled."
  @type PermissionsPolicyBlockReason ::
          :Header | :IframeAttribute | :InFencedFrameTree | :InIsolatedApp

  @doc "All Permissions Policy features. This enum should match the one defined
in third_party/blink/renderer/core/permissions_policy/permissions_policy_features.json5."
  @type PermissionsPolicyFeature ::
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

  @doc "description not provided :("
  @type PermissionsPolicyFeatureState :: %{
          allowed: boolean(),
          feature: Page.PermissionsPolicyFeature,
          locator: Page.PermissionsPolicyBlockLocator | nil
        }

  @doc "The referring-policy used for the navigation."
  @type ReferrerPolicy ::
          :noReferrer
          | :noReferrerWhenDowngrade
          | :origin
          | :originWhenCrossOrigin
          | :sameOrigin
          | :strictOrigin
          | :strictOriginWhenCrossOrigin
          | :unsafeUrl

  @doc "Screencast frame metadata."
  @type ScreencastFrameMetadata :: %{
          deviceHeight: number(),
          deviceWidth: number(),
          offsetTop: number(),
          pageScaleFactor: number(),
          scrollOffsetX: number(),
          scrollOffsetY: number(),
          timestamp: Network.TimeSinceEpoch | nil
        }

  @doc "Font families collection for a script."
  @type ScriptFontFamilies :: %{
          fontFamilies: Page.FontFamilies,
          script: String.t()
        }

  @doc "Unique script identifier."
  @type ScriptIdentifier :: String.t()

  @doc "Indicates whether the frame is a secure context and why it is the case."
  @type SecureContextType :: :Secure | :SecureLocalhost | :InsecureScheme | :InsecureAncestor

  @doc "Transition type."
  @type TransitionType ::
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

  @doc "Viewport for capturing screenshot."
  @type Viewport :: %{
          height: number(),
          scale: number(),
          width: number(),
          x: number(),
          y: number()
        }

  @doc "Visual viewport position, dimensions, and scale."
  @type VisualViewport :: %{
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
    - `scriptSource:string`: description not provided :(
  """
  def add_script_to_evaluate_on_load(script_source) do
    params = as_query([{"scriptSource", script_source}])
    {"Page.addScriptToEvaluateOnLoad", params}
  end

  @doc """
  Evaluates given script in every frame upon creation (before loading frame's scripts).
  ## Parameters:
    - `source:string`: description not provided :(
    - `worldName:string`: (Optional) If specified, creates an isolated world with the given name and evaluates given script in it.
  This world name will be used as the ExecutionContextDescription::name when the corresponding
  event is emitted.
    - `includeCommandLineAPI:boolean`: (Optional) Specifies whether command line API should be available to the script, defaults
  to false.
    - `runImmediately:boolean`: (Optional) If true, runs the script immediately on existing execution contexts or worlds.
  Default: false.
  """
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
  def bring_to_front() do
    {"Page.bringToFront", %{}}
  end

  @doc """
  Capture page screenshot.
  ## Parameters:
    - `format:string`: (Optional) Image compression format (defaults to png).
    - `quality:integer`: (Optional) Compression quality from range [0..100] (jpeg only).
    - `clip:Viewport`: (Optional) Capture the screenshot of a given region only.
    - `fromSurface:boolean`: (Optional) Capture the screenshot from the surface, rather than the view. Defaults to true.
    - `captureBeyondViewport:boolean`: (Optional) Capture the screenshot beyond the viewport. Defaults to false.
    - `optimizeForSpeed:boolean`: (Optional) Optimize image encoding for speed, not for resulting size (defaults to false)
  """
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
    - `format:string`: (Optional) Format (defaults to mhtml).
  """
  def capture_snapshot(format \\ nil) do
    params = as_query([{"format", format}])
    {"Page.captureSnapshot", params}
  end

  @doc """
  Clears the overridden device metrics.
  """
  def clear_device_metrics_override() do
    {"Page.clearDeviceMetricsOverride", %{}}
  end

  @doc """
  Clears the overridden Device Orientation.
  """
  def clear_device_orientation_override() do
    {"Page.clearDeviceOrientationOverride", %{}}
  end

  @doc """
  Clears the overridden Geolocation Position and Error.
  """
  def clear_geolocation_override() do
    {"Page.clearGeolocationOverride", %{}}
  end

  @doc """
  Creates an isolated world for the given frame.
  ## Parameters:
    - `frameId:FrameId`: Id of the frame in which the isolated world should be created.
    - `worldName:string`: (Optional) An optional name which is reported in the Execution Context.
    - `grantUniveralAccess:boolean`: (Optional) Whether or not universal access should be granted to the isolated world. This is a powerful
  option, use with caution.
  """
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
    - `cookieName:string`: Name of the cookie to remove.
    - `url:string`: URL to match cooke domain and path.
  """
  def delete_cookie(cookie_name, url) do
    params = as_query([{"cookieName", cookie_name}, {"url", url}])
    {"Page.deleteCookie", params}
  end

  @doc """
  Disables page domain notifications.
  """
  def disable() do
    {"Page.disable", %{}}
  end

  @doc """
  Enables page domain notifications.
  """
  def enable() do
    {"Page.enable", %{}}
  end

  @doc """
  """
  def get_app_manifest() do
    {"Page.getAppManifest", %{}}
  end

  @doc """
  """
  def get_installability_errors() do
    {"Page.getInstallabilityErrors", %{}}
  end

  @doc """
  Deprecated because it's not guaranteed that the returned icon is in fact the one used for PWA installation.
  """
  def get_manifest_icons() do
    {"Page.getManifestIcons", %{}}
  end

  @doc """
  Returns the unique (PWA) app id.
  Only returns values if the feature flag 'WebAppEnableManifestId' is enabled
  """
  def get_app_id() do
    {"Page.getAppId", %{}}
  end

  @doc """
  ## Parameters:
    - `frameId:FrameId`: description not provided :(
  """
  def get_ad_script_id(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Page.getAdScriptId", params}
  end

  @doc """
  Returns all browser cookies for the page and all of its subframes. Depending
  on the backend support, will return detailed cookie information in the
  `cookies` field.
  """
  def get_cookies() do
    {"Page.getCookies", %{}}
  end

  @doc """
  Returns present frame tree structure.
  """
  def get_frame_tree() do
    {"Page.getFrameTree", %{}}
  end

  @doc """
  Returns metrics relating to the layouting of the page, such as viewport bounds/scale.
  """
  def get_layout_metrics() do
    {"Page.getLayoutMetrics", %{}}
  end

  @doc """
  Returns navigation history for the current page.
  """
  def get_navigation_history() do
    {"Page.getNavigationHistory", %{}}
  end

  @doc """
  Resets navigation history for the current page.
  """
  def reset_navigation_history() do
    {"Page.resetNavigationHistory", %{}}
  end

  @doc """
  Returns content of the given resource.
  ## Parameters:
    - `frameId:FrameId`: Frame id to get resource for.
    - `url:string`: URL of the resource to get content for.
  """
  def get_resource_content(frame_id, url) do
    params = as_query([{"frameId", frame_id}, {"url", url}])
    {"Page.getResourceContent", params}
  end

  @doc """
  Returns present frame / resource tree structure.
  """
  def get_resource_tree() do
    {"Page.getResourceTree", %{}}
  end

  @doc """
  Accepts or dismisses a JavaScript initiated dialog (alert, confirm, prompt, or onbeforeunload).
  ## Parameters:
    - `accept:boolean`: Whether to accept or dismiss the dialog.
    - `promptText:string`: (Optional) The text to enter into the dialog prompt before accepting. Used only if this is a prompt
  dialog.
  """
  def handle_java_script_dialog(accept, prompt_text \\ nil) do
    params = as_query([{"accept", accept}, {"promptText", prompt_text}])
    {"Page.handleJavaScriptDialog", params}
  end

  @doc """
  Navigates current page to the given URL.
  ## Parameters:
    - `url:string`: URL to navigate the page to.
    - `referrer:string`: (Optional) Referrer URL.
    - `transitionType:TransitionType`: (Optional) Intended transition type.
    - `frameId:FrameId`: (Optional) Frame id to navigate, if not specified navigates the top frame.
    - `referrerPolicy:ReferrerPolicy`: (Optional) Referrer-policy used for the navigation.
  """
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
    - `entryId:integer`: Unique id of the entry to navigate to.
  """
  def navigate_to_history_entry(entry_id) do
    params = as_query([{"entryId", entry_id}])
    {"Page.navigateToHistoryEntry", params}
  end

  @doc """
  Print page as PDF.
  ## Parameters:
    - `landscape:boolean`: (Optional) Paper orientation. Defaults to false.
    - `displayHeaderFooter:boolean`: (Optional) Display header and footer. Defaults to false.
    - `printBackground:boolean`: (Optional) Print background graphics. Defaults to false.
    - `scale:number`: (Optional) Scale of the webpage rendering. Defaults to 1.
    - `paperWidth:number`: (Optional) Paper width in inches. Defaults to 8.5 inches.
    - `paperHeight:number`: (Optional) Paper height in inches. Defaults to 11 inches.
    - `marginTop:number`: (Optional) Top margin in inches. Defaults to 1cm (~0.4 inches).
    - `marginBottom:number`: (Optional) Bottom margin in inches. Defaults to 1cm (~0.4 inches).
    - `marginLeft:number`: (Optional) Left margin in inches. Defaults to 1cm (~0.4 inches).
    - `marginRight:number`: (Optional) Right margin in inches. Defaults to 1cm (~0.4 inches).
    - `pageRanges:string`: (Optional) Paper ranges to print, one based, e.g., '1-5, 8, 11-13'. Pages are
  printed in the document order, not in the order specified, and no
  more than once.
  Defaults to empty string, which implies the entire document is printed.
  The page numbers are quietly capped to actual page count of the
  document, and ranges beyond the end of the document are ignored.
  If this results in no pages to print, an error is reported.
  It is an error to specify a range with start greater than end.
    - `headerTemplate:string`: (Optional) HTML template for the print header. Should be valid HTML markup with following
  classes used to inject printing values into them:
  - `date`: formatted print date
  - `title`: document title
  - `url`: document location
  - `pageNumber`: current page number
  - `totalPages`: total pages in the document
  For example, `<span class=title></span>` would generate span containing the title.
    - `footerTemplate:string`: (Optional) HTML template for the print footer. Should use the same format as the `headerTemplate`.
    - `preferCSSPageSize:boolean`: (Optional) Whether or not to prefer page size as defined by css. Defaults to false,
  in which case the content will be scaled to fit the paper size.
    - `transferMode:string`: (Optional) return as stream
  """
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
    - `ignoreCache:boolean`: (Optional) If true, browser cache is ignored (as if the user pressed Shift+refresh).
    - `scriptToEvaluateOnLoad:string`: (Optional) If set, the script will be injected into all frames of the inspected page after reload.
  Argument will be ignored if reloading dataURL origin.
  """
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
    - `identifier:ScriptIdentifier`: description not provided :(
  """
  def remove_script_to_evaluate_on_load(identifier) do
    params = as_query([{"identifier", identifier}])
    {"Page.removeScriptToEvaluateOnLoad", params}
  end

  @doc """
  Removes given script from the list.
  ## Parameters:
    - `identifier:ScriptIdentifier`: description not provided :(
  """
  def remove_script_to_evaluate_on_new_document(identifier) do
    params = as_query([{"identifier", identifier}])
    {"Page.removeScriptToEvaluateOnNewDocument", params}
  end

  @doc """
  Acknowledges that a screencast frame has been received by the frontend.
  ## Parameters:
    - `sessionId:integer`: Frame number.
  """
  def screencast_frame_ack(session_id) do
    params = as_query([{"sessionId", session_id}])
    {"Page.screencastFrameAck", params}
  end

  @doc """
  Searches for given string in resource content.
  ## Parameters:
    - `frameId:FrameId`: Frame id for resource to search in.
    - `url:string`: URL of the resource to search in.
    - `query:string`: String to search for.
    - `caseSensitive:boolean`: (Optional) If true, search is case sensitive.
    - `isRegex:boolean`: (Optional) If true, treats string parameter as regex.
  """
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
    - `enabled:boolean`: Whether to block ads.
  """
  def set_ad_blocking_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setAdBlockingEnabled", params}
  end

  @doc """
  Enable page Content Security Policy by-passing.
  ## Parameters:
    - `enabled:boolean`: Whether to bypass page CSP.
  """
  def set_bypass_csp(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setBypassCSP", params}
  end

  @doc """
  Get Permissions Policy state on given frame.
  ## Parameters:
    - `frameId:FrameId`: description not provided :(
  """
  def get_permissions_policy_state(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Page.getPermissionsPolicyState", params}
  end

  @doc """
  Get Origin Trials on given frame.
  ## Parameters:
    - `frameId:FrameId`: description not provided :(
  """
  def get_origin_trials(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"Page.getOriginTrials", params}
  end

  @doc """
  Overrides the values of device screen dimensions (window.screen.width, window.screen.height,
  window.innerWidth, window.innerHeight, and "device-width"/"device-height"-related CSS media
  query results).
  ## Parameters:
    - `width:integer`: Overriding width value in pixels (minimum 0, maximum 10000000). 0 disables the override.
    - `height:integer`: Overriding height value in pixels (minimum 0, maximum 10000000). 0 disables the override.
    - `deviceScaleFactor:number`: Overriding device scale factor value. 0 disables the override.
    - `mobile:boolean`: Whether to emulate mobile device. This includes viewport meta tag, overlay scrollbars, text
  autosizing and more.
    - `scale:number`: (Optional) Scale to apply to resulting view image.
    - `screenWidth:integer`: (Optional) Overriding screen width value in pixels (minimum 0, maximum 10000000).
    - `screenHeight:integer`: (Optional) Overriding screen height value in pixels (minimum 0, maximum 10000000).
    - `positionX:integer`: (Optional) Overriding view X position on screen in pixels (minimum 0, maximum 10000000).
    - `positionY:integer`: (Optional) Overriding view Y position on screen in pixels (minimum 0, maximum 10000000).
    - `dontSetVisibleSize:boolean`: (Optional) Do not set visible view size, rely upon explicit setVisibleSize call.
    - `screenOrientation:Emulation.ScreenOrientation`: (Optional) Screen orientation override.
    - `viewport:Viewport`: (Optional) The viewport dimensions and scale. If not set, the override is cleared.
  """
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
    - `alpha:number`: Mock alpha
    - `beta:number`: Mock beta
    - `gamma:number`: Mock gamma
  """
  def set_device_orientation_override(alpha, beta, gamma) do
    params = as_query([{"alpha", alpha}, {"beta", beta}, {"gamma", gamma}])
    {"Page.setDeviceOrientationOverride", params}
  end

  @doc """
  Set generic font families.
  ## Parameters:
    - `fontFamilies:FontFamilies`: Specifies font families to set. If a font family is not specified, it won't be changed.
    - `forScripts:array`: (Optional) Specifies font families to set for individual scripts.
  """
  def set_font_families(font_families, for_scripts \\ nil) do
    params = as_query([{"fontFamilies", font_families}, {"forScripts", for_scripts}])
    {"Page.setFontFamilies", params}
  end

  @doc """
  Set default font sizes.
  ## Parameters:
    - `fontSizes:FontSizes`: Specifies font sizes to set. If a font size is not specified, it won't be changed.
  """
  def set_font_sizes(font_sizes) do
    params = as_query([{"fontSizes", font_sizes}])
    {"Page.setFontSizes", params}
  end

  @doc """
  Sets given markup as the document's HTML.
  ## Parameters:
    - `frameId:FrameId`: Frame id to set HTML for.
    - `html:string`: HTML content to set.
  """
  def set_document_content(frame_id, html) do
    params = as_query([{"frameId", frame_id}, {"html", html}])
    {"Page.setDocumentContent", params}
  end

  @doc """
  Set the behavior when downloading a file.
  ## Parameters:
    - `behavior:string`: Whether to allow all or deny all download requests, or use default Chrome behavior if
  available (otherwise deny).
    - `downloadPath:string`: (Optional) The default path to save downloaded files to. This is required if behavior is set to 'allow'
  """
  def set_download_behavior(behavior, download_path \\ nil) do
    params = as_query([{"behavior", behavior}, {"downloadPath", download_path}])
    {"Page.setDownloadBehavior", params}
  end

  @doc """
  Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  unavailable.
  ## Parameters:
    - `latitude:number`: (Optional) Mock latitude
    - `longitude:number`: (Optional) Mock longitude
    - `accuracy:number`: (Optional) Mock accuracy
  """
  def set_geolocation_override(latitude \\ nil, longitude \\ nil, accuracy \\ nil) do
    params = as_query([{"latitude", latitude}, {"longitude", longitude}, {"accuracy", accuracy}])
    {"Page.setGeolocationOverride", params}
  end

  @doc """
  Controls whether page will emit lifecycle events.
  ## Parameters:
    - `enabled:boolean`: If true, starts emitting lifecycle events.
  """
  def set_lifecycle_events_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Page.setLifecycleEventsEnabled", params}
  end

  @doc """
  Toggles mouse event-based touch event emulation.
  ## Parameters:
    - `enabled:boolean`: Whether the touch event emulation should be enabled.
    - `configuration:string`: (Optional) Touch/gesture events configuration. Default: current platform.
  """
  def set_touch_emulation_enabled(enabled, configuration \\ nil) do
    params = as_query([{"enabled", enabled}, {"configuration", configuration}])
    {"Page.setTouchEmulationEnabled", params}
  end

  @doc """
  Starts sending each frame using the `screencastFrame` event.
  ## Parameters:
    - `format:string`: (Optional) Image compression format.
    - `quality:integer`: (Optional) Compression quality from range [0..100].
    - `maxWidth:integer`: (Optional) Maximum screenshot width.
    - `maxHeight:integer`: (Optional) Maximum screenshot height.
    - `everyNthFrame:integer`: (Optional) Send every n-th frame.
  """
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
  def stop_loading() do
    {"Page.stopLoading", %{}}
  end

  @doc """
  Crashes renderer on the IO thread, generates minidumps.
  """
  def crash() do
    {"Page.crash", %{}}
  end

  @doc """
  Tries to close page, running its beforeunload hooks, if any.
  """
  def close() do
    {"Page.close", %{}}
  end

  @doc """
  Tries to update the web lifecycle state of the page.
  It will transition the page to the given state according to:
  https://github.com/WICG/web-lifecycle/
  ## Parameters:
    - `state:string`: Target lifecycle state
  """
  def set_web_lifecycle_state(state) do
    params = as_query([{"state", state}])
    {"Page.setWebLifecycleState", params}
  end

  @doc """
  Stops sending each frame in the `screencastFrame`.
  """
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
    - `scripts:array`: description not provided :(
  """
  def produce_compilation_cache(scripts) do
    params = as_query([{"scripts", scripts}])
    {"Page.produceCompilationCache", params}
  end

  @doc """
  Seeds compilation cache for given url. Compilation cache does not survive
  cross-process navigation.
  ## Parameters:
    - `url:string`: description not provided :(
    - `data:string`: Base64-encoded data (Encoded as a base64 string when passed over JSON)
  """
  def add_compilation_cache(url, data) do
    params = as_query([{"url", url}, {"data", data}])
    {"Page.addCompilationCache", params}
  end

  @doc """
  Clears seeded compilation cache.
  """
  def clear_compilation_cache() do
    {"Page.clearCompilationCache", %{}}
  end

  @doc """
  Sets the Secure Payment Confirmation transaction mode.
  https://w3c.github.io/secure-payment-confirmation/#sctn-automation-set-spc-transaction-mode
  ## Parameters:
    - `mode:AutoResponseMode`: description not provided :(
  """
  def set_spc_transaction_mode(mode) do
    params = as_query([{"mode", mode}])
    {"Page.setSPCTransactionMode", params}
  end

  @doc """
  Extensions for Custom Handlers API:
  https://html.spec.whatwg.org/multipage/system-state.html#rph-automation
  ## Parameters:
    - `mode:AutoResponseMode`: description not provided :(
  """
  def set_rph_registration_mode(mode) do
    params = as_query([{"mode", mode}])
    {"Page.setRPHRegistrationMode", params}
  end

  @doc """
  Generates a report for testing.
  ## Parameters:
    - `message:string`: Message to be displayed in the report.
    - `group:string`: (Optional) Specifies the endpoint group to deliver the report to.
  """
  def generate_test_report(message, group \\ nil) do
    params = as_query([{"message", message}, {"group", group}])
    {"Page.generateTestReport", params}
  end

  @doc """
  Pauses page execution. Can be resumed using generic Runtime.runIfWaitingForDebugger.
  """
  def wait_for_debugger() do
    {"Page.waitForDebugger", %{}}
  end

  @doc """
  Intercept file chooser requests and transfer control to protocol clients.
  When file chooser interception is enabled, native file chooser dialog is not shown.
  Instead, a protocol event `Page.fileChooserOpened` is emitted.
  ## Parameters:
    - `enabled:boolean`: description not provided :(
  """
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
    - `isAllowed:boolean`: description not provided :(
  """
  def set_prerendering_allowed(is_allowed) do
    params = as_query([{"isAllowed", is_allowed}])
    {"Page.setPrerenderingAllowed", params}
  end
end
