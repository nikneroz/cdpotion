defmodule CDPotion.Domain.Audits do
  use CDPotion.Utils
  @typedoc "Information about a cookie that is affected by an inspector issue."
  @type affected_cookie :: %{
          domain: String.t(),
          name: String.t(),
          path: String.t()
        }

  @typedoc "Information about the frame affected by an inspector issue."
  @type affected_frame :: %{
          frameId: CDPotion.Domain.Page.frame_id()
        }

  @typedoc "Information about a request that is affected by an inspector issue."
  @type affected_request :: %{
          requestId: CDPotion.Domain.Network.request_id(),
          url: String.t() | nil
        }

  @typedoc "Details for issues around 'Attribution Reporting API' usage.
Explainer: https://github.com/WICG/attribution-reporting-api"
  @type attribution_reporting_issue_details :: %{
          invalidParameter: String.t() | nil,
          request: CDPotion.Domain.Audits.affected_request() | nil,
          violatingNodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          violationType: CDPotion.Domain.Audits.attribution_reporting_issue_type()
        }

  @typedoc "description not provided :("
  @type attribution_reporting_issue_type ::
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

  @typedoc "Details for a request that has been blocked with the BLOCKED_BY_RESPONSE
code. Currently only used for COEP/COOP, but may be extended to include
some CSP errors in the future."
  @type blocked_by_response_issue_details :: %{
          blockedFrame: CDPotion.Domain.Audits.affected_frame() | nil,
          parentFrame: CDPotion.Domain.Audits.affected_frame() | nil,
          reason: CDPotion.Domain.Audits.blocked_by_response_reason(),
          request: CDPotion.Domain.Audits.affected_request()
        }

  @typedoc "Enum indicating the reason a response has been blocked. These reasons are
refinements of the net error BLOCKED_BY_RESPONSE."
  @type blocked_by_response_reason ::
          :CoepFrameResourceNeedsCoepHeader
          | :CoopSandboxedIFrameCannotNavigateToCoopPage
          | :CorpNotSameOrigin
          | :CorpNotSameOriginAfterDefaultedToSameOriginByCoep
          | :CorpNotSameSite

  @typedoc "This issue warns about sites in the redirect chain of a finished navigation
that may be flagged as trackers and have their state cleared if they don't
receive a user interaction. Note that in this context 'site' means eTLD+1.
For example, if the URL `https://example.test:80/bounce` was in the
redirect chain, the site reported would be `example.test`."
  @type bounce_tracking_issue_details :: %{
          trackingSites: list(String.t())
        }

  @typedoc "This issue tracks client hints related issues. It's used to deprecate old
features, encourage the use of new ones, and provide general guidance."
  @type client_hint_issue_details :: %{
          clientHintIssueReason: CDPotion.Domain.Audits.client_hint_issue_reason(),
          sourceCodeLocation: CDPotion.Domain.Audits.source_code_location()
        }

  @typedoc "description not provided :("
  @type client_hint_issue_reason :: :MetaTagAllowListInvalidOrigin | :MetaTagModifiedHTML

  @typedoc "description not provided :("
  @type content_security_policy_issue_details :: %{
          blockedURL: String.t() | nil,
          contentSecurityPolicyViolationType:
            CDPotion.Domain.Audits.content_security_policy_violation_type(),
          frameAncestor: CDPotion.Domain.Audits.affected_frame() | nil,
          isReportOnly: boolean(),
          sourceCodeLocation: CDPotion.Domain.Audits.source_code_location() | nil,
          violatedDirective: String.t(),
          violatingNodeId: CDPotion.Domain.DOM.backend_node_id() | nil
        }

  @typedoc "description not provided :("
  @type content_security_policy_violation_type ::
          :kInlineViolation
          | :kEvalViolation
          | :kURLViolation
          | :kTrustedTypesSinkViolation
          | :kTrustedTypesPolicyViolation
          | :kWasmEvalViolation

  @typedoc "description not provided :("
  @type cookie_exclusion_reason ::
          :ExcludeSameSiteUnspecifiedTreatedAsLax
          | :ExcludeSameSiteNoneInsecure
          | :ExcludeSameSiteLax
          | :ExcludeSameSiteStrict
          | :ExcludeInvalidSameParty
          | :ExcludeSamePartyCrossPartyContext
          | :ExcludeDomainNonASCII
          | :ExcludeThirdPartyCookieBlockedInFirstPartySet

  @typedoc "This information is currently necessary, as the front-end has a difficult
time finding a specific cookie. With this, we can convey specific error
information without the cookie."
  @type cookie_issue_details :: %{
          cookie: CDPotion.Domain.Audits.affected_cookie() | nil,
          cookieExclusionReasons: list(CDPotion.Domain.Audits.cookie_exclusion_reason()),
          cookieUrl: String.t() | nil,
          cookieWarningReasons: list(CDPotion.Domain.Audits.cookie_warning_reason()),
          operation: CDPotion.Domain.Audits.cookie_operation(),
          rawCookieLine: String.t() | nil,
          request: CDPotion.Domain.Audits.affected_request() | nil,
          siteForCookies: String.t() | nil
        }

  @typedoc "description not provided :("
  @type cookie_operation :: :SetCookie | :ReadCookie

  @typedoc "description not provided :("
  @type cookie_warning_reason ::
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

  @typedoc "Details for a CORS related issue, e.g. a warning or error related to
CORS RFC1918 enforcement."
  @type cors_issue_details :: %{
          clientSecurityState: CDPotion.Domain.Network.client_security_state() | nil,
          corsErrorStatus: CDPotion.Domain.Network.cors_error_status(),
          initiatorOrigin: String.t() | nil,
          isWarning: boolean(),
          location: CDPotion.Domain.Audits.source_code_location() | nil,
          request: CDPotion.Domain.Audits.affected_request(),
          resourceIPAddressSpace: CDPotion.Domain.Network.ip_address_space() | nil
        }

  @typedoc "This issue tracks information needed to print a deprecation message.
https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/core/frame/third_party/blink/renderer/core/frame/deprecation/README.md"
  @type deprecation_issue_details :: %{
          affectedFrame: CDPotion.Domain.Audits.affected_frame() | nil,
          sourceCodeLocation: CDPotion.Domain.Audits.source_code_location(),
          type: String.t()
        }

  @typedoc "description not provided :("
  @type failed_request_info :: %{
          failureMessage: String.t(),
          requestId: CDPotion.Domain.Network.request_id() | nil,
          url: String.t()
        }

  @typedoc "description not provided :("
  @type federated_auth_request_issue_details :: %{
          federatedAuthRequestIssueReason:
            CDPotion.Domain.Audits.federated_auth_request_issue_reason()
        }

  @typedoc "Represents the failure reason when a federated authentication reason fails.
Should be updated alongside RequestIdTokenStatus in
third_party/blink/public/mojom/devtools/inspector_issue.mojom to include
all cases except for success."
  @type federated_auth_request_issue_reason ::
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

  @typedoc "description not provided :("
  @type federated_auth_user_info_request_issue_details :: %{
          federatedAuthUserInfoRequestIssueReason:
            CDPotion.Domain.Audits.federated_auth_user_info_request_issue_reason()
        }

  @typedoc "Represents the failure reason when a getUserInfo() call fails.
Should be updated alongside FederatedAuthUserInfoRequestResult in
third_party/blink/public/mojom/devtools/inspector_issue.mojom."
  @type federated_auth_user_info_request_issue_reason ::
          :NotSameOrigin
          | :NotIframe
          | :NotPotentiallyTrustworthy
          | :NoApiPermission
          | :NotSignedInWithIdp
          | :NoAccountSharingPermission
          | :InvalidConfigOrWellKnown
          | :InvalidAccountsResponse
          | :NoReturningUserFromFetchedAccounts

  @typedoc "Depending on the concrete errorType, different properties are set."
  @type generic_issue_details :: %{
          errorType: CDPotion.Domain.Audits.generic_issue_error_type(),
          frameId: CDPotion.Domain.Page.frame_id() | nil,
          request: CDPotion.Domain.Audits.affected_request() | nil,
          violatingNodeAttribute: String.t() | nil,
          violatingNodeId: CDPotion.Domain.DOM.backend_node_id() | nil
        }

  @typedoc "description not provided :("
  @type generic_issue_error_type ::
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

  @typedoc "description not provided :("
  @type heavy_ad_issue_details :: %{
          frame: CDPotion.Domain.Audits.affected_frame(),
          reason: CDPotion.Domain.Audits.heavy_ad_reason(),
          resolution: CDPotion.Domain.Audits.heavy_ad_resolution_status()
        }

  @typedoc "description not provided :("
  @type heavy_ad_reason :: :NetworkTotalLimit | :CpuTotalLimit | :CpuPeakLimit

  @typedoc "description not provided :("
  @type heavy_ad_resolution_status :: :HeavyAdBlocked | :HeavyAdWarning

  @typedoc "An inspector issue reported from the back-end."
  @type inspector_issue :: %{
          code: CDPotion.Domain.Audits.inspector_issue_code(),
          details: CDPotion.Domain.Audits.inspector_issue_details(),
          issueId: CDPotion.Domain.Audits.issue_id() | nil
        }

  @typedoc "A unique identifier for the type of issue. Each type may use one of the
optional fields in InspectorIssueDetails to convey more specific
information about the kind of issue."
  @type inspector_issue_code ::
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

  @typedoc "This struct holds a list of optional fields with additional information
specific to the kind of issue. When adding a new issue code, please also
add a new optional field to this type."
  @type inspector_issue_details :: %{
          attributionReportingIssueDetails:
            CDPotion.Domain.Audits.attribution_reporting_issue_details() | nil,
          blockedByResponseIssueDetails:
            CDPotion.Domain.Audits.blocked_by_response_issue_details() | nil,
          bounceTrackingIssueDetails:
            CDPotion.Domain.Audits.bounce_tracking_issue_details() | nil,
          clientHintIssueDetails: CDPotion.Domain.Audits.client_hint_issue_details() | nil,
          contentSecurityPolicyIssueDetails:
            CDPotion.Domain.Audits.content_security_policy_issue_details() | nil,
          cookieIssueDetails: CDPotion.Domain.Audits.cookie_issue_details() | nil,
          corsIssueDetails: CDPotion.Domain.Audits.cors_issue_details() | nil,
          deprecationIssueDetails: CDPotion.Domain.Audits.deprecation_issue_details() | nil,
          federatedAuthRequestIssueDetails:
            CDPotion.Domain.Audits.federated_auth_request_issue_details() | nil,
          federatedAuthUserInfoRequestIssueDetails:
            CDPotion.Domain.Audits.federated_auth_user_info_request_issue_details() | nil,
          genericIssueDetails: CDPotion.Domain.Audits.generic_issue_details() | nil,
          heavyAdIssueDetails: CDPotion.Domain.Audits.heavy_ad_issue_details() | nil,
          lowTextContrastIssueDetails:
            CDPotion.Domain.Audits.low_text_contrast_issue_details() | nil,
          mixedContentIssueDetails: CDPotion.Domain.Audits.mixed_content_issue_details() | nil,
          navigatorUserAgentIssueDetails:
            CDPotion.Domain.Audits.navigator_user_agent_issue_details() | nil,
          quirksModeIssueDetails: CDPotion.Domain.Audits.quirks_mode_issue_details() | nil,
          sharedArrayBufferIssueDetails:
            CDPotion.Domain.Audits.shared_array_buffer_issue_details() | nil,
          stylesheetLoadingIssueDetails:
            CDPotion.Domain.Audits.stylesheet_loading_issue_details() | nil
        }

  @typedoc "A unique id for a DevTools inspector issue. Allows other entities (e.g.
exceptions, CDP message, console messages, etc.) to reference an issue."
  @type issue_id :: String.t()

  @typedoc "description not provided :("
  @type low_text_contrast_issue_details :: %{
          contrastRatio: number(),
          fontSize: String.t(),
          fontWeight: String.t(),
          thresholdAA: number(),
          thresholdAAA: number(),
          violatingNodeId: CDPotion.Domain.DOM.backend_node_id(),
          violatingNodeSelector: String.t()
        }

  @typedoc "description not provided :("
  @type mixed_content_issue_details :: %{
          frame: CDPotion.Domain.Audits.affected_frame() | nil,
          insecureURL: String.t(),
          mainResourceURL: String.t(),
          request: CDPotion.Domain.Audits.affected_request() | nil,
          resolutionStatus: CDPotion.Domain.Audits.mixed_content_resolution_status(),
          resourceType: CDPotion.Domain.Audits.mixed_content_resource_type() | nil
        }

  @typedoc "description not provided :("
  @type mixed_content_resolution_status ::
          :MixedContentBlocked | :MixedContentAutomaticallyUpgraded | :MixedContentWarning

  @typedoc "description not provided :("
  @type mixed_content_resource_type ::
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

  @typedoc "description not provided :("
  @type navigator_user_agent_issue_details :: %{
          location: CDPotion.Domain.Audits.source_code_location() | nil,
          url: String.t()
        }

  @typedoc "Details for issues about documents in Quirks Mode
or Limited Quirks Mode that affects page layouting."
  @type quirks_mode_issue_details :: %{
          documentNodeId: CDPotion.Domain.DOM.backend_node_id(),
          frameId: CDPotion.Domain.Page.frame_id(),
          isLimitedQuirksMode: boolean(),
          loaderId: CDPotion.Domain.Network.loader_id(),
          url: String.t()
        }

  @typedoc "Details for a issue arising from an SAB being instantiated in, or
transferred to a context that is not cross-origin isolated."
  @type shared_array_buffer_issue_details :: %{
          isWarning: boolean(),
          sourceCodeLocation: CDPotion.Domain.Audits.source_code_location(),
          type: CDPotion.Domain.Audits.shared_array_buffer_issue_type()
        }

  @typedoc "description not provided :("
  @type shared_array_buffer_issue_type :: :TransferIssue | :CreationIssue

  @typedoc "description not provided :("
  @type source_code_location :: %{
          columnNumber: integer(),
          lineNumber: integer(),
          scriptId: CDPotion.Domain.Runtime.script_id() | nil,
          url: String.t()
        }

  @typedoc "description not provided :("
  @type style_sheet_loading_issue_reason :: :LateImportRule | :RequestFailed

  @typedoc "This issue warns when a referenced stylesheet couldn't be loaded."
  @type stylesheet_loading_issue_details :: %{
          failedRequestInfo: CDPotion.Domain.Audits.failed_request_info() | nil,
          sourceCodeLocation: CDPotion.Domain.Audits.source_code_location(),
          styleSheetLoadingIssueReason: CDPotion.Domain.Audits.style_sheet_loading_issue_reason()
        }

  @doc """
  Returns the response body and size if it were re-encoded with the specified settings. Only
  applies to images.
  ## Parameters:
    - (Required) `request_id`: Identifier of the network request to get content for.
  - (Required) `encoding`: The encoding to use.
  - (Optional) `quality`: The quality of the encoding (0-1). (defaults to 1)
  - (Optional) `size_only`: Whether to only return the size information (defaults to false).
  """
  @spec get_encoded_response(
          CDPotion.Domain.Network.request_id(),
          String.t(),
          number(),
          boolean()
        ) :: {String.t(), map()}
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
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Audits.disable", %{}}
  end

  @doc """
  Enables issues domain, sends the issues collected so far to the client by means of the
  `issueAdded` event.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Audits.enable", %{}}
  end

  @doc """
  Runs the contrast check for the target page. Found issues are reported
  using Audits.issueAdded event.
  ## Parameters:
    - (Optional) `report_aaa`: Whether to report WCAG AAA level issues. Default is false.
  """
  @spec check_contrast(boolean()) :: {String.t(), map()}
  def check_contrast(report_aaa \\ nil) do
    params = as_query([{"reportAAA", report_aaa}])
    {"Audits.checkContrast", params}
  end

  @doc """
  Runs the form issues check for the target page. Found issues are reported
  using Audits.issueAdded event.
  """
  @spec check_forms_issues() :: {String.t(), map()}
  def check_forms_issues() do
    {"Audits.checkFormsIssues", %{}}
  end
end
