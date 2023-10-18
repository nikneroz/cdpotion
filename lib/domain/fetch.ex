defmodule CDPotion.Domain.Fetch do

@doc """
Disables the fetch domain.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables issuing of requestPaused events. A request will be paused until client
calls one of failRequest, fulfillRequest or continueRequest/continueWithAuth.
## Parameters:
  - `patterns:array`: (Optional) If specified, only requests matching any of these patterns will produce
fetchRequested event and will be paused until clients response. If not set,
all requests will be affected.
  - `handleAuthRequests:boolean`: (Optional) If true, authRequired events will be issued and requests will be paused
expecting a call to continueWithAuth.
"""
def enable(patterns \\ nil, handle_auth_requests \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Causes the request to fail with specified reason.
## Parameters:
  - `requestId:RequestId`: An id the client received in requestPaused event.
  - `errorReason:Network.ErrorReason`: Causes the request to fail with the given reason.
"""
def fail_request(request_id, error_reason) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Provides response to the request.
## Parameters:
  - `requestId:RequestId`: An id the client received in requestPaused event.
  - `responseCode:integer`: An HTTP response code.
  - `responseHeaders:array`: (Optional) Response headers.
  - `binaryResponseHeaders:string`: (Optional) Alternative way of specifying response headers as a \0-separated
series of name: value pairs. Prefer the above method unless you
need to represent some non-UTF8 values that can't be transmitted
over the protocol as text. (Encoded as a base64 string when passed over JSON)
  - `body:string`: (Optional) A response body. If absent, original response body will be used if
the request is intercepted at the response stage and empty body
will be used if the request is intercepted at the request stage. (Encoded as a base64 string when passed over JSON)
  - `responsePhrase:string`: (Optional) A textual representation of responseCode.
If absent, a standard phrase matching responseCode is used.
"""
def fulfill_request(
      request_id,
      response_code,
      response_headers \\ nil,
      binary_response_headers \\ nil,
      body \\ nil,
      response_phrase \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Continues the request, optionally modifying some of its parameters.
## Parameters:
  - `requestId:RequestId`: An id the client received in requestPaused event.
  - `url:string`: (Optional) If set, the request url will be modified in a way that's not observable by page.
  - `method:string`: (Optional) If set, the request method is overridden.
  - `postData:string`: (Optional) If set, overrides the post data in the request. (Encoded as a base64 string when passed over JSON)
  - `headers:array`: (Optional) If set, overrides the request headers. Note that the overrides do not
extend to subsequent redirect hops, if a redirect happens. Another override
may be applied to a different request produced by a redirect.
  - `interceptResponse:boolean`: (Optional) If set, overrides response interception behavior for this request.
"""
def continue_request(
      request_id,
      url \\ nil,
      method \\ nil,
      post_data \\ nil,
      headers \\ nil,
      intercept_response \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Continues a request supplying authChallengeResponse following authRequired event.
## Parameters:
  - `requestId:RequestId`: An id the client received in authRequired event.
  - `authChallengeResponse:AuthChallengeResponse`: Response to  with an authChallenge.
"""
def continue_with_auth(request_id, auth_challenge_response) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Continues loading of the paused response, optionally modifying the
response headers. If either responseCode or headers are modified, all of them
must be present.
## Parameters:
  - `requestId:RequestId`: An id the client received in requestPaused event.
  - `responseCode:integer`: (Optional) An HTTP response code. If absent, original response code will be used.
  - `responsePhrase:string`: (Optional) A textual representation of responseCode.
If absent, a standard phrase matching responseCode is used.
  - `responseHeaders:array`: (Optional) Response headers. If absent, original response headers will be used.
  - `binaryResponseHeaders:string`: (Optional) Alternative way of specifying response headers as a \0-separated
series of name: value pairs. Prefer the above method unless you
need to represent some non-UTF8 values that can't be transmitted
over the protocol as text. (Encoded as a base64 string when passed over JSON)
"""
def continue_response(
      request_id,
      response_code \\ nil,
      response_phrase \\ nil,
      response_headers \\ nil,
      binary_response_headers \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
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
  - `requestId:RequestId`: Identifier for the intercepted request to get body for.
"""
def get_response_body(request_id) do
  execute(session, :navigate, %{"url" => url})
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
  - `requestId:RequestId`: description not provided :(
"""
def take_response_body_as_stream(request_id) do
  execute(session, :navigate, %{"url" => url})
end
end