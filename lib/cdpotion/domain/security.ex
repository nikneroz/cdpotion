defmodule CDPotion.Domain.Security do
  use CDPotion.Utils

  @typedoc "The action to take when a certificate error occurs. continue will continue processing the
request and cancel will cancel the request."
  @type certificate_error_action :: :continue | :cancel

  @typedoc "An internal certificate ID value."
  @type certificate_id :: integer()

  @typedoc "Details about the security state of the page certificate."
  @type certificate_security_state :: %{
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
          validFrom: CDPotion.Domain.Network.time_since_epoch(),
          validTo: CDPotion.Domain.Network.time_since_epoch()
        }

  @typedoc "Information about insecure content on the page."
  @type insecure_content_status :: %{
          containedMixedForm: boolean(),
          displayedContentWithCertErrors: boolean(),
          displayedInsecureContentStyle: CDPotion.Domain.Security.security_state(),
          displayedMixedContent: boolean(),
          ranContentWithCertErrors: boolean(),
          ranInsecureContentStyle: CDPotion.Domain.Security.security_state(),
          ranMixedContent: boolean()
        }

  @typedoc "A description of mixed content (HTTP resources on HTTPS pages), as defined by
https://www.w3.org/TR/mixed-content/#categories"
  @type mixed_content_type :: :blockable | :"optionally-blockable" | :none

  @typedoc "description not provided :("
  @type safety_tip_info :: %{
          safeUrl: String.t() | nil,
          safetyTipStatus: CDPotion.Domain.Security.safety_tip_status()
        }

  @typedoc "description not provided :("
  @type safety_tip_status :: :badReputation | :lookalike

  @typedoc "The security level of a page or resource."
  @type security_state :: :unknown | :neutral | :insecure | :secure | :info | :"insecure-broken"

  @typedoc "An explanation of an factor contributing to the security state."
  @type security_state_explanation :: %{
          certificate: list(String.t()),
          description: String.t(),
          mixedContentType: CDPotion.Domain.Security.mixed_content_type(),
          recommendations: list(String.t()) | nil,
          securityState: CDPotion.Domain.Security.security_state(),
          summary: String.t(),
          title: String.t()
        }

  @typedoc "Security state information about the page."
  @type visible_security_state :: %{
          certificateSecurityState: CDPotion.Domain.Security.certificate_security_state() | nil,
          safetyTipInfo: CDPotion.Domain.Security.safety_tip_info() | nil,
          securityState: CDPotion.Domain.Security.security_state(),
          securityStateIssueIds: list(String.t())
        }

  @doc """
  Disables tracking security state changes.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Security.disable", %{}}
  end

  @doc """
  Enables tracking security state changes.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Security.enable", %{}}
  end

  @doc """
  Enable/disable whether all certificate errors should be ignored.
  ## Parameters:
    - `ignore`:If true, all certificate errors will be ignored.
  """
  @spec set_ignore_certificate_errors(boolean()) :: {String.t(), map()}
  def set_ignore_certificate_errors(ignore) do
    params = as_query([{"ignore", ignore}])
    {"Security.setIgnoreCertificateErrors", params}
  end

  @doc """
  Handles a certificate error that fired a certificateError event.
  ## Parameters:
    - `event_id`:The ID of the event.
  - `action`:The action to take on the certificate error.
  """
  @spec handle_certificate_error(integer(), CDPotion.Domain.Security.CertificateErrorAction) ::
          {String.t(), map()}
  def handle_certificate_error(event_id, action) do
    params = as_query([{"eventId", event_id}, {"action", action}])
    {"Security.handleCertificateError", params}
  end

  @doc """
  Enable/disable overriding certificate errors. If enabled, all certificate error events need to
  be handled by the DevTools client and should be answered with `handleCertificateError` commands.
  ## Parameters:
    - `override`:If true, certificate errors will be overridden.
  """
  @spec set_override_certificate_errors(boolean()) :: {String.t(), map()}
  def set_override_certificate_errors(override) do
    params = as_query([{"override", override}])
    {"Security.setOverrideCertificateErrors", params}
  end
end
