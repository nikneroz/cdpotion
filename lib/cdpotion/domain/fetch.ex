defmodule CDPotion.Domain.Fetch do
  use CDPotion.Utils
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

  @typedoc "Response HTTP header entry"
  @type header_entry :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "Unique request identifier."
  @type request_id :: String.t()

  @typedoc "description not provided :("
  @type request_pattern :: %{
          requestStage: CDPotion.Domain.Fetch.request_stage() | nil,
          resourceType: CDPotion.Domain.Network.resource_type() | nil,
          urlPattern: String.t() | nil
        }

  @typedoc "Stages of the request to handle. Request will intercept before the request is
sent. Response will intercept after the response is received (but before response
body is received)."
  @type request_stage :: :Request | :Response

  @doc """
  Disables the fetch domain.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Fetch.disable", %{}}
  end

  @doc """
  Enables issuing of requestPaused events. A request will be paused until client
  calls one of failRequest, fulfillRequest or continueRequest/continueWithAuth.
  ## Parameters:
    - (Optional) `patterns`: If specified, only requests matching any of these patterns will produce
  fetchRequested event and will be paused until clients response. If not set,
  all requests will be affected.
  - (Optional) `handle_auth_requests`: If true, authRequired events will be issued and requests will be paused
  expecting a call to continueWithAuth.
  """
  @spec enable(list(CDPotion.Domain.Fetch.RequestPattern), boolean()) :: {String.t(), map()}
  def enable(patterns \\ nil, handle_auth_requests \\ nil) do
    params = as_query([{"patterns", patterns}, {"handleAuthRequests", handle_auth_requests}])
    {"Fetch.enable", params}
  end

  @doc """
  Causes the request to fail with specified reason.
  ## Parameters:
    - (Required) `request_id`: An id the client received in requestPaused event.
  - (Required) `error_reason`: Causes the request to fail with the given reason.
  """
  @spec fail_request(CDPotion.Domain.Fetch.RequestId, CDPotion.Domain.Network.ErrorReason) ::
          {String.t(), map()}
  def fail_request(request_id, error_reason) do
    params = as_query([{"requestId", request_id}, {"errorReason", error_reason}])
    {"Fetch.failRequest", params}
  end

  @doc """
  Provides response to the request.
  ## Parameters:
    - (Required) `request_id`: An id the client received in requestPaused event.
  - (Required) `response_code`: An HTTP response code.
  - (Optional) `response_headers`: Response headers.
  - (Optional) `binary_response_headers`: Alternative way of specifying response headers as a \0-separated
  series of name: value pairs. Prefer the above method unless you
  need to represent some non-UTF8 values that can't be transmitted
  over the protocol as text. (Encoded as a base64 string when passed over JSON)
  - (Optional) `body`: A response body. If absent, original response body will be used if
  the request is intercepted at the response stage and empty body
  will be used if the request is intercepted at the request stage. (Encoded as a base64 string when passed over JSON)
  - (Optional) `response_phrase`: A textual representation of responseCode.
  If absent, a standard phrase matching responseCode is used.
  """
  @spec fulfill_request(
          CDPotion.Domain.Fetch.RequestId,
          integer(),
          list(CDPotion.Domain.Fetch.HeaderEntry),
          String.t(),
          String.t(),
          String.t()
        ) :: {String.t(), map()}
  def fulfill_request(
        request_id,
        response_code,
        response_headers \\ nil,
        binary_response_headers \\ nil,
        body \\ nil,
        response_phrase \\ nil
      ) do
    params =
      as_query([
        {"requestId", request_id},
        {"responseCode", response_code},
        {"responseHeaders", response_headers},
        {"binaryResponseHeaders", binary_response_headers},
        {"body", body},
        {"responsePhrase", response_phrase}
      ])

    {"Fetch.fulfillRequest", params}
  end

  @doc """
  Continues the request, optionally modifying some of its parameters.
  ## Parameters:
    - (Required) `request_id`: An id the client received in requestPaused event.
  - (Optional) `url`: If set, the request url will be modified in a way that's not observable by page.
  - (Optional) `method`: If set, the request method is overridden.
  - (Optional) `post_data`: If set, overrides the post data in the request. (Encoded as a base64 string when passed over JSON)
  - (Optional) `headers`: If set, overrides the request headers. Note that the overrides do not
  extend to subsequent redirect hops, if a redirect happens. Another override
  may be applied to a different request produced by a redirect.
  - (Optional) `intercept_response`: If set, overrides response interception behavior for this request.
  """
  @spec continue_request(
          CDPotion.Domain.Fetch.RequestId,
          String.t(),
          String.t(),
          String.t(),
          list(CDPotion.Domain.Fetch.HeaderEntry),
          boolean()
        ) :: {String.t(), map()}
  def continue_request(
        request_id,
        url \\ nil,
        method \\ nil,
        post_data \\ nil,
        headers \\ nil,
        intercept_response \\ nil
      ) do
    params =
      as_query([
        {"requestId", request_id},
        {"url", url},
        {"method", method},
        {"postData", post_data},
        {"headers", headers},
        {"interceptResponse", intercept_response}
      ])

    {"Fetch.continueRequest", params}
  end

  @doc """
  Continues a request supplying authChallengeResponse following authRequired event.
  ## Parameters:
    - (Required) `request_id`: An id the client received in authRequired event.
  - (Required) `auth_challenge_response`: Response to  with an authChallenge.
  """
  @spec continue_with_auth(
          CDPotion.Domain.Fetch.RequestId,
          CDPotion.Domain.Fetch.AuthChallengeResponse
        ) :: {String.t(), map()}
  def continue_with_auth(request_id, auth_challenge_response) do
    params =
      as_query([{"requestId", request_id}, {"authChallengeResponse", auth_challenge_response}])

    {"Fetch.continueWithAuth", params}
  end

  @doc """
  Continues loading of the paused response, optionally modifying the
  response headers. If either responseCode or headers are modified, all of them
  must be present.
  ## Parameters:
    - (Required) `request_id`: An id the client received in requestPaused event.
  - (Optional) `response_code`: An HTTP response code. If absent, original response code will be used.
  - (Optional) `response_phrase`: A textual representation of responseCode.
  If absent, a standard phrase matching responseCode is used.
  - (Optional) `response_headers`: Response headers. If absent, original response headers will be used.
  - (Optional) `binary_response_headers`: Alternative way of specifying response headers as a \0-separated
  series of name: value pairs. Prefer the above method unless you
  need to represent some non-UTF8 values that can't be transmitted
  over the protocol as text. (Encoded as a base64 string when passed over JSON)
  """
  @spec continue_response(
          CDPotion.Domain.Fetch.RequestId,
          integer(),
          String.t(),
          list(CDPotion.Domain.Fetch.HeaderEntry),
          String.t()
        ) :: {String.t(), map()}
  def continue_response(
        request_id,
        response_code \\ nil,
        response_phrase \\ nil,
        response_headers \\ nil,
        binary_response_headers \\ nil
      ) do
    params =
      as_query([
        {"requestId", request_id},
        {"responseCode", response_code},
        {"responsePhrase", response_phrase},
        {"responseHeaders", response_headers},
        {"binaryResponseHeaders", binary_response_headers}
      ])

    {"Fetch.continueResponse", params}
  end

  @doc """
  Causes the body of the response to be received from the server and
  returned as a single string. May only be issued for a request that
  is paused in the Response stage and is mutually exclusive with
  takeResponseBodyForInterceptionAsStream. Calling other methods that
  affect the request or disabling fetch domain before body is received
  results in an undefined behavior.
  Note that the response body is not available for redirects. Requests
  paused in the _redirect received_ state may be differentiated by
  `responseCode` and presence of `location` response header, see
  comments to `requestPaused` for details.
  ## Parameters:
    - (Required) `request_id`: Identifier for the intercepted request to get body for.
  """
  @spec get_response_body(CDPotion.Domain.Fetch.RequestId) :: {String.t(), map()}
  def get_response_body(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Fetch.getResponseBody", params}
  end

  @doc """
  Returns a handle to the stream representing the response body.
  The request must be paused in the HeadersReceived stage.
  Note that after this command the request can't be continued
  as is -- client either needs to cancel it or to provide the
  response body.
  The stream only supports sequential read, IO.read will fail if the position
  is specified.
  This method is mutually exclusive with getResponseBody.
  Calling other methods that affect the request or disabling fetch
  domain before body is received results in an undefined behavior.
  ## Parameters:
    - (Required) `request_id`: description not provided :(
  """
  @spec take_response_body_as_stream(CDPotion.Domain.Fetch.RequestId) :: {String.t(), map()}
  def take_response_body_as_stream(request_id) do
    params = as_query([{"requestId", request_id}])
    {"Fetch.takeResponseBodyAsStream", params}
  end
end
