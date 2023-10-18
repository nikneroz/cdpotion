defmodule CDPotion.Domain.Security do
  @doc """
  Disables tracking security state changes.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables tracking security state changes.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enable/disable whether all certificate errors should be ignored.
  ## Parameters:
  - `ignore:boolean`: If true, all certificate errors will be ignored.
  """
  def set_ignore_certificate_errors(ignore) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Handles a certificate error that fired a certificateError event.
  ## Parameters:
  - `eventId:integer`: The ID of the event.
    - `action:CertificateErrorAction`: The action to take on the certificate error.
  """
  def handle_certificate_error(event_id, action) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enable/disable overriding certificate errors. If enabled, all certificate error events need to
  be handled by the DevTools client and should be answered with `handleCertificateError` commands.
  ## Parameters:
  - `override:boolean`: If true, certificate errors will be overridden.
  """
  def set_override_certificate_errors(override) do
    execute(session, :navigate, %{"url" => url})
  end
end
