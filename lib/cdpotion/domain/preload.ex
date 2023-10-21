defmodule CDPotion.Domain.Preload do
  use CDPotion.Utils
  @typedoc "TODO(https://crbug.com/1384419): revisit the list of PrefetchStatus and
filter out the ones that aren't necessary to the developers."
  @type prefetch_status ::
          :PrefetchAllowed
          | :PrefetchFailedIneligibleRedirect
          | :PrefetchFailedInvalidRedirect
          | :PrefetchFailedMIMENotSupported
          | :PrefetchFailedNetError
          | :PrefetchFailedNon2XX
          | :PrefetchFailedPerPageLimitExceeded
          | :PrefetchEvicted
          | :PrefetchHeldback
          | :PrefetchIneligibleRetryAfter
          | :PrefetchIsPrivacyDecoy
          | :PrefetchIsStale
          | :PrefetchNotEligibleBrowserContextOffTheRecord
          | :PrefetchNotEligibleDataSaverEnabled
          | :PrefetchNotEligibleExistingProxy
          | :PrefetchNotEligibleHostIsNonUnique
          | :PrefetchNotEligibleNonDefaultStoragePartition
          | :PrefetchNotEligibleSameSiteCrossOriginPrefetchRequiredProxy
          | :PrefetchNotEligibleSchemeIsNotHttps
          | :PrefetchNotEligibleUserHasCookies
          | :PrefetchNotEligibleUserHasServiceWorker
          | :PrefetchNotEligibleBatterySaverEnabled
          | :PrefetchNotEligiblePreloadingDisabled
          | :PrefetchNotFinishedInTime
          | :PrefetchNotStarted
          | :PrefetchNotUsedCookiesChanged
          | :PrefetchProxyNotAvailable
          | :PrefetchResponseUsed
          | :PrefetchSuccessfulButNotUsed
          | :PrefetchNotUsedProbeFailed

  @typedoc "A key that identifies a preloading attempt.

The url used is the url specified by the trigger (i.e. the initial URL), and
not the final url that is navigated to. For example, prerendering allows
same-origin main frame navigations during the attempt, but the attempt is
still keyed with the initial URL."
  @type preloading_attempt_key :: %{
          action: CDPotion.Domain.Preload.speculation_action(),
          loaderId: CDPotion.Domain.Network.loader_id(),
          targetHint: CDPotion.Domain.Preload.speculation_target_hint() | nil,
          url: String.t()
        }

  @typedoc "Lists sources for a preloading attempt, specifically the ids of rule sets
that had a speculation rule that triggered the attempt, and the
BackendNodeIds of <a href> or <area href> elements that triggered the
attempt (in the case of attempts triggered by a document rule). It is
possible for mulitple rule sets and links to trigger a single attempt."
  @type preloading_attempt_source :: %{
          key: CDPotion.Domain.Preload.preloading_attempt_key(),
          nodeIds: list(CDPotion.Domain.DOM.backend_node_id()),
          ruleSetIds: list(CDPotion.Domain.Preload.rule_set_id())
        }

  @typedoc "Preloading status values, see also PreloadingTriggeringOutcome. This
status is shared by prefetchStatusUpdated and prerenderStatusUpdated."
  @type preloading_status :: :Pending | :Running | :Ready | :Success | :Failure | :NotSupported

  @typedoc "List of FinalStatus reasons for Prerender2."
  @type prerender_final_status ::
          :Activated
          | :Destroyed
          | :LowEndDevice
          | :InvalidSchemeRedirect
          | :InvalidSchemeNavigation
          | :InProgressNavigation
          | :NavigationRequestBlockedByCsp
          | :MainFrameNavigation
          | :MojoBinderPolicy
          | :RendererProcessCrashed
          | :RendererProcessKilled
          | :Download
          | :TriggerDestroyed
          | :NavigationNotCommitted
          | :NavigationBadHttpStatus
          | :ClientCertRequested
          | :NavigationRequestNetworkError
          | :MaxNumOfRunningPrerendersExceeded
          | :CancelAllHostsForTesting
          | :DidFailLoad
          | :Stop
          | :SslCertificateError
          | :LoginAuthRequested
          | :UaChangeRequiresReload
          | :BlockedByClient
          | :AudioOutputDeviceRequested
          | :MixedContent
          | :TriggerBackgrounded
          | :MemoryLimitExceeded
          | :FailToGetMemoryUsage
          | :DataSaverEnabled
          | :HasEffectiveUrl
          | :ActivatedBeforeStarted
          | :InactivePageRestriction
          | :StartFailed
          | :TimeoutBackgrounded
          | :CrossSiteRedirectInInitialNavigation
          | :CrossSiteNavigationInInitialNavigation
          | :SameSiteCrossOriginRedirectNotOptInInInitialNavigation
          | :SameSiteCrossOriginNavigationNotOptInInInitialNavigation
          | :ActivationNavigationParameterMismatch
          | :ActivatedInBackground
          | :EmbedderHostDisallowed
          | :ActivationNavigationDestroyedBeforeSuccess
          | :TabClosedByUserGesture
          | :TabClosedWithoutUserGesture
          | :PrimaryMainFrameRendererProcessCrashed
          | :PrimaryMainFrameRendererProcessKilled
          | :ActivationFramePolicyNotCompatible
          | :PreloadingDisabled
          | :BatterySaverEnabled
          | :ActivatedDuringMainFrameNavigation
          | :PreloadingUnsupportedByWebContents
          | :CrossSiteRedirectInMainFrameNavigation
          | :CrossSiteNavigationInMainFrameNavigation
          | :SameSiteCrossOriginRedirectNotOptInInMainFrameNavigation
          | :SameSiteCrossOriginNavigationNotOptInInMainFrameNavigation
          | :MemoryPressureOnTrigger
          | :MemoryPressureAfterTriggered
          | :PrerenderingDisabledByDevTools
          | :ResourceLoadBlockedByClient
          | :SpeculationRuleRemoved
          | :ActivatedWithAuxiliaryBrowsingContexts

  @typedoc "Corresponds to SpeculationRuleSet"
  @type rule_set :: %{
          backendNodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          errorMessage: String.t() | nil,
          errorType: CDPotion.Domain.Preload.rule_set_error_type() | nil,
          id: CDPotion.Domain.Preload.rule_set_id(),
          loaderId: CDPotion.Domain.Network.loader_id(),
          requestId: CDPotion.Domain.Network.request_id() | nil,
          sourceText: String.t(),
          url: String.t() | nil
        }

  @typedoc "description not provided :("
  @type rule_set_error_type :: :SourceIsNotJsonObject | :InvalidRulesSkipped

  @typedoc "Unique id"
  @type rule_set_id :: String.t()

  @typedoc "The type of preloading attempted. It corresponds to
mojom::SpeculationAction (although PrefetchWithSubresources is omitted as it
isn't being used by clients)."
  @type speculation_action :: :Prefetch | :Prerender

  @typedoc "Corresponds to mojom::SpeculationTargetHint.
See https://github.com/WICG/nav-speculation/blob/main/triggers.md#window-name-targeting-hints"
  @type speculation_target_hint :: :Blank | :Self

  @doc """
  """
  def enable() do
    {"Preload.enable", %{}}
  end

  @doc """
  """
  def disable() do
    {"Preload.disable", %{}}
  end
end
