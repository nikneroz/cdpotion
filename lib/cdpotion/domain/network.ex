defmodule CDPotion.Domain.Network do
  use CDPotion.Utils
  @typedoc "The reason why Chrome uses a specific transport protocol for HTTP semantics."
  @type alternate_protocol_usage ::
          :alternativeJobWonWithoutRace
          | :alternativeJobWonRace
          | :mainJobWonRace
          | :mappingMissing
          | :broken
          | :dnsAlpnH3JobWonWithoutRace
          | :dnsAlpnH3JobWonRace
          | :unspecifiedReason

  @typedoc "Authorization challenge for HTTP status code 401 or 407."
  @type auth_challenge :: %{
          origin: String.t(),
          realm: String.t(),
          scheme: String.t(),
          source: :Server | :Proxy | nil
        }

  @typedoc "Response to an AuthChallenge."
  @type auth_challenge_response :: %{
          password: String.t() | nil,
          response: :Default | :CancelAuth | :ProvideCredentials,
          username: String.t() | nil
        }

  @typedoc "A cookie with was not sent with a request with the corresponding reason."
  @type blocked_cookie_with_reason :: %{
          blockedReasons: list(CDPotion.Domain.Network.cookie_blocked_reason()),
          cookie: CDPotion.Domain.Network.cookie()
        }

  @typedoc "The reason why request was blocked."
  @type blocked_reason ::
          :other
          | :csp
          | :"mixed-content"
          | :origin
          | :inspector
          | :"subresource-filter"
          | :"content-type"
          | :"coep-frame-resource-needs-coep-header"
          | :"coop-sandboxed-iframe-cannot-navigate-to-coop-page"
          | :"corp-not-same-origin"
          | :"corp-not-same-origin-after-defaulted-to-same-origin-by-coep"
          | :"corp-not-same-site"

  @typedoc "A cookie which was not stored from a response with the corresponding reason."
  @type blocked_set_cookie_with_reason :: %{
          blockedReasons: list(CDPotion.Domain.Network.set_cookie_blocked_reason()),
          cookie: CDPotion.Domain.Network.cookie() | nil,
          cookieLine: String.t()
        }

  @typedoc "Information about the cached resource."
  @type cached_resource :: %{
          bodySize: number(),
          response: CDPotion.Domain.Network.response() | nil,
          type: CDPotion.Domain.Network.resource_type(),
          url: String.t()
        }

  @typedoc "Whether the request complied with Certificate Transparency policy."
  @type certificate_transparency_compliance :: :unknown | :"not-compliant" | :compliant

  @typedoc "description not provided :("
  @type client_security_state :: %{
          initiatorIPAddressSpace: CDPotion.Domain.Network.ip_address_space(),
          initiatorIsSecureContext: boolean(),
          privateNetworkRequestPolicy: CDPotion.Domain.Network.private_network_request_policy()
        }

  @typedoc "description not provided :("
  @type connect_timing :: %{
          requestTime: number()
        }

  @typedoc "The underlying connection technology that the browser is supposedly using."
  @type connection_type ::
          :none
          | :cellular2g
          | :cellular3g
          | :cellular4g
          | :bluetooth
          | :ethernet
          | :wifi
          | :wimax
          | :other

  @typedoc "List of content encodings supported by the backend."
  @type content_encoding :: :deflate | :gzip | :br | :zstd

  @typedoc "description not provided :("
  @type content_security_policy_source :: :HTTP | :Meta

  @typedoc "description not provided :("
  @type content_security_policy_status :: %{
          effectiveDirectives: String.t(),
          isEnforced: boolean(),
          source: CDPotion.Domain.Network.content_security_policy_source()
        }

  @typedoc "Cookie object"
  @type cookie :: %{
          domain: String.t(),
          expires: number(),
          httpOnly: boolean(),
          name: String.t(),
          partitionKey: String.t() | nil,
          partitionKeyOpaque: boolean() | nil,
          path: String.t(),
          priority: CDPotion.Domain.Network.cookie_priority(),
          sameParty: boolean(),
          sameSite: CDPotion.Domain.Network.cookie_same_site() | nil,
          secure: boolean(),
          session: boolean(),
          size: integer(),
          sourcePort: integer(),
          sourceScheme: CDPotion.Domain.Network.cookie_source_scheme(),
          value: String.t()
        }

  @typedoc "Types of reasons why a cookie may not be sent with a request."
  @type cookie_blocked_reason ::
          :SecureOnly
          | :NotOnPath
          | :DomainMismatch
          | :SameSiteStrict
          | :SameSiteLax
          | :SameSiteUnspecifiedTreatedAsLax
          | :SameSiteNoneInsecure
          | :UserPreferences
          | :ThirdPartyBlockedInFirstPartySet
          | :UnknownError
          | :SchemefulSameSiteStrict
          | :SchemefulSameSiteLax
          | :SchemefulSameSiteUnspecifiedTreatedAsLax
          | :SamePartyFromCrossPartyContext
          | :NameValuePairExceedsMaxSize

  @typedoc "Cookie parameter object"
  @type cookie_param :: %{
          domain: String.t() | nil,
          expires: CDPotion.Domain.Network.time_since_epoch() | nil,
          httpOnly: boolean() | nil,
          name: String.t(),
          partitionKey: String.t() | nil,
          path: String.t() | nil,
          priority: CDPotion.Domain.Network.cookie_priority() | nil,
          sameParty: boolean() | nil,
          sameSite: CDPotion.Domain.Network.cookie_same_site() | nil,
          secure: boolean() | nil,
          sourcePort: integer() | nil,
          sourceScheme: CDPotion.Domain.Network.cookie_source_scheme() | nil,
          url: String.t() | nil,
          value: String.t()
        }

  @typedoc "Represents the cookie's 'Priority' status:
https://tools.ietf.org/html/draft-west-cookie-priority-00"
  @type cookie_priority :: :Low | :Medium | :High

  @typedoc "Represents the cookie's 'SameSite' status:
https://tools.ietf.org/html/draft-west-first-party-cookies"
  @type cookie_same_site :: :Strict | :Lax | :None

  @typedoc "Represents the source scheme of the origin that originally set the cookie.
A value of 'Unset' allows protocol clients to emulate legacy cookie scope for the scheme.
This is a temporary ability and it will be removed in the future."
  @type cookie_source_scheme :: :Unset | :NonSecure | :Secure

  @typedoc "The reason why request was blocked."
  @type cors_error ::
          :DisallowedByMode
          | :InvalidResponse
          | :WildcardOriginNotAllowed
          | :MissingAllowOriginHeader
          | :MultipleAllowOriginValues
          | :InvalidAllowOriginValue
          | :AllowOriginMismatch
          | :InvalidAllowCredentials
          | :CorsDisabledScheme
          | :PreflightInvalidStatus
          | :PreflightDisallowedRedirect
          | :PreflightWildcardOriginNotAllowed
          | :PreflightMissingAllowOriginHeader
          | :PreflightMultipleAllowOriginValues
          | :PreflightInvalidAllowOriginValue
          | :PreflightAllowOriginMismatch
          | :PreflightInvalidAllowCredentials
          | :PreflightMissingAllowExternal
          | :PreflightInvalidAllowExternal
          | :PreflightMissingAllowPrivateNetwork
          | :PreflightInvalidAllowPrivateNetwork
          | :InvalidAllowMethodsPreflightResponse
          | :InvalidAllowHeadersPreflightResponse
          | :MethodDisallowedByPreflightResponse
          | :HeaderDisallowedByPreflightResponse
          | :RedirectContainsCredentials
          | :InsecurePrivateNetwork
          | :InvalidPrivateNetworkAccess
          | :UnexpectedPrivateNetworkAccess
          | :NoCorsRedirectModeNotFollow
          | :PreflightMissingPrivateNetworkAccessId
          | :PreflightMissingPrivateNetworkAccessName
          | :PrivateNetworkAccessPermissionUnavailable
          | :PrivateNetworkAccessPermissionDenied

  @typedoc "description not provided :("
  @type cors_error_status :: %{
          corsError: CDPotion.Domain.Network.cors_error(),
          failedParameter: String.t()
        }

  @typedoc "description not provided :("
  @type cross_origin_embedder_policy_status :: %{
          reportOnlyReportingEndpoint: String.t() | nil,
          reportOnlyValue: CDPotion.Domain.Network.cross_origin_embedder_policy_value(),
          reportingEndpoint: String.t() | nil,
          value: CDPotion.Domain.Network.cross_origin_embedder_policy_value()
        }

  @typedoc "description not provided :("
  @type cross_origin_embedder_policy_value :: :None | :Credentialless | :RequireCorp

  @typedoc "description not provided :("
  @type cross_origin_opener_policy_status :: %{
          reportOnlyReportingEndpoint: String.t() | nil,
          reportOnlyValue: CDPotion.Domain.Network.cross_origin_opener_policy_value(),
          reportingEndpoint: String.t() | nil,
          value: CDPotion.Domain.Network.cross_origin_opener_policy_value()
        }

  @typedoc "description not provided :("
  @type cross_origin_opener_policy_value ::
          :SameOrigin
          | :SameOriginAllowPopups
          | :RestrictProperties
          | :UnsafeNone
          | :SameOriginPlusCoep
          | :RestrictPropertiesPlusCoep

  @typedoc "Network level fetch failure reason."
  @type error_reason ::
          :Failed
          | :Aborted
          | :TimedOut
          | :AccessDenied
          | :ConnectionClosed
          | :ConnectionReset
          | :ConnectionRefused
          | :ConnectionAborted
          | :ConnectionFailed
          | :NameNotResolved
          | :InternetDisconnected
          | :AddressUnreachable
          | :BlockedByClient
          | :BlockedByResponse

  @typedoc "Request / response headers as keys / values of JSON object."
  @type headers :: map()

  @typedoc "description not provided :("
  @type ip_address_space :: :Local | :Private | :Public | :Unknown

  @typedoc "Information about the request initiator."
  @type initiator :: %{
          columnNumber: number() | nil,
          lineNumber: number() | nil,
          requestId: CDPotion.Domain.Network.request_id() | nil,
          stack: CDPotion.Domain.Runtime.stack_trace() | nil,
          type: :parser | :script | :preload | :SignedExchange | :preflight | :other,
          url: String.t() | nil
        }

  @typedoc "Unique intercepted request identifier."
  @type interception_id :: String.t()

  @typedoc "Stages of the interception to begin intercepting. Request will intercept before the request is
sent. Response will intercept after the response is received."
  @type interception_stage :: :Request | :HeadersReceived

  @typedoc "An options object that may be extended later to better support CORS,
CORB and streaming."
  @type load_network_resource_options :: %{
          disableCache: boolean(),
          includeCredentials: boolean()
        }

  @typedoc "An object providing the result of a network resource load."
  @type load_network_resource_page_result :: %{
          headers: CDPotion.Domain.Network.headers() | nil,
          httpStatusCode: number() | nil,
          netError: number() | nil,
          netErrorName: String.t() | nil,
          stream: CDPotion.Domain.IO.stream_handle() | nil,
          success: boolean()
        }

  @typedoc "Unique loader identifier."
  @type loader_id :: String.t()

  @typedoc "Monotonically increasing time in seconds since an arbitrary point in the past."
  @type monotonic_time :: number()

  @typedoc "Post data entry for HTTP request"
  @type post_data_entry :: %{
          bytes: String.t() | nil
        }

  @typedoc "description not provided :("
  @type private_network_request_policy ::
          :Allow
          | :BlockFromInsecureToMorePrivate
          | :WarnFromInsecureToMorePrivate
          | :PreflightBlock
          | :PreflightWarn

  @typedoc "description not provided :("
  @type report_id :: String.t()

  @typedoc "The status of a Reporting API report."
  @type report_status :: :Queued | :Pending | :MarkedForRemoval | :Success

  @typedoc "description not provided :("
  @type reporting_api_endpoint :: %{
          groupName: String.t(),
          url: String.t()
        }

  @typedoc "An object representing a report generated by the Reporting API."
  @type reporting_api_report :: %{
          body: map(),
          completedAttempts: integer(),
          depth: integer(),
          destination: String.t(),
          id: CDPotion.Domain.Network.report_id(),
          initiatorUrl: String.t(),
          status: CDPotion.Domain.Network.report_status(),
          timestamp: CDPotion.Domain.Network.time_since_epoch(),
          type: String.t()
        }

  @typedoc "HTTP request data."
  @type request :: %{
          hasPostData: boolean() | nil,
          headers: CDPotion.Domain.Network.headers(),
          initialPriority: CDPotion.Domain.Network.resource_priority(),
          isLinkPreload: boolean() | nil,
          isSameSite: boolean() | nil,
          method: String.t(),
          mixedContentType: CDPotion.Domain.Security.mixed_content_type() | nil,
          postData: String.t() | nil,
          postDataEntries: list(CDPotion.Domain.Network.post_data_entry()) | nil,
          referrerPolicy:
            :"unsafe-url"
            | :"no-referrer-when-downgrade"
            | :"no-referrer"
            | :origin
            | :"origin-when-cross-origin"
            | :"same-origin"
            | :"strict-origin"
            | :"strict-origin-when-cross-origin",
          trustTokenParams: CDPotion.Domain.Network.trust_token_params() | nil,
          url: String.t(),
          urlFragment: String.t() | nil
        }

  @typedoc "Unique request identifier."
  @type request_id :: String.t()

  @typedoc "Request pattern for interception."
  @type request_pattern :: %{
          interceptionStage: CDPotion.Domain.Network.interception_stage() | nil,
          resourceType: CDPotion.Domain.Network.resource_type() | nil,
          urlPattern: String.t() | nil
        }

  @typedoc "Loading priority of a resource request."
  @type resource_priority :: :VeryLow | :Low | :Medium | :High | :VeryHigh

  @typedoc "Timing information for the request."
  @type resource_timing :: %{
          connectEnd: number(),
          connectStart: number(),
          dnsEnd: number(),
          dnsStart: number(),
          proxyEnd: number(),
          proxyStart: number(),
          pushEnd: number(),
          pushStart: number(),
          receiveHeadersEnd: number(),
          receiveHeadersStart: number(),
          requestTime: number(),
          sendEnd: number(),
          sendStart: number(),
          sslEnd: number(),
          sslStart: number(),
          workerFetchStart: number(),
          workerReady: number(),
          workerRespondWithSettled: number(),
          workerStart: number()
        }

  @typedoc "Resource type as it was perceived by the rendering engine."
  @type resource_type ::
          :Document
          | :Stylesheet
          | :Image
          | :Media
          | :Font
          | :Script
          | :TextTrack
          | :XHR
          | :Fetch
          | :Prefetch
          | :EventSource
          | :WebSocket
          | :Manifest
          | :SignedExchange
          | :Ping
          | :CSPViolationReport
          | :Preflight
          | :Other

  @typedoc "HTTP response data."
  @type response :: %{
          alternateProtocolUsage: CDPotion.Domain.Network.alternate_protocol_usage() | nil,
          cacheStorageCacheName: String.t() | nil,
          connectionId: number(),
          connectionReused: boolean(),
          encodedDataLength: number(),
          fromDiskCache: boolean() | nil,
          fromPrefetchCache: boolean() | nil,
          fromServiceWorker: boolean() | nil,
          headers: CDPotion.Domain.Network.headers(),
          headersText: String.t() | nil,
          mimeType: String.t(),
          protocol: String.t() | nil,
          remoteIPAddress: String.t() | nil,
          remotePort: integer() | nil,
          requestHeaders: CDPotion.Domain.Network.headers() | nil,
          requestHeadersText: String.t() | nil,
          responseTime: CDPotion.Domain.Network.time_since_epoch() | nil,
          securityDetails: CDPotion.Domain.Network.security_details() | nil,
          securityState: CDPotion.Domain.Security.security_state(),
          serviceWorkerResponseSource:
            CDPotion.Domain.Network.service_worker_response_source() | nil,
          status: integer(),
          statusText: String.t(),
          timing: CDPotion.Domain.Network.resource_timing() | nil,
          url: String.t()
        }

  @typedoc "Security details about a request."
  @type security_details :: %{
          certificateId: CDPotion.Domain.Security.certificate_id(),
          certificateTransparencyCompliance:
            CDPotion.Domain.Network.certificate_transparency_compliance(),
          cipher: String.t(),
          encryptedClientHello: boolean(),
          issuer: String.t(),
          keyExchange: String.t(),
          keyExchangeGroup: String.t() | nil,
          mac: String.t() | nil,
          protocol: String.t(),
          sanList: list(String.t()),
          serverSignatureAlgorithm: integer() | nil,
          signedCertificateTimestampList:
            list(CDPotion.Domain.Network.signed_certificate_timestamp()),
          subjectName: String.t(),
          validFrom: CDPotion.Domain.Network.time_since_epoch(),
          validTo: CDPotion.Domain.Network.time_since_epoch()
        }

  @typedoc "description not provided :("
  @type security_isolation_status :: %{
          coep: CDPotion.Domain.Network.cross_origin_embedder_policy_status() | nil,
          coop: CDPotion.Domain.Network.cross_origin_opener_policy_status() | nil,
          csp: list(CDPotion.Domain.Network.content_security_policy_status()) | nil
        }

  @typedoc "Source of serviceworker response."
  @type service_worker_response_source ::
          :"cache-storage" | :"http-cache" | :"fallback-code" | :network

  @typedoc "Types of reasons why a cookie may not be stored from a response."
  @type set_cookie_blocked_reason ::
          :SecureOnly
          | :SameSiteStrict
          | :SameSiteLax
          | :SameSiteUnspecifiedTreatedAsLax
          | :SameSiteNoneInsecure
          | :UserPreferences
          | :ThirdPartyBlockedInFirstPartySet
          | :SyntaxError
          | :SchemeNotSupported
          | :OverwriteSecure
          | :InvalidDomain
          | :InvalidPrefix
          | :UnknownError
          | :SchemefulSameSiteStrict
          | :SchemefulSameSiteLax
          | :SchemefulSameSiteUnspecifiedTreatedAsLax
          | :SamePartyFromCrossPartyContext
          | :SamePartyConflictsWithOtherAttributes
          | :NameValuePairExceedsMaxSize

  @typedoc "Details of a signed certificate timestamp (SCT)."
  @type signed_certificate_timestamp :: %{
          hashAlgorithm: String.t(),
          logDescription: String.t(),
          logId: String.t(),
          origin: String.t(),
          signatureAlgorithm: String.t(),
          signatureData: String.t(),
          status: String.t(),
          timestamp: number()
        }

  @typedoc "Information about a signed exchange response."
  @type signed_exchange_error :: %{
          errorField: CDPotion.Domain.Network.signed_exchange_error_field() | nil,
          message: String.t(),
          signatureIndex: integer() | nil
        }

  @typedoc "Field type for a signed exchange related error."
  @type signed_exchange_error_field ::
          :signatureSig
          | :signatureIntegrity
          | :signatureCertUrl
          | :signatureCertSha256
          | :signatureValidityUrl
          | :signatureTimestamps

  @typedoc "Information about a signed exchange header.
https://wicg.github.io/webpackage/draft-yasskin-httpbis-origin-signed-exchanges-impl.html#cbor-representation"
  @type signed_exchange_header :: %{
          headerIntegrity: String.t(),
          requestUrl: String.t(),
          responseCode: integer(),
          responseHeaders: CDPotion.Domain.Network.headers(),
          signatures: list(CDPotion.Domain.Network.signed_exchange_signature())
        }

  @typedoc "Information about a signed exchange response."
  @type signed_exchange_info :: %{
          errors: list(CDPotion.Domain.Network.signed_exchange_error()) | nil,
          header: CDPotion.Domain.Network.signed_exchange_header() | nil,
          outerResponse: CDPotion.Domain.Network.response(),
          securityDetails: CDPotion.Domain.Network.security_details() | nil
        }

  @typedoc "Information about a signed exchange signature.
https://wicg.github.io/webpackage/draft-yasskin-httpbis-origin-signed-exchanges-impl.html#rfc.section.3.1"
  @type signed_exchange_signature :: %{
          certSha256: String.t() | nil,
          certUrl: String.t() | nil,
          certificates: list(String.t()) | nil,
          date: integer(),
          expires: integer(),
          integrity: String.t(),
          label: String.t(),
          signature: String.t(),
          validityUrl: String.t()
        }

  @typedoc "UTC time in seconds, counted from January 1, 1970."
  @type time_since_epoch :: number()

  @typedoc "description not provided :("
  @type trust_token_operation_type :: :Issuance | :Redemption | :Signing

  @typedoc "Determines what type of Trust Token operation is executed and
depending on the type, some additional parameters. The values
are specified in third_party/blink/renderer/core/fetch/trust_token.idl."
  @type trust_token_params :: %{
          issuers: list(String.t()) | nil,
          operation: CDPotion.Domain.Network.trust_token_operation_type(),
          refreshPolicy: :UseCached | :Refresh
        }

  @typedoc "WebSocket message data. This represents an entire WebSocket message, not just a fragmented frame as the name suggests."
  @type web_socket_frame :: %{
          mask: boolean(),
          opcode: number(),
          payloadData: String.t()
        }

  @typedoc "WebSocket request data."
  @type web_socket_request :: %{
          headers: CDPotion.Domain.Network.headers()
        }

  @typedoc "WebSocket response data."
  @type web_socket_response :: %{
          headers: CDPotion.Domain.Network.headers(),
          headersText: String.t() | nil,
          requestHeaders: CDPotion.Domain.Network.headers() | nil,
          requestHeadersText: String.t() | nil,
          status: integer(),
          statusText: String.t()
        }

  @doc """
  Sets a list of content encodings that will be accepted. Empty list means no encoding is accepted.
  ## Parameters:
    - (Required) `encodings`: List of accepted content encodings.
  """
  @spec set_accepted_encodings(list(CDPotion.Domain.Network.ContentEncoding)) ::
          {String.t(), map()}
  def set_accepted_encodings(encodings) do
    params = as_query([{"encodings", encodings}])
    {"Network.setAcceptedEncodings", params}
  end

  @doc """
  Clears accepted encodings set by setAcceptedEncodings
  """
  @spec clear_accepted_encodings_override() :: {String.t(), map()}
  def clear_accepted_encodings_override() do
    {"Network.clearAcceptedEncodingsOverride", %{}}
  end

  @doc """
  Tells whether clearing browser cache is supported.
  """
  @spec can_clear_browser_cache() :: {String.t(), map()}
  def can_clear_browser_cache() do
    {"Network.canClearBrowserCache", %{}}
  end

  @doc """
  Tells whether clearing browser cookies is supported.
  """
  @spec can_clear_browser_cookies() :: {String.t(), map()}
  def can_clear_browser_cookies() do
    {"Network.canClearBrowserCookies", %{}}
  end

  @doc """
  Tells whether emulation of network conditions is supported.
  """
  @spec can_emulate_network_conditions() :: {String.t(), map()}
  def can_emulate_network_conditions() do
    {"Network.canEmulateNetworkConditions", %{}}
  end

  @doc """
  Clears browser cache.
  """
  @spec clear_browser_cache() :: {String.t(), map()}
  def clear_browser_cache() do
    {"Network.clearBrowserCache", %{}}
  end

  @doc """
  Clears browser cookies.
  """
  @spec clear_browser_cookies() :: {String.t(), map()}
  def clear_browser_cookies() do
    {"Network.clearBrowserCookies", %{}}
  end

  @doc """
  Response to Network.requestIntercepted which either modifies the request to continue with any
  modifications, or blocks it, or completes it with the provided response bytes. If a network
  fetch occurs as a result which encounters a redirect an additional Network.requestIntercepted
  event will be sent with the same InterceptionId.
  Deprecated, use Fetch.continueRequest, Fetch.fulfillRequest and Fetch.failRequest instead.
  ## Parameters:
    - (Required) `interception_id`: description not provided :(
  - (Optional) `error_reason`: If set this causes the request to fail with the given reason. Passing `Aborted` for requests
  marked with `isNavigationRequest` also cancels the navigation. Must not be set in response
  to an authChallenge.
  - (Optional) `raw_response`: If set the requests completes using with the provided base64 encoded raw response, including
  HTTP status line and headers etc... Must not be set in response to an authChallenge. (Encoded as a base64 string when passed over JSON)
  - (Optional) `url`: If set the request url will be modified in a way that's not observable by page. Must not be
  set in response to an authChallenge.
  - (Optional) `method`: If set this allows the request method to be overridden. Must not be set in response to an
  authChallenge.
  - (Optional) `post_data`: If set this allows postData to be set. Must not be set in response to an authChallenge.
  - (Optional) `headers`: If set this allows the request headers to be changed. Must not be set in response to an
  authChallenge.
  - (Optional) `auth_challenge_response`: Response to a requestIntercepted with an authChallenge. Must not be set otherwise.
  """
  @spec continue_intercepted_request(
          CDPotion.Domain.Network.InterceptionId,
          CDPotion.Domain.Network.ErrorReason,
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          CDPotion.Domain.Network.Headers,
          CDPotion.Domain.Network.AuthChallengeResponse
        ) :: {String.t(), map()}
  def continue_intercepted_request(
        interception_id,
        error_reason \\ nil,
        raw_response \\ nil,
        url \\ nil,
        method \\ nil,
        post_data \\ nil,
        headers \\ nil,
        auth_challenge_response \\ nil
      ) do
    params =
      as_query([
        {"interceptionId", interception_id},
        {"errorReason", error_reason},
        {"rawResponse", raw_response},
        {"url", url},
        {"method", method},
        {"postData", post_data},
        {"headers", headers},
        {"authChallengeResponse", auth_challenge_response}
      ])

    {"Network.continueInterceptedRequest", params}
  end

  @doc """
  Deletes browser cookies with matching name and url or domain/path pair.
  ## Parameters:
    - (Required) `name`: Name of the cookies to remove.
  - (Optional) `url`: If specified, deletes all the cookies with the given name where domain and path match
  provided URL.
  - (Optional) `domain`: If specified, deletes only cookies with the exact domain.
  - (Optional) `path`: If specified, deletes only cookies with the exact path.
  """
  @spec delete_cookies(String.t(), String.t(), String.t(), String.t()) :: {String.t(), map()}
  def delete_cookies(name, url \\ nil, domain \\ nil, path \\ nil) do
    params = as_query([{"name", name}, {"url", url}, {"domain", domain}, {"path", path}])
    {"Network.deleteCookies", params}
  end

  @doc """
  Disables network tracking, prevents network events from being sent to the client.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Network.disable", %{}}
  end

  @doc """
  Activates emulation of network conditions.
  ## Parameters:
    - (Required) `offline`: True to emulate internet disconnection.
  - (Required) `latency`: Minimum latency from request sent to response headers received (ms).
  - (Required) `download_throughput`: Maximal aggregated download throughput (bytes/sec). -1 disables download throttling.
  - (Required) `upload_throughput`: Maximal aggregated upload throughput (bytes/sec).  -1 disables upload throttling.
  - (Optional) `connection_type`: Connection type if known.
  """
  @spec emulate_network_conditions(
          boolean(),
          number(),
          number(),
          number(),
          CDPotion.Domain.Network.ConnectionType
        ) :: {String.t(), map()}
  def emulate_network_conditions(
        offline,
        latency,
        download_throughput,
        upload_throughput,
        connection_type \\ nil
      ) do
    params =
      as_query([
        {"offline", offline},
        {"latency", latency},
        {"downloadThroughput", download_throughput},
        {"uploadThroughput", upload_throughput},
        {"connectionType", connection_type}
      ])

    {"Network.emulateNetworkConditions", params}
  end

  @doc """
  Enables network tracking, network events will now be delivered to the client.
  ## Parameters:
    - (Optional) `max_total_buffer_size`: Buffer size in bytes to use when preserving network payloads (XHRs, etc).
  - (Optional) `max_resource_buffer_size`: Per-resource buffer size in bytes to use when preserving network payloads (XHRs, etc).
  - (Optional) `max_post_data_size`: Longest post body size (in bytes) that would be included in requestWillBeSent notification
  """
  @spec enable(integer(), integer(), integer()) :: {String.t(), map()}
  def enable(
        max_total_buffer_size \\ nil,
        max_resource_buffer_size \\ nil,
        max_post_data_size \\ nil
      ) do
    params =
      as_query([
        {"maxTotalBufferSize", max_total_buffer_size},
        {"maxResourceBufferSize", max_resource_buffer_size},
        {"maxPostDataSize", max_post_data_size}
      ])

    {"Network.enable", params}
  end

  @doc """
  Returns all browser cookies. Depending on the backend support, will return detailed cookie
  information in the `cookies` field.
  Deprecated. Use Storage.getCookies instead.
  """
  @spec get_all_cookies() :: {String.t(), map()}
  def get_all_cookies() do
    {"Network.getAllCookies", %{}}
  end

  @doc """
  Returns the DER-encoded certificate.
  ## Parameters:
    - (Required) `origin`: Origin to get certificate for.
  """
  @spec get_certificate(String.t()) :: {String.t(), map()}
  def get_certificate(origin) do
    params = as_query([{"origin", origin}])
    {"Network.getCertificate", params}
  end

  @doc """
  Returns all browser cookies for the current URL. Depending on the backend support, will return
  detailed cookie information in the `cookies` field.
  ## Parameters:
    - (Optional) `urls`: The list of URLs for which applicable cookies will be fetched.
  If not specified, it's assumed to be set to the list containing
  the URLs of the page and all of its subframes.
  """
  @spec get_cookies(list(String.t())) :: {String.t(), map()}
  def get_cookies(urls \\ nil) do
    params = as_query([{"urls", urls}])
    {"Network.getCookies", params}
  end

  @doc """
  Returns content served for the given request.
  ## Parameters:
    - (Required) `request_id`: Identifier of the network request to get content for.
  """
  @spec get_response_body(CDPotion.Domain.Network.RequestId) :: {String.t(), map()}
  def get_response_body(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Network.getResponseBody", params}
  end

  @doc """
  Returns post data sent with the request. Returns an error when no data was sent with the request.
  ## Parameters:
    - (Required) `request_id`: Identifier of the network request to get content for.
  """
  @spec get_request_post_data(CDPotion.Domain.Network.RequestId) :: {String.t(), map()}
  def get_request_post_data(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Network.getRequestPostData", params}
  end

  @doc """
  Returns content served for the given currently intercepted request.
  ## Parameters:
    - (Required) `interception_id`: Identifier for the intercepted request to get body for.
  """
  @spec get_response_body_for_interception(CDPotion.Domain.Network.InterceptionId) ::
          {String.t(), map()}
  def get_response_body_for_interception(interception_id) do
    params = as_query([{"interceptionId", interception_id}])
    {"Network.getResponseBodyForInterception", params}
  end

  @doc """
  Returns a handle to the stream representing the response body. Note that after this command,
  the intercepted request can't be continued as is -- you either need to cancel it or to provide
  the response body. The stream only supports sequential read, IO.read will fail if the position
  is specified.
  ## Parameters:
    - (Required) `interception_id`: description not provided :(
  """
  @spec take_response_body_for_interception_as_stream(CDPotion.Domain.Network.InterceptionId) ::
          {String.t(), map()}
  def take_response_body_for_interception_as_stream(interception_id) do
    params = as_query([{"interceptionId", interception_id}])
    {"Network.takeResponseBodyForInterceptionAsStream", params}
  end

  @doc """
  This method sends a new XMLHttpRequest which is identical to the original one. The following
  parameters should be identical: method, url, async, request body, extra headers, withCredentials
  attribute, user, password.
  ## Parameters:
    - (Required) `request_id`: Identifier of XHR to replay.
  """
  @spec replay_xhr(CDPotion.Domain.Network.RequestId) :: {String.t(), map()}
  def replay_xhr(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Network.replayXHR", params}
  end

  @doc """
  Searches for given string in response content.
  ## Parameters:
    - (Required) `request_id`: Identifier of the network response to search.
  - (Required) `query`: String to search for.
  - (Optional) `case_sensitive`: If true, search is case sensitive.
  - (Optional) `is_regex`: If true, treats string parameter as regex.
  """
  @spec search_in_response_body(
          CDPotion.Domain.Network.RequestId,
          String.t(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
  def search_in_response_body(request_id, query, case_sensitive \\ nil, is_regex \\ nil) do
    params =
      as_query([
        {"requestId", request_id},
        {"query", query},
        {"caseSensitive", case_sensitive},
        {"isRegex", is_regex}
      ])

    {"Network.searchInResponseBody", params}
  end

  @doc """
  Blocks URLs from loading.
  ## Parameters:
    - (Required) `urls`: URL patterns to block. Wildcards ('*') are allowed.
  """
  @spec set_blocked_ur_ls(list(String.t())) :: {String.t(), map()}
  def set_blocked_ur_ls(urls) do
    params = as_query([{"urls", urls}])
    {"Network.setBlockedURLs", params}
  end

  @doc """
  Toggles ignoring of service worker for each request.
  ## Parameters:
    - (Required) `bypass`: Bypass service worker and load from network.
  """
  @spec set_bypass_service_worker(boolean()) :: {String.t(), map()}
  def set_bypass_service_worker(bypass) do
    params = as_query([{"bypass", bypass}])
    {"Network.setBypassServiceWorker", params}
  end

  @doc """
  Toggles ignoring cache for each request. If `true`, cache will not be used.
  ## Parameters:
    - (Required) `cache_disabled`: Cache disabled state.
  """
  @spec set_cache_disabled(boolean()) :: {String.t(), map()}
  def set_cache_disabled(cache_disabled) do
    params = as_query([{"cacheDisabled", cache_disabled}])
    {"Network.setCacheDisabled", params}
  end

  @doc """
  Sets a cookie with the given cookie data; may overwrite equivalent cookies if they exist.
  ## Parameters:
    - (Required) `name`: Cookie name.
  - (Required) `value`: Cookie value.
  - (Optional) `url`: The request-URI to associate with the setting of the cookie. This value can affect the
  default domain, path, source port, and source scheme values of the created cookie.
  - (Optional) `domain`: Cookie domain.
  - (Optional) `path`: Cookie path.
  - (Optional) `secure`: True if cookie is secure.
  - (Optional) `http_only`: True if cookie is http-only.
  - (Optional) `same_site`: Cookie SameSite type.
  - (Optional) `expires`: Cookie expiration date, session cookie if not set
  - (Optional) `priority`: Cookie Priority type.
  - (Optional) `same_party`: True if cookie is SameParty.
  - (Optional) `source_scheme`: Cookie source scheme type.
  - (Optional) `source_port`: Cookie source port. Valid values are {-1, [1, 65535]}, -1 indicates an unspecified port.
  An unspecified port value allows protocol clients to emulate legacy cookie scope for the port.
  This is a temporary ability and it will be removed in the future.
  - (Optional) `partition_key`: Cookie partition key. The site of the top-level URL the browser was visiting at the start
  of the request to the endpoint that set the cookie.
  If not set, the cookie will be set as not partitioned.
  """
  @spec set_cookie(
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          boolean(),
          boolean(),
          CDPotion.Domain.Network.CookieSameSite,
          CDPotion.Domain.Network.TimeSinceEpoch,
          CDPotion.Domain.Network.CookiePriority,
          boolean(),
          CDPotion.Domain.Network.CookieSourceScheme,
          integer(),
          String.t()
        ) :: {String.t(), map()}
  def set_cookie(
        name,
        value,
        url \\ nil,
        domain \\ nil,
        path \\ nil,
        secure \\ nil,
        http_only \\ nil,
        same_site \\ nil,
        expires \\ nil,
        priority \\ nil,
        same_party \\ nil,
        source_scheme \\ nil,
        source_port \\ nil,
        partition_key \\ nil
      ) do
    params =
      as_query([
        {"name", name},
        {"value", value},
        {"url", url},
        {"domain", domain},
        {"path", path},
        {"secure", secure},
        {"httpOnly", http_only},
        {"sameSite", same_site},
        {"expires", expires},
        {"priority", priority},
        {"sameParty", same_party},
        {"sourceScheme", source_scheme},
        {"sourcePort", source_port},
        {"partitionKey", partition_key}
      ])

    {"Network.setCookie", params}
  end

  @doc """
  Sets given cookies.
  ## Parameters:
    - (Required) `cookies`: Cookies to be set.
  """
  @spec set_cookies(list(CDPotion.Domain.Network.CookieParam)) :: {String.t(), map()}
  def set_cookies(cookies) do
    params = as_query([{"cookies", cookies}])
    {"Network.setCookies", params}
  end

  @doc """
  Specifies whether to always send extra HTTP headers with the requests from this page.
  ## Parameters:
    - (Required) `headers`: Map with extra HTTP headers.
  """
  @spec set_extra_http_headers(CDPotion.Domain.Network.Headers) :: {String.t(), map()}
  def set_extra_http_headers(headers) do
    params = as_query([{"headers", headers}])
    {"Network.setExtraHTTPHeaders", params}
  end

  @doc """
  Specifies whether to attach a page script stack id in requests
  ## Parameters:
    - (Required) `enabled`: Whether to attach a page script stack for debugging purpose.
  """
  @spec set_attach_debug_stack(boolean()) :: {String.t(), map()}
  def set_attach_debug_stack(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Network.setAttachDebugStack", params}
  end

  @doc """
  Sets the requests to intercept that match the provided patterns and optionally resource types.
  Deprecated, please use Fetch.enable instead.
  ## Parameters:
    - (Required) `patterns`: Requests matching any of these patterns will be forwarded and wait for the corresponding
  continueInterceptedRequest call.
  """
  @spec set_request_interception(list(CDPotion.Domain.Network.RequestPattern)) ::
          {String.t(), map()}
  def set_request_interception(patterns) do
    params = as_query([{"patterns", patterns}])
    {"Network.setRequestInterception", params}
  end

  @doc """
  Allows overriding user agent with the given string.
  ## Parameters:
    - (Required) `user_agent`: User agent to use.
  - (Optional) `accept_language`: Browser langugage to emulate.
  - (Optional) `platform`: The platform navigator.platform should return.
  - (Optional) `user_agent_metadata`: To be sent in Sec-CH-UA-* headers and returned in navigator.userAgentData
  """
  @spec set_user_agent_override(
          String.t(),
          String.t(),
          String.t(),
          CDPotion.Domain.Emulation.UserAgentMetadata
        ) :: {String.t(), map()}
  def set_user_agent_override(
        user_agent,
        accept_language \\ nil,
        platform \\ nil,
        user_agent_metadata \\ nil
      ) do
    params =
      as_query([
        {"userAgent", user_agent},
        {"acceptLanguage", accept_language},
        {"platform", platform},
        {"userAgentMetadata", user_agent_metadata}
      ])

    {"Network.setUserAgentOverride", params}
  end

  @doc """
  Returns information about the COEP/COOP isolation status.
  ## Parameters:
    - (Optional) `frame_id`: If no frameId is provided, the status of the target is provided.
  """
  @spec get_security_isolation_status(CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_security_isolation_status(frame_id \\ nil) do
    params = as_query([{"frameId", frame_id}])
    {"Network.getSecurityIsolationStatus", params}
  end

  @doc """
  Enables tracking for the Reporting API, events generated by the Reporting API will now be delivered to the client.
  Enabling triggers 'reportingApiReportAdded' for all existing reports.
  ## Parameters:
    - (Required) `enable`: Whether to enable or disable events for the Reporting API
  """
  @spec enable_reporting_api(boolean()) :: {String.t(), map()}
  def enable_reporting_api(enable) do
    params = as_query([{"enable", enable}])
    {"Network.enableReportingApi", params}
  end

  @doc """
  Fetches the resource and returns the content.
  ## Parameters:
    - (Optional) `frame_id`: Frame id to get the resource for. Mandatory for frame targets, and
  should be omitted for worker targets.
  - (Required) `url`: URL of the resource to get content for.
  - (Required) `options`: Options for the request.
  """
  @spec load_network_resource(
          CDPotion.Domain.Page.FrameId,
          String.t(),
          CDPotion.Domain.Network.LoadNetworkResourceOptions
        ) :: {String.t(), map()}
  def load_network_resource(frame_id \\ nil, url, options) do
    params = as_query([{"frameId", frame_id}, {"url", url}, {"options", options}])
    {"Network.loadNetworkResource", params}
  end
end
