defmodule CDPotion.Domain.Network do
  use CDPotion.Utils
  @doc "The reason why Chrome uses a specific transport protocol for HTTP semantics."
  @type AlternateProtocolUsage ::
          :alternativeJobWonWithoutRace
          | :alternativeJobWonRace
          | :mainJobWonRace
          | :mappingMissing
          | :broken
          | :dnsAlpnH3JobWonWithoutRace
          | :dnsAlpnH3JobWonRace
          | :unspecifiedReason

  @doc "Authorization challenge for HTTP status code 401 or 407."
  @type AuthChallenge :: %{
          origin: String.t(),
          realm: String.t(),
          scheme: String.t(),
          source: :Server | :Proxy | nil
        }

  @doc "Response to an AuthChallenge."
  @type AuthChallengeResponse :: %{
          password: String.t() | nil,
          response: :Default | :CancelAuth | :ProvideCredentials,
          username: String.t() | nil
        }

  @doc "A cookie with was not sent with a request with the corresponding reason."
  @type BlockedCookieWithReason :: %{
          blockedReasons: list(Network.CookieBlockedReason),
          cookie: Network.Cookie
        }

  @doc "The reason why request was blocked."
  @type BlockedReason ::
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

  @doc "A cookie which was not stored from a response with the corresponding reason."
  @type BlockedSetCookieWithReason :: %{
          blockedReasons: list(Network.SetCookieBlockedReason),
          cookie: Network.Cookie | nil,
          cookieLine: String.t()
        }

  @doc "Information about the cached resource."
  @type CachedResource :: %{
          bodySize: number(),
          response: Network.Response | nil,
          type: Network.ResourceType,
          url: String.t()
        }

  @doc "Whether the request complied with Certificate Transparency policy."
  @type CertificateTransparencyCompliance :: :unknown | :"not-compliant" | :compliant

  @doc "description not provided :("
  @type ClientSecurityState :: %{
          initiatorIPAddressSpace: Network.IPAddressSpace,
          initiatorIsSecureContext: boolean(),
          privateNetworkRequestPolicy: Network.PrivateNetworkRequestPolicy
        }

  @doc "description not provided :("
  @type ConnectTiming :: %{
          requestTime: number()
        }

  @doc "The underlying connection technology that the browser is supposedly using."
  @type ConnectionType ::
          :none
          | :cellular2g
          | :cellular3g
          | :cellular4g
          | :bluetooth
          | :ethernet
          | :wifi
          | :wimax
          | :other

  @doc "List of content encodings supported by the backend."
  @type ContentEncoding :: :deflate | :gzip | :br | :zstd

  @doc "description not provided :("
  @type ContentSecurityPolicySource :: :HTTP | :Meta

  @doc "description not provided :("
  @type ContentSecurityPolicyStatus :: %{
          effectiveDirectives: String.t(),
          isEnforced: boolean(),
          source: Network.ContentSecurityPolicySource
        }

  @doc "Cookie object"
  @type Cookie :: %{
          domain: String.t(),
          expires: number(),
          httpOnly: boolean(),
          name: String.t(),
          partitionKey: String.t() | nil,
          partitionKeyOpaque: boolean() | nil,
          path: String.t(),
          priority: Network.CookiePriority,
          sameParty: boolean(),
          sameSite: Network.CookieSameSite | nil,
          secure: boolean(),
          session: boolean(),
          size: integer(),
          sourcePort: integer(),
          sourceScheme: Network.CookieSourceScheme,
          value: String.t()
        }

  @doc "Types of reasons why a cookie may not be sent with a request."
  @type CookieBlockedReason ::
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

  @doc "Cookie parameter object"
  @type CookieParam :: %{
          domain: String.t() | nil,
          expires: Network.TimeSinceEpoch | nil,
          httpOnly: boolean() | nil,
          name: String.t(),
          partitionKey: String.t() | nil,
          path: String.t() | nil,
          priority: Network.CookiePriority | nil,
          sameParty: boolean() | nil,
          sameSite: Network.CookieSameSite | nil,
          secure: boolean() | nil,
          sourcePort: integer() | nil,
          sourceScheme: Network.CookieSourceScheme | nil,
          url: String.t() | nil,
          value: String.t()
        }

  @doc "Represents the cookie's 'Priority' status:
https://tools.ietf.org/html/draft-west-cookie-priority-00"
  @type CookiePriority :: :Low | :Medium | :High

  @doc "Represents the cookie's 'SameSite' status:
https://tools.ietf.org/html/draft-west-first-party-cookies"
  @type CookieSameSite :: :Strict | :Lax | :None

  @doc "Represents the source scheme of the origin that originally set the cookie.
A value of 'Unset' allows protocol clients to emulate legacy cookie scope for the scheme.
This is a temporary ability and it will be removed in the future."
  @type CookieSourceScheme :: :Unset | :NonSecure | :Secure

  @doc "The reason why request was blocked."
  @type CorsError ::
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

  @doc "description not provided :("
  @type CorsErrorStatus :: %{
          corsError: Network.CorsError,
          failedParameter: String.t()
        }

  @doc "description not provided :("
  @type CrossOriginEmbedderPolicyStatus :: %{
          reportOnlyReportingEndpoint: String.t() | nil,
          reportOnlyValue: Network.CrossOriginEmbedderPolicyValue,
          reportingEndpoint: String.t() | nil,
          value: Network.CrossOriginEmbedderPolicyValue
        }

  @doc "description not provided :("
  @type CrossOriginEmbedderPolicyValue :: :None | :Credentialless | :RequireCorp

  @doc "description not provided :("
  @type CrossOriginOpenerPolicyStatus :: %{
          reportOnlyReportingEndpoint: String.t() | nil,
          reportOnlyValue: Network.CrossOriginOpenerPolicyValue,
          reportingEndpoint: String.t() | nil,
          value: Network.CrossOriginOpenerPolicyValue
        }

  @doc "description not provided :("
  @type CrossOriginOpenerPolicyValue ::
          :SameOrigin
          | :SameOriginAllowPopups
          | :RestrictProperties
          | :UnsafeNone
          | :SameOriginPlusCoep
          | :RestrictPropertiesPlusCoep

  @doc "Network level fetch failure reason."
  @type ErrorReason ::
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

  @doc "Request / response headers as keys / values of JSON object."
  @type Headers :: map()

  @doc "description not provided :("
  @type IPAddressSpace :: :Local | :Private | :Public | :Unknown

  @doc "Information about the request initiator."
  @type Initiator :: %{
          columnNumber: number() | nil,
          lineNumber: number() | nil,
          requestId: Network.RequestId | nil,
          stack: Runtime.StackTrace | nil,
          type: :parser | :script | :preload | :SignedExchange | :preflight | :other,
          url: String.t() | nil
        }

  @doc "Unique intercepted request identifier."
  @type InterceptionId :: String.t()

  @doc "Stages of the interception to begin intercepting. Request will intercept before the request is
sent. Response will intercept after the response is received."
  @type InterceptionStage :: :Request | :HeadersReceived

  @doc "An options object that may be extended later to better support CORS,
CORB and streaming."
  @type LoadNetworkResourceOptions :: %{
          disableCache: boolean(),
          includeCredentials: boolean()
        }

  @doc "An object providing the result of a network resource load."
  @type LoadNetworkResourcePageResult :: %{
          headers: Network.Headers | nil,
          httpStatusCode: number() | nil,
          netError: number() | nil,
          netErrorName: String.t() | nil,
          stream: IO.StreamHandle | nil,
          success: boolean()
        }

  @doc "Unique loader identifier."
  @type LoaderId :: String.t()

  @doc "Monotonically increasing time in seconds since an arbitrary point in the past."
  @type MonotonicTime :: number()

  @doc "Post data entry for HTTP request"
  @type PostDataEntry :: %{
          bytes: String.t() | nil
        }

  @doc "description not provided :("
  @type PrivateNetworkRequestPolicy ::
          :Allow
          | :BlockFromInsecureToMorePrivate
          | :WarnFromInsecureToMorePrivate
          | :PreflightBlock
          | :PreflightWarn

  @doc "description not provided :("
  @type ReportId :: String.t()

  @doc "The status of a Reporting API report."
  @type ReportStatus :: :Queued | :Pending | :MarkedForRemoval | :Success

  @doc "description not provided :("
  @type ReportingApiEndpoint :: %{
          groupName: String.t(),
          url: String.t()
        }

  @doc "An object representing a report generated by the Reporting API."
  @type ReportingApiReport :: %{
          body: map(),
          completedAttempts: integer(),
          depth: integer(),
          destination: String.t(),
          id: Network.ReportId,
          initiatorUrl: String.t(),
          status: Network.ReportStatus,
          timestamp: Network.TimeSinceEpoch,
          type: String.t()
        }

  @doc "HTTP request data."
  @type Request :: %{
          hasPostData: boolean() | nil,
          headers: Network.Headers,
          initialPriority: Network.ResourcePriority,
          isLinkPreload: boolean() | nil,
          isSameSite: boolean() | nil,
          method: String.t(),
          mixedContentType: Security.MixedContentType | nil,
          postData: String.t() | nil,
          postDataEntries: list(Network.PostDataEntry) | nil,
          referrerPolicy:
            :"unsafe-url"
            | :"no-referrer-when-downgrade"
            | :"no-referrer"
            | :origin
            | :"origin-when-cross-origin"
            | :"same-origin"
            | :"strict-origin"
            | :"strict-origin-when-cross-origin",
          trustTokenParams: Network.TrustTokenParams | nil,
          url: String.t(),
          urlFragment: String.t() | nil
        }

  @doc "Unique request identifier."
  @type RequestId :: String.t()

  @doc "Request pattern for interception."
  @type RequestPattern :: %{
          interceptionStage: Network.InterceptionStage | nil,
          resourceType: Network.ResourceType | nil,
          urlPattern: String.t() | nil
        }

  @doc "Loading priority of a resource request."
  @type ResourcePriority :: :VeryLow | :Low | :Medium | :High | :VeryHigh

  @doc "Timing information for the request."
  @type ResourceTiming :: %{
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

  @doc "Resource type as it was perceived by the rendering engine."
  @type ResourceType ::
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

  @doc "HTTP response data."
  @type Response :: %{
          alternateProtocolUsage: Network.AlternateProtocolUsage | nil,
          cacheStorageCacheName: String.t() | nil,
          connectionId: number(),
          connectionReused: boolean(),
          encodedDataLength: number(),
          fromDiskCache: boolean() | nil,
          fromPrefetchCache: boolean() | nil,
          fromServiceWorker: boolean() | nil,
          headers: Network.Headers,
          headersText: String.t() | nil,
          mimeType: String.t(),
          protocol: String.t() | nil,
          remoteIPAddress: String.t() | nil,
          remotePort: integer() | nil,
          requestHeaders: Network.Headers | nil,
          requestHeadersText: String.t() | nil,
          responseTime: Network.TimeSinceEpoch | nil,
          securityDetails: Network.SecurityDetails | nil,
          securityState: Security.SecurityState,
          serviceWorkerResponseSource: Network.ServiceWorkerResponseSource | nil,
          status: integer(),
          statusText: String.t(),
          timing: Network.ResourceTiming | nil,
          url: String.t()
        }

  @doc "Security details about a request."
  @type SecurityDetails :: %{
          certificateId: Security.CertificateId,
          certificateTransparencyCompliance: Network.CertificateTransparencyCompliance,
          cipher: String.t(),
          encryptedClientHello: boolean(),
          issuer: String.t(),
          keyExchange: String.t(),
          keyExchangeGroup: String.t() | nil,
          mac: String.t() | nil,
          protocol: String.t(),
          sanList: list(String.t()),
          serverSignatureAlgorithm: integer() | nil,
          signedCertificateTimestampList: list(Network.SignedCertificateTimestamp),
          subjectName: String.t(),
          validFrom: Network.TimeSinceEpoch,
          validTo: Network.TimeSinceEpoch
        }

  @doc "description not provided :("
  @type SecurityIsolationStatus :: %{
          coep: Network.CrossOriginEmbedderPolicyStatus | nil,
          coop: Network.CrossOriginOpenerPolicyStatus | nil,
          csp: list(Network.ContentSecurityPolicyStatus) | nil
        }

  @doc "Source of serviceworker response."
  @type ServiceWorkerResponseSource ::
          :"cache-storage" | :"http-cache" | :"fallback-code" | :network

  @doc "Types of reasons why a cookie may not be stored from a response."
  @type SetCookieBlockedReason ::
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

  @doc "Details of a signed certificate timestamp (SCT)."
  @type SignedCertificateTimestamp :: %{
          hashAlgorithm: String.t(),
          logDescription: String.t(),
          logId: String.t(),
          origin: String.t(),
          signatureAlgorithm: String.t(),
          signatureData: String.t(),
          status: String.t(),
          timestamp: number()
        }

  @doc "Information about a signed exchange response."
  @type SignedExchangeError :: %{
          errorField: Network.SignedExchangeErrorField | nil,
          message: String.t(),
          signatureIndex: integer() | nil
        }

  @doc "Field type for a signed exchange related error."
  @type SignedExchangeErrorField ::
          :signatureSig
          | :signatureIntegrity
          | :signatureCertUrl
          | :signatureCertSha256
          | :signatureValidityUrl
          | :signatureTimestamps

  @doc "Information about a signed exchange header.
https://wicg.github.io/webpackage/draft-yasskin-httpbis-origin-signed-exchanges-impl.html#cbor-representation"
  @type SignedExchangeHeader :: %{
          headerIntegrity: String.t(),
          requestUrl: String.t(),
          responseCode: integer(),
          responseHeaders: Network.Headers,
          signatures: list(Network.SignedExchangeSignature)
        }

  @doc "Information about a signed exchange response."
  @type SignedExchangeInfo :: %{
          errors: list(Network.SignedExchangeError) | nil,
          header: Network.SignedExchangeHeader | nil,
          outerResponse: Network.Response,
          securityDetails: Network.SecurityDetails | nil
        }

  @doc "Information about a signed exchange signature.
https://wicg.github.io/webpackage/draft-yasskin-httpbis-origin-signed-exchanges-impl.html#rfc.section.3.1"
  @type SignedExchangeSignature :: %{
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

  @doc "UTC time in seconds, counted from January 1, 1970."
  @type TimeSinceEpoch :: number()

  @doc "description not provided :("
  @type TrustTokenOperationType :: :Issuance | :Redemption | :Signing

  @doc "Determines what type of Trust Token operation is executed and
depending on the type, some additional parameters. The values
are specified in third_party/blink/renderer/core/fetch/trust_token.idl."
  @type TrustTokenParams :: %{
          issuers: list(String.t()) | nil,
          operation: Network.TrustTokenOperationType,
          refreshPolicy: :UseCached | :Refresh
        }

  @doc "WebSocket message data. This represents an entire WebSocket message, not just a fragmented frame as the name suggests."
  @type WebSocketFrame :: %{
          mask: boolean(),
          opcode: number(),
          payloadData: String.t()
        }

  @doc "WebSocket request data."
  @type WebSocketRequest :: %{
          headers: Network.Headers
        }

  @doc "WebSocket response data."
  @type WebSocketResponse :: %{
          headers: Network.Headers,
          headersText: String.t() | nil,
          requestHeaders: Network.Headers | nil,
          requestHeadersText: String.t() | nil,
          status: integer(),
          statusText: String.t()
        }

  @doc """
  Sets a list of content encodings that will be accepted. Empty list means no encoding is accepted.
  ## Parameters:
    - `encodings:array`: List of accepted content encodings.
  """
  def set_accepted_encodings(encodings) do
    params = as_query([{"encodings", encodings}])
    {"Network.setAcceptedEncodings", params}
  end

  @doc """
  Clears accepted encodings set by setAcceptedEncodings
  """
  def clear_accepted_encodings_override() do
    {"Network.clearAcceptedEncodingsOverride", %{}}
  end

  @doc """
  Tells whether clearing browser cache is supported.
  """
  def can_clear_browser_cache() do
    {"Network.canClearBrowserCache", %{}}
  end

  @doc """
  Tells whether clearing browser cookies is supported.
  """
  def can_clear_browser_cookies() do
    {"Network.canClearBrowserCookies", %{}}
  end

  @doc """
  Tells whether emulation of network conditions is supported.
  """
  def can_emulate_network_conditions() do
    {"Network.canEmulateNetworkConditions", %{}}
  end

  @doc """
  Clears browser cache.
  """
  def clear_browser_cache() do
    {"Network.clearBrowserCache", %{}}
  end

  @doc """
  Clears browser cookies.
  """
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
    - `interceptionId:InterceptionId`: description not provided :(
    - `errorReason:ErrorReason`: (Optional) If set this causes the request to fail with the given reason. Passing `Aborted` for requests
  marked with `isNavigationRequest` also cancels the navigation. Must not be set in response
  to an authChallenge.
    - `rawResponse:string`: (Optional) If set the requests completes using with the provided base64 encoded raw response, including
  HTTP status line and headers etc... Must not be set in response to an authChallenge. (Encoded as a base64 string when passed over JSON)
    - `url:string`: (Optional) If set the request url will be modified in a way that's not observable by page. Must not be
  set in response to an authChallenge.
    - `method:string`: (Optional) If set this allows the request method to be overridden. Must not be set in response to an
  authChallenge.
    - `postData:string`: (Optional) If set this allows postData to be set. Must not be set in response to an authChallenge.
    - `headers:Headers`: (Optional) If set this allows the request headers to be changed. Must not be set in response to an
  authChallenge.
    - `authChallengeResponse:AuthChallengeResponse`: (Optional) Response to a requestIntercepted with an authChallenge. Must not be set otherwise.
  """
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
    - `name:string`: Name of the cookies to remove.
    - `url:string`: (Optional) If specified, deletes all the cookies with the given name where domain and path match
  provided URL.
    - `domain:string`: (Optional) If specified, deletes only cookies with the exact domain.
    - `path:string`: (Optional) If specified, deletes only cookies with the exact path.
  """
  def delete_cookies(name, url \\ nil, domain \\ nil, path \\ nil) do
    params = as_query([{"name", name}, {"url", url}, {"domain", domain}, {"path", path}])
    {"Network.deleteCookies", params}
  end

  @doc """
  Disables network tracking, prevents network events from being sent to the client.
  """
  def disable() do
    {"Network.disable", %{}}
  end

  @doc """
  Activates emulation of network conditions.
  ## Parameters:
    - `offline:boolean`: True to emulate internet disconnection.
    - `latency:number`: Minimum latency from request sent to response headers received (ms).
    - `downloadThroughput:number`: Maximal aggregated download throughput (bytes/sec). -1 disables download throttling.
    - `uploadThroughput:number`: Maximal aggregated upload throughput (bytes/sec).  -1 disables upload throttling.
    - `connectionType:ConnectionType`: (Optional) Connection type if known.
  """
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
    - `maxTotalBufferSize:integer`: (Optional) Buffer size in bytes to use when preserving network payloads (XHRs, etc).
    - `maxResourceBufferSize:integer`: (Optional) Per-resource buffer size in bytes to use when preserving network payloads (XHRs, etc).
    - `maxPostDataSize:integer`: (Optional) Longest post body size (in bytes) that would be included in requestWillBeSent notification
  """
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
  def get_all_cookies() do
    {"Network.getAllCookies", %{}}
  end

  @doc """
  Returns the DER-encoded certificate.
  ## Parameters:
    - `origin:string`: Origin to get certificate for.
  """
  def get_certificate(origin) do
    params = as_query([{"origin", origin}])
    {"Network.getCertificate", params}
  end

  @doc """
  Returns all browser cookies for the current URL. Depending on the backend support, will return
  detailed cookie information in the `cookies` field.
  ## Parameters:
    - `urls:array`: (Optional) The list of URLs for which applicable cookies will be fetched.
  If not specified, it's assumed to be set to the list containing
  the URLs of the page and all of its subframes.
  """
  def get_cookies(urls \\ nil) do
    params = as_query([{"urls", urls}])
    {"Network.getCookies", params}
  end

  @doc """
  Returns content served for the given request.
  ## Parameters:
    - `requestId:RequestId`: Identifier of the network request to get content for.
  """
  def get_response_body(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Network.getResponseBody", params}
  end

  @doc """
  Returns post data sent with the request. Returns an error when no data was sent with the request.
  ## Parameters:
    - `requestId:RequestId`: Identifier of the network request to get content for.
  """
  def get_request_post_data(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Network.getRequestPostData", params}
  end

  @doc """
  Returns content served for the given currently intercepted request.
  ## Parameters:
    - `interceptionId:InterceptionId`: Identifier for the intercepted request to get body for.
  """
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
    - `interceptionId:InterceptionId`: description not provided :(
  """
  def take_response_body_for_interception_as_stream(interception_id) do
    params = as_query([{"interceptionId", interception_id}])
    {"Network.takeResponseBodyForInterceptionAsStream", params}
  end

  @doc """
  This method sends a new XMLHttpRequest which is identical to the original one. The following
  parameters should be identical: method, url, async, request body, extra headers, withCredentials
  attribute, user, password.
  ## Parameters:
    - `requestId:RequestId`: Identifier of XHR to replay.
  """
  def replay_xhr(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Network.replayXHR", params}
  end

  @doc """
  Searches for given string in response content.
  ## Parameters:
    - `requestId:RequestId`: Identifier of the network response to search.
    - `query:string`: String to search for.
    - `caseSensitive:boolean`: (Optional) If true, search is case sensitive.
    - `isRegex:boolean`: (Optional) If true, treats string parameter as regex.
  """
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
    - `urls:array`: URL patterns to block. Wildcards ('*') are allowed.
  """
  def set_blocked_ur_ls(urls) do
    params = as_query([{"urls", urls}])
    {"Network.setBlockedURLs", params}
  end

  @doc """
  Toggles ignoring of service worker for each request.
  ## Parameters:
    - `bypass:boolean`: Bypass service worker and load from network.
  """
  def set_bypass_service_worker(bypass) do
    params = as_query([{"bypass", bypass}])
    {"Network.setBypassServiceWorker", params}
  end

  @doc """
  Toggles ignoring cache for each request. If `true`, cache will not be used.
  ## Parameters:
    - `cacheDisabled:boolean`: Cache disabled state.
  """
  def set_cache_disabled(cache_disabled) do
    params = as_query([{"cacheDisabled", cache_disabled}])
    {"Network.setCacheDisabled", params}
  end

  @doc """
  Sets a cookie with the given cookie data; may overwrite equivalent cookies if they exist.
  ## Parameters:
    - `name:string`: Cookie name.
    - `value:string`: Cookie value.
    - `url:string`: (Optional) The request-URI to associate with the setting of the cookie. This value can affect the
  default domain, path, source port, and source scheme values of the created cookie.
    - `domain:string`: (Optional) Cookie domain.
    - `path:string`: (Optional) Cookie path.
    - `secure:boolean`: (Optional) True if cookie is secure.
    - `httpOnly:boolean`: (Optional) True if cookie is http-only.
    - `sameSite:CookieSameSite`: (Optional) Cookie SameSite type.
    - `expires:TimeSinceEpoch`: (Optional) Cookie expiration date, session cookie if not set
    - `priority:CookiePriority`: (Optional) Cookie Priority type.
    - `sameParty:boolean`: (Optional) True if cookie is SameParty.
    - `sourceScheme:CookieSourceScheme`: (Optional) Cookie source scheme type.
    - `sourcePort:integer`: (Optional) Cookie source port. Valid values are {-1, [1, 65535]}, -1 indicates an unspecified port.
  An unspecified port value allows protocol clients to emulate legacy cookie scope for the port.
  This is a temporary ability and it will be removed in the future.
    - `partitionKey:string`: (Optional) Cookie partition key. The site of the top-level URL the browser was visiting at the start
  of the request to the endpoint that set the cookie.
  If not set, the cookie will be set as not partitioned.
  """
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
    - `cookies:array`: Cookies to be set.
  """
  def set_cookies(cookies) do
    params = as_query([{"cookies", cookies}])
    {"Network.setCookies", params}
  end

  @doc """
  Specifies whether to always send extra HTTP headers with the requests from this page.
  ## Parameters:
    - `headers:Headers`: Map with extra HTTP headers.
  """
  def set_extra_http_headers(headers) do
    params = as_query([{"headers", headers}])
    {"Network.setExtraHTTPHeaders", params}
  end

  @doc """
  Specifies whether to attach a page script stack id in requests
  ## Parameters:
    - `enabled:boolean`: Whether to attach a page script stack for debugging purpose.
  """
  def set_attach_debug_stack(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Network.setAttachDebugStack", params}
  end

  @doc """
  Sets the requests to intercept that match the provided patterns and optionally resource types.
  Deprecated, please use Fetch.enable instead.
  ## Parameters:
    - `patterns:array`: Requests matching any of these patterns will be forwarded and wait for the corresponding
  continueInterceptedRequest call.
  """
  def set_request_interception(patterns) do
    params = as_query([{"patterns", patterns}])
    {"Network.setRequestInterception", params}
  end

  @doc """
  Allows overriding user agent with the given string.
  ## Parameters:
    - `userAgent:string`: User agent to use.
    - `acceptLanguage:string`: (Optional) Browser langugage to emulate.
    - `platform:string`: (Optional) The platform navigator.platform should return.
    - `userAgentMetadata:Emulation.UserAgentMetadata`: (Optional) To be sent in Sec-CH-UA-* headers and returned in navigator.userAgentData
  """
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
    - `frameId:Page.FrameId`: (Optional) If no frameId is provided, the status of the target is provided.
  """
  def get_security_isolation_status(frame_id \\ nil) do
    params = as_query([{"frameId", frame_id}])
    {"Network.getSecurityIsolationStatus", params}
  end

  @doc """
  Enables tracking for the Reporting API, events generated by the Reporting API will now be delivered to the client.
  Enabling triggers 'reportingApiReportAdded' for all existing reports.
  ## Parameters:
    - `enable:boolean`: Whether to enable or disable events for the Reporting API
  """
  def enable_reporting_api(enable) do
    params = as_query([{"enable", enable}])
    {"Network.enableReportingApi", params}
  end

  @doc """
  Fetches the resource and returns the content.
  ## Parameters:
    - `frameId:Page.FrameId`: (Optional) Frame id to get the resource for. Mandatory for frame targets, and
  should be omitted for worker targets.
    - `url:string`: URL of the resource to get content for.
    - `options:LoadNetworkResourceOptions`: Options for the request.
  """
  def load_network_resource(frame_id \\ nil, url, options) do
    params = as_query([{"frameId", frame_id}, {"url", url}, {"options", options}])
    {"Network.loadNetworkResource", params}
  end
end
