defmodule CDPotion.Domain.Security do
  use CDPotion.Utils
  @doc "The action to take when a certificate error occurs. continue will continue processing the
request and cancel will cancel the request."
  @type CertificateErrorAction :: :continue | :cancel

  @doc "An internal certificate ID value."
  @type CertificateId :: integer()

  @doc "Details about the security state of the page certificate."
  @type CertificateSecurityState :: %{
          certificate: list(String.t()),
          certificateHasSha1Signature: boolean(),
          certificateHasWeakSignature: boolean(),
          certificateNetworkError: String.t() | nil,
          cipher: String.t(),
          issuer: String.t(),
          keyExchange: String.t(),
          keyExchangeGroup: String.t() | nil,
          mac: String.t() | nil,
          modernSSL: boolean(),
          obsoleteSslCipher: boolean(),
          obsoleteSslKeyExchange: boolean(),
          obsoleteSslProtocol: boolean(),
          obsoleteSslSignature: boolean(),
          protocol: String.t(),
          subjectName: String.t(),
          validFrom: Network.TimeSinceEpoch,
          validTo: Network.TimeSinceEpoch
        }

  @doc "Information about insecure content on the page."
  @type InsecureContentStatus :: %{
          containedMixedForm: boolean(),
          displayedContentWithCertErrors: boolean(),
          displayedInsecureContentStyle: Security.SecurityState,
          displayedMixedContent: boolean(),
          ranContentWithCertErrors: boolean(),
          ranInsecureContentStyle: Security.SecurityState,
          ranMixedContent: boolean()
        }

  @doc "A description of mixed content (HTTP resources on HTTPS pages), as defined by
https://www.w3.org/TR/mixed-content/#categories"
  @type MixedContentType :: :blockable | :"optionally-blockable" | :none

  @doc "description not provided :("
  @type SafetyTipInfo :: %{
          safeUrl: String.t() | nil,
          safetyTipStatus: Security.SafetyTipStatus
        }

  @doc "description not provided :("
  @type SafetyTipStatus :: :badReputation | :lookalike

  @doc "The security level of a page or resource."
  @type SecurityState :: :unknown | :neutral | :insecure | :secure | :info | :"insecure-broken"

  @doc "An explanation of an factor contributing to the security state."
  @type SecurityStateExplanation :: %{
          certificate: list(String.t()),
          description: String.t(),
          mixedContentType: Security.MixedContentType,
          recommendations: list(String.t()) | nil,
          securityState: Security.SecurityState,
          summary: String.t(),
          title: String.t()
        }

  @doc "Security state information about the page."
  @type VisibleSecurityState :: %{
          certificateSecurityState: Security.CertificateSecurityState | nil,
          safetyTipInfo: Security.SafetyTipInfo | nil,
          securityState: Security.SecurityState,
          securityStateIssueIds: list(String.t())
        }

  @doc """
  Disables tracking security state changes.
  """
  def disable() do
    {"Security.disable", %{}}
  end

  @doc """
  Enables tracking security state changes.
  """
  def enable() do
    {"Security.enable", %{}}
  end

  @doc """
  Enable/disable whether all certificate errors should be ignored.
  ## Parameters:
    - `ignore:boolean`: If true, all certificate errors will be ignored.
  """
  def set_ignore_certificate_errors(ignore) do
    params = as_query([{"ignore", ignore}])
    {"Security.setIgnoreCertificateErrors", params}
  end

  @doc """
  Handles a certificate error that fired a certificateError event.
  ## Parameters:
    - `eventId:integer`: The ID of the event.
    - `action:CertificateErrorAction`: The action to take on the certificate error.
  """
  def handle_certificate_error(event_id, action) do
    params = as_query([{"eventId", event_id}, {"action", action}])
    {"Security.handleCertificateError", params}
  end

  @doc """
  Enable/disable overriding certificate errors. If enabled, all certificate error events need to
  be handled by the DevTools client and should be answered with `handleCertificateError` commands.
  ## Parameters:
    - `override:boolean`: If true, certificate errors will be overridden.
  """
  def set_override_certificate_errors(override) do
    params = as_query([{"override", override}])
    {"Security.setOverrideCertificateErrors", params}
  end
end
