defmodule CDPotion.Domain.Security do
  use CDPotion.Utils

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
