defmodule CDPotion.Domain.Audits do
  use CDPotion.Utils
  @doc "Information about a cookie that is affected by an inspector issue."
  @type AffectedCookie :: %{
          domain: String.t(),
          name: String.t(),
          path: String.t()
        }

  @doc "Information about the frame affected by an inspector issue."
  @type AffectedFrame :: %{
          frameId: Page.FrameId
        }

  @doc "Information about a request that is affected by an inspector issue."
  @type AffectedRequest :: %{
          requestId: Network.RequestId,
          url: String.t() | nil
        }

  @doc "Details for issues around 'Attribution Reporting API' usage.
Explainer: https://github.com/WICG/attribution-reporting-api"
  @type AttributionReportingIssueDetails :: %{
          invalidParameter: String.t() | nil,
          request: Audits.AffectedRequest | nil,
          violatingNodeId: DOM.BackendNodeId | nil,
          violationType: Audits.AttributionReportingIssueType
        }

  @doc "description not provided :("
  @type AttributionReportingIssueType ::
          :PermissionPolicyDisabled
          | :UntrustworthyReportingOrigin
          | :InsecureContext
          | :InvalidHeader
          | :InvalidRegisterTriggerHeader
          | :SourceAndTriggerHeaders
          | :SourceIgnored
          | :TriggerIgnored
          | :OsSourceIgnored
          | :OsTriggerIgnored
          | :InvalidRegisterOsSourceHeader
          | :InvalidRegisterOsTriggerHeader
          | :WebAndOsHeaders
          | :NoWebOrOsSupport
          | :NavigationRegistrationWithoutTransientUserActivation

  @doc "Details for a request that has been blocked with the BLOCKED_BY_RESPONSE
code. Currently only used for COEP/COOP, but may be extended to include
some CSP errors in the future."
  @type BlockedByResponseIssueDetails :: %{
          blockedFrame: Audits.AffectedFrame | nil,
          parentFrame: Audits.AffectedFrame | nil,
          reason: Audits.BlockedByResponseReason,
          request: Audits.AffectedRequest
        }

  @doc "Enum indicating the reason a response has been blocked. These reasons are
refinements of the net error BLOCKED_BY_RESPONSE."
  @type BlockedByResponseReason ::
          :CoepFrameResourceNeedsCoepHeader
          | :CoopSandboxedIFrameCannotNavigateToCoopPage
          | :CorpNotSameOrigin
          | :CorpNotSameOriginAfterDefaultedToSameOriginByCoep
          | :CorpNotSameSite

  @doc "This issue warns about sites in the redirect chain of a finished navigation
that may be flagged as trackers and have their state cleared if they don't
receive a user interaction. Note that in this context 'site' means eTLD+1.
For example, if the URL `https://example.test:80/bounce` was in the
redirect chain, the site reported would be `example.test`."
  @type BounceTrackingIssueDetails :: %{
          trackingSites: list(String.t())
        }

  @doc "This issue tracks client hints related issues. It's used to deprecate old
features, encourage the use of new ones, and provide general guidance."
  @type ClientHintIssueDetails :: %{
          clientHintIssueReason: Audits.ClientHintIssueReason,
          sourceCodeLocation: Audits.SourceCodeLocation
        }

  @doc "description not provided :("
  @type ClientHintIssueReason :: :MetaTagAllowListInvalidOrigin | :MetaTagModifiedHTML

  @doc "description not provided :("
  @type ContentSecurityPolicyIssueDetails :: %{
          blockedURL: String.t() | nil,
          contentSecurityPolicyViolationType: Audits.ContentSecurityPolicyViolationType,
          frameAncestor: Audits.AffectedFrame | nil,
          isReportOnly: boolean(),
          sourceCodeLocation: Audits.SourceCodeLocation | nil,
          violatedDirective: String.t(),
          violatingNodeId: DOM.BackendNodeId | nil
        }

  @doc "description not provided :("
  @type ContentSecurityPolicyViolationType ::
          :kInlineViolation
          | :kEvalViolation
          | :kURLViolation
          | :kTrustedTypesSinkViolation
          | :kTrustedTypesPolicyViolation
          | :kWasmEvalViolation

  @doc "description not provided :("
  @type CookieExclusionReason ::
          :ExcludeSameSiteUnspecifiedTreatedAsLax
          | :ExcludeSameSiteNoneInsecure
          | :ExcludeSameSiteLax
          | :ExcludeSameSiteStrict
          | :ExcludeInvalidSameParty
          | :ExcludeSamePartyCrossPartyContext
          | :ExcludeDomainNonASCII
          | :ExcludeThirdPartyCookieBlockedInFirstPartySet

  @doc "This information is currently necessary, as the front-end has a difficult
time finding a specific cookie. With this, we can convey specific error
information without the cookie."
  @type CookieIssueDetails :: %{
          cookie: Audits.AffectedCookie | nil,
          cookieExclusionReasons: list(Audits.CookieExclusionReason),
          cookieUrl: String.t() | nil,
          cookieWarningReasons: list(Audits.CookieWarningReason),
          operation: Audits.CookieOperation,
          rawCookieLine: String.t() | nil,
          request: Audits.AffectedRequest | nil,
          siteForCookies: String.t() | nil
        }

  @doc "description not provided :("
  @type CookieOperation :: :SetCookie | :ReadCookie

  @doc "description not provided :("
  @type CookieWarningReason ::
          :WarnSameSiteUnspecifiedCrossSiteContext
          | :WarnSameSiteNoneInsecure
          | :WarnSameSiteUnspecifiedLaxAllowUnsafe
          | :WarnSameSiteStrictLaxDowngradeStrict
          | :WarnSameSiteStrictCrossDowngradeStrict
          | :WarnSameSiteStrictCrossDowngradeLax
          | :WarnSameSiteLaxCrossDowngradeStrict
          | :WarnSameSiteLaxCrossDowngradeLax
          | :WarnAttributeValueExceedsMaxSize
          | :WarnDomainNonASCII
          | :WarnThirdPartyPhaseout

  @doc "Details for a CORS related issue, e.g. a warning or error related to
CORS RFC1918 enforcement."
  @type CorsIssueDetails :: %{
          clientSecurityState: Network.ClientSecurityState | nil,
          corsErrorStatus: Network.CorsErrorStatus,
          initiatorOrigin: String.t() | nil,
          isWarning: boolean(),
          location: Audits.SourceCodeLocation | nil,
          request: Audits.AffectedRequest,
          resourceIPAddressSpace: Network.IPAddressSpace | nil
        }

  @doc "This issue tracks information needed to print a deprecation message.
https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/core/frame/third_party/blink/renderer/core/frame/deprecation/README.md"
  @type DeprecationIssueDetails :: %{
          affectedFrame: Audits.AffectedFrame | nil,
          sourceCodeLocation: Audits.SourceCodeLocation,
          type: String.t()
        }

  @doc "description not provided :("
  @type FailedRequestInfo :: %{
          failureMessage: String.t(),
          requestId: Network.RequestId | nil,
          url: String.t()
        }

  @doc "description not provided :("
  @type FederatedAuthRequestIssueDetails :: %{
          federatedAuthRequestIssueReason: Audits.FederatedAuthRequestIssueReason
        }

  @doc "Represents the failure reason when a federated authentication reason fails.
Should be updated alongside RequestIdTokenStatus in
third_party/blink/public/mojom/devtools/inspector_issue.mojom to include
all cases except for success."
  @type FederatedAuthRequestIssueReason ::
          :ShouldEmbargo
          | :TooManyRequests
          | :WellKnownHttpNotFound
          | :WellKnownNoResponse
          | :WellKnownInvalidResponse
          | :WellKnownListEmpty
          | :WellKnownInvalidContentType
          | :ConfigNotInWellKnown
          | :WellKnownTooBig
          | :ConfigHttpNotFound
          | :ConfigNoResponse
          | :ConfigInvalidResponse
          | :ConfigInvalidContentType
          | :ClientMetadataHttpNotFound
          | :ClientMetadataNoResponse
          | :ClientMetadataInvalidResponse
          | :ClientMetadataInvalidContentType
          | :DisabledInSettings
          | :ErrorFetchingSignin
          | :InvalidSigninResponse
          | :AccountsHttpNotFound
          | :AccountsNoResponse
          | :AccountsInvalidResponse
          | :AccountsListEmpty
          | :AccountsInvalidContentType
          | :IdTokenHttpNotFound
          | :IdTokenNoResponse
          | :IdTokenInvalidResponse
          | :IdTokenInvalidRequest
          | :IdTokenInvalidContentType
          | :ErrorIdToken
          | :Canceled
          | :RpPageNotVisible
          | :SilentMediationFailure
          | :ThirdPartyCookiesBlocked

  @doc "description not provided :("
  @type FederatedAuthUserInfoRequestIssueDetails :: %{
          federatedAuthUserInfoRequestIssueReason: Audits.FederatedAuthUserInfoRequestIssueReason
        }

  @doc "Represents the failure reason when a getUserInfo() call fails.
Should be updated alongside FederatedAuthUserInfoRequestResult in
third_party/blink/public/mojom/devtools/inspector_issue.mojom."
  @type FederatedAuthUserInfoRequestIssueReason ::
          :NotSameOrigin
          | :NotIframe
          | :NotPotentiallyTrustworthy
          | :NoApiPermission
          | :NotSignedInWithIdp
          | :NoAccountSharingPermission
          | :InvalidConfigOrWellKnown
          | :InvalidAccountsResponse
          | :NoReturningUserFromFetchedAccounts

  @doc "Depending on the concrete errorType, different properties are set."
  @type GenericIssueDetails :: %{
          errorType: Audits.GenericIssueErrorType,
          frameId: Page.FrameId | nil,
          request: Audits.AffectedRequest | nil,
          violatingNodeAttribute: String.t() | nil,
          violatingNodeId: DOM.BackendNodeId | nil
        }

  @doc "description not provided :("
  @type GenericIssueErrorType ::
          :CrossOriginPortalPostMessageError
          | :FormLabelForNameError
          | :FormDuplicateIdForInputError
          | :FormInputWithNoLabelError
          | :FormAutocompleteAttributeEmptyError
          | :FormEmptyIdAndNameAttributesForInputError
          | :FormAriaLabelledByToNonExistingId
          | :FormInputAssignedAutocompleteValueToIdOrNameAttributeError
          | :FormLabelHasNeitherForNorNestedInput
          | :FormLabelForMatchesNonExistingIdError
          | :FormInputHasWrongButWellIntendedAutocompleteValueError
          | :ResponseWasBlockedByORB

  @doc "description not provided :("
  @type HeavyAdIssueDetails :: %{
          frame: Audits.AffectedFrame,
          reason: Audits.HeavyAdReason,
          resolution: Audits.HeavyAdResolutionStatus
        }

  @doc "description not provided :("
  @type HeavyAdReason :: :NetworkTotalLimit | :CpuTotalLimit | :CpuPeakLimit

  @doc "description not provided :("
  @type HeavyAdResolutionStatus :: :HeavyAdBlocked | :HeavyAdWarning

  @doc "An inspector issue reported from the back-end."
  @type InspectorIssue :: %{
          code: Audits.InspectorIssueCode,
          details: Audits.InspectorIssueDetails,
          issueId: Audits.IssueId | nil
        }

  @doc "A unique identifier for the type of issue. Each type may use one of the
optional fields in InspectorIssueDetails to convey more specific
information about the kind of issue."
  @type InspectorIssueCode ::
          :CookieIssue
          | :MixedContentIssue
          | :BlockedByResponseIssue
          | :HeavyAdIssue
          | :ContentSecurityPolicyIssue
          | :SharedArrayBufferIssue
          | :LowTextContrastIssue
          | :CorsIssue
          | :AttributionReportingIssue
          | :QuirksModeIssue
          | :NavigatorUserAgentIssue
          | :GenericIssue
          | :DeprecationIssue
          | :ClientHintIssue
          | :FederatedAuthRequestIssue
          | :BounceTrackingIssue
          | :StylesheetLoadingIssue
          | :FederatedAuthUserInfoRequestIssue

  @doc "This struct holds a list of optional fields with additional information
specific to the kind of issue. When adding a new issue code, please also
add a new optional field to this type."
  @type InspectorIssueDetails :: %{
          attributionReportingIssueDetails: Audits.AttributionReportingIssueDetails | nil,
          blockedByResponseIssueDetails: Audits.BlockedByResponseIssueDetails | nil,
          bounceTrackingIssueDetails: Audits.BounceTrackingIssueDetails | nil,
          clientHintIssueDetails: Audits.ClientHintIssueDetails | nil,
          contentSecurityPolicyIssueDetails: Audits.ContentSecurityPolicyIssueDetails | nil,
          cookieIssueDetails: Audits.CookieIssueDetails | nil,
          corsIssueDetails: Audits.CorsIssueDetails | nil,
          deprecationIssueDetails: Audits.DeprecationIssueDetails | nil,
          federatedAuthRequestIssueDetails: Audits.FederatedAuthRequestIssueDetails | nil,
          federatedAuthUserInfoRequestIssueDetails:
            Audits.FederatedAuthUserInfoRequestIssueDetails | nil,
          genericIssueDetails: Audits.GenericIssueDetails | nil,
          heavyAdIssueDetails: Audits.HeavyAdIssueDetails | nil,
          lowTextContrastIssueDetails: Audits.LowTextContrastIssueDetails | nil,
          mixedContentIssueDetails: Audits.MixedContentIssueDetails | nil,
          navigatorUserAgentIssueDetails: Audits.NavigatorUserAgentIssueDetails | nil,
          quirksModeIssueDetails: Audits.QuirksModeIssueDetails | nil,
          sharedArrayBufferIssueDetails: Audits.SharedArrayBufferIssueDetails | nil,
          stylesheetLoadingIssueDetails: Audits.StylesheetLoadingIssueDetails | nil
        }

  @doc "A unique id for a DevTools inspector issue. Allows other entities (e.g.
exceptions, CDP message, console messages, etc.) to reference an issue."
  @type IssueId :: String.t()

  @doc "description not provided :("
  @type LowTextContrastIssueDetails :: %{
          contrastRatio: number(),
          fontSize: String.t(),
          fontWeight: String.t(),
          thresholdAA: number(),
          thresholdAAA: number(),
          violatingNodeId: DOM.BackendNodeId,
          violatingNodeSelector: String.t()
        }

  @doc "description not provided :("
  @type MixedContentIssueDetails :: %{
          frame: Audits.AffectedFrame | nil,
          insecureURL: String.t(),
          mainResourceURL: String.t(),
          request: Audits.AffectedRequest | nil,
          resolutionStatus: Audits.MixedContentResolutionStatus,
          resourceType: Audits.MixedContentResourceType | nil
        }

  @doc "description not provided :("
  @type MixedContentResolutionStatus ::
          :MixedContentBlocked | :MixedContentAutomaticallyUpgraded | :MixedContentWarning

  @doc "description not provided :("
  @type MixedContentResourceType ::
          :AttributionSrc
          | :Audio
          | :Beacon
          | :CSPReport
          | :Download
          | :EventSource
          | :Favicon
          | :Font
          | :Form
          | :Frame
          | :Image
          | :Import
          | :Manifest
          | :Ping
          | :PluginData
          | :PluginResource
          | :Prefetch
          | :Resource
          | :Script
          | :ServiceWorker
          | :SharedWorker
          | :Stylesheet
          | :Track
          | :Video
          | :Worker
          | :XMLHttpRequest
          | :XSLT

  @doc "description not provided :("
  @type NavigatorUserAgentIssueDetails :: %{
          location: Audits.SourceCodeLocation | nil,
          url: String.t()
        }

  @doc "Details for issues about documents in Quirks Mode
or Limited Quirks Mode that affects page layouting."
  @type QuirksModeIssueDetails :: %{
          documentNodeId: DOM.BackendNodeId,
          frameId: Page.FrameId,
          isLimitedQuirksMode: boolean(),
          loaderId: Network.LoaderId,
          url: String.t()
        }

  @doc "Details for a issue arising from an SAB being instantiated in, or
transferred to a context that is not cross-origin isolated."
  @type SharedArrayBufferIssueDetails :: %{
          isWarning: boolean(),
          sourceCodeLocation: Audits.SourceCodeLocation,
          type: Audits.SharedArrayBufferIssueType
        }

  @doc "description not provided :("
  @type SharedArrayBufferIssueType :: :TransferIssue | :CreationIssue

  @doc "description not provided :("
  @type SourceCodeLocation :: %{
          columnNumber: integer(),
          lineNumber: integer(),
          scriptId: Runtime.ScriptId | nil,
          url: String.t()
        }

  @doc "description not provided :("
  @type StyleSheetLoadingIssueReason :: :LateImportRule | :RequestFailed

  @doc "This issue warns when a referenced stylesheet couldn't be loaded."
  @type StylesheetLoadingIssueDetails :: %{
          failedRequestInfo: Audits.FailedRequestInfo | nil,
          sourceCodeLocation: Audits.SourceCodeLocation,
          styleSheetLoadingIssueReason: Audits.StyleSheetLoadingIssueReason
        }

  @doc """
  Returns the response body and size if it were re-encoded with the specified settings. Only
  applies to images.
  ## Parameters:
    - `requestId:Network.RequestId`: Identifier of the network request to get content for.
    - `encoding:string`: The encoding to use.
    - `quality:number`: (Optional) The quality of the encoding (0-1). (defaults to 1)
    - `sizeOnly:boolean`: (Optional) Whether to only return the size information (defaults to false).
  """
  def get_encoded_response(request_id, encoding, quality \\ nil, size_only \\ nil) do
    params =
      as_query([
        {"requestId", request_id},
        {"encoding", encoding},
        {"quality", quality},
        {"sizeOnly", size_only}
      ])

    {"Audits.getEncodedResponse", params}
  end

  @doc """
  Disables issues domain, prevents further issues from being reported to the client.
  """
  def disable() do
    {"Audits.disable", %{}}
  end

  @doc """
  Enables issues domain, sends the issues collected so far to the client by means of the
  `issueAdded` event.
  """
  def enable() do
    {"Audits.enable", %{}}
  end

  @doc """
  Runs the contrast check for the target page. Found issues are reported
  using Audits.issueAdded event.
  ## Parameters:
    - `reportAAA:boolean`: (Optional) Whether to report WCAG AAA level issues. Default is false.
  """
  def check_contrast(report_aaa \\ nil) do
    params = as_query([{"reportAAA", report_aaa}])
    {"Audits.checkContrast", params}
  end

  @doc """
  Runs the form issues check for the target page. Found issues are reported
  using Audits.issueAdded event.
  """
  def check_forms_issues() do
    {"Audits.checkFormsIssues", %{}}
  end
end
