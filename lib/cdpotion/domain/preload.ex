defmodule CDPotion.Domain.Preload do
  use CDPotion.Utils
  @doc "TODO(https://crbug.com/1384419): revisit the list of PrefetchStatus and
filter out the ones that aren't necessary to the developers."
  @type PrefetchStatus ::
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

  @doc "A key that identifies a preloading attempt.

The url used is the url specified by the trigger (i.e. the initial URL), and
not the final url that is navigated to. For example, prerendering allows
same-origin main frame navigations during the attempt, but the attempt is
still keyed with the initial URL."
  @type PreloadingAttemptKey :: %{
          action: Preload.SpeculationAction,
          loaderId: Network.LoaderId,
          targetHint: Preload.SpeculationTargetHint | nil,
          url: String.t()
        }

  @doc "Lists sources for a preloading attempt, specifically the ids of rule sets
that had a speculation rule that triggered the attempt, and the
BackendNodeIds of <a href> or <area href> elements that triggered the
attempt (in the case of attempts triggered by a document rule). It is
possible for mulitple rule sets and links to trigger a single attempt."
  @type PreloadingAttemptSource :: %{
          key: Preload.PreloadingAttemptKey,
          nodeIds: list(DOM.BackendNodeId),
          ruleSetIds: list(Preload.RuleSetId)
        }

  @doc "Preloading status values, see also PreloadingTriggeringOutcome. This
status is shared by prefetchStatusUpdated and prerenderStatusUpdated."
  @type PreloadingStatus :: :Pending | :Running | :Ready | :Success | :Failure | :NotSupported

  @doc "List of FinalStatus reasons for Prerender2."
  @type PrerenderFinalStatus ::
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

  @doc "Corresponds to SpeculationRuleSet"
  @type RuleSet :: %{
          backendNodeId: DOM.BackendNodeId | nil,
          errorMessage: String.t() | nil,
          errorType: Preload.RuleSetErrorType | nil,
          id: Preload.RuleSetId,
          loaderId: Network.LoaderId,
          requestId: Network.RequestId | nil,
          sourceText: String.t(),
          url: String.t() | nil
        }

  @doc "description not provided :("
  @type RuleSetErrorType :: :SourceIsNotJsonObject | :InvalidRulesSkipped

  @doc "Unique id"
  @type RuleSetId :: String.t()

  @doc "The type of preloading attempted. It corresponds to
mojom::SpeculationAction (although PrefetchWithSubresources is omitted as it
isn't being used by clients)."
  @type SpeculationAction :: :Prefetch | :Prerender

  @doc "Corresponds to mojom::SpeculationTargetHint.
See https://github.com/WICG/nav-speculation/blob/main/triggers.md#window-name-targeting-hints"
  @type SpeculationTargetHint :: :Blank | :Self

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
