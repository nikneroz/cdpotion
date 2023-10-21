defmodule CDPotion.Domain.WebAuthn do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type authenticator_id :: String.t()

  @typedoc "description not provided :("
  @type authenticator_protocol :: :u2f | :ctap2

  @typedoc "description not provided :("
  @type authenticator_transport :: :usb | :nfc | :ble | :cable | :internal

  @typedoc "description not provided :("
  @type credential :: %{
          credentialId: String.t(),
          isResidentCredential: boolean(),
          largeBlob: String.t() | nil,
          privateKey: String.t(),
          rpId: String.t() | nil,
          signCount: integer(),
          userHandle: String.t() | nil
        }

  @typedoc "description not provided :("
  @type ctap2_version :: :ctap2_0 | :ctap2_1

  @typedoc "description not provided :("
  @type virtual_authenticator_options :: %{
          automaticPresenceSimulation: boolean() | nil,
          ctap2Version: CDPotion.Domain.WebAuthn.ctap2_version() | nil,
          hasCredBlob: boolean() | nil,
          hasLargeBlob: boolean() | nil,
          hasMinPinLength: boolean() | nil,
          hasPrf: boolean() | nil,
          hasResidentKey: boolean() | nil,
          hasUserVerification: boolean() | nil,
          isUserVerified: boolean() | nil,
          protocol: CDPotion.Domain.WebAuthn.authenticator_protocol(),
          transport: CDPotion.Domain.WebAuthn.authenticator_transport()
        }

  @doc """
  Enable the WebAuthn domain and start intercepting credential storage and
  retrieval with a virtual authenticator.
  ## Parameters:
    - `enable_ui`:(Optional) Whether to enable the WebAuthn user interface. Enabling the UI is
  recommended for debugging and demo purposes, as it is closer to the real
  experience. Disabling the UI is recommended for automated testing.
  Supported at the embedder's discretion if UI is available.
  Defaults to false.
  """
  @spec enable(boolean()) :: {String.t(), map()}
  def enable(enable_ui \\ nil) do
    params = as_query([{"enableUI", enable_ui}])
    {"WebAuthn.enable", params}
  end

  @doc """
  Disable the WebAuthn domain.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"WebAuthn.disable", %{}}
  end

  @doc """
  Creates and adds a virtual authenticator.
  ## Parameters:
    - `options`:description not provided :(
  """
  @spec add_virtual_authenticator(CDPotion.Domain.WebAuthn.VirtualAuthenticatorOptions) ::
          {String.t(), map()}
  def add_virtual_authenticator(options) do
    params = as_query([{"options", options}])
    {"WebAuthn.addVirtualAuthenticator", params}
  end

  @doc """
  Resets parameters isBogusSignature, isBadUV, isBadUP to false if they are not present.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  - `is_bogus_signature`:(Optional) If isBogusSignature is set, overrides the signature in the authenticator response to be zero.
  Defaults to false.
  - `is_bad_uv`:(Optional) If isBadUV is set, overrides the UV bit in the flags in the authenticator response to
  be zero. Defaults to false.
  - `is_bad_up`:(Optional) If isBadUP is set, overrides the UP bit in the flags in the authenticator response to
  be zero. Defaults to false.
  """
  @spec set_response_override_bits(
          CDPotion.Domain.WebAuthn.AuthenticatorId,
          boolean(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
  def set_response_override_bits(
        authenticator_id,
        is_bogus_signature \\ nil,
        is_bad_uv \\ nil,
        is_bad_up \\ nil
      ) do
    params =
      as_query([
        {"authenticatorId", authenticator_id},
        {"isBogusSignature", is_bogus_signature},
        {"isBadUV", is_bad_uv},
        {"isBadUP", is_bad_up}
      ])

    {"WebAuthn.setResponseOverrideBits", params}
  end

  @doc """
  Removes the given authenticator.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  """
  @spec remove_virtual_authenticator(CDPotion.Domain.WebAuthn.AuthenticatorId) ::
          {String.t(), map()}
  def remove_virtual_authenticator(authenticator_id) do
    params = as_query([{"authenticatorId", authenticator_id}])
    {"WebAuthn.removeVirtualAuthenticator", params}
  end

  @doc """
  Adds the credential to the specified authenticator.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  - `credential`:description not provided :(
  """
  @spec add_credential(
          CDPotion.Domain.WebAuthn.AuthenticatorId,
          CDPotion.Domain.WebAuthn.Credential
        ) :: {String.t(), map()}
  def add_credential(authenticator_id, credential) do
    params = as_query([{"authenticatorId", authenticator_id}, {"credential", credential}])
    {"WebAuthn.addCredential", params}
  end

  @doc """
  Returns a single credential stored in the given virtual authenticator that
  matches the credential ID.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  - `credential_id`:description not provided :(
  """
  @spec get_credential(CDPotion.Domain.WebAuthn.AuthenticatorId, String.t()) ::
          {String.t(), map()}
  def get_credential(authenticator_id, credential_id) do
    params = as_query([{"authenticatorId", authenticator_id}, {"credentialId", credential_id}])
    {"WebAuthn.getCredential", params}
  end

  @doc """
  Returns all the credentials stored in the given virtual authenticator.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  """
  @spec get_credentials(CDPotion.Domain.WebAuthn.AuthenticatorId) :: {String.t(), map()}
  def get_credentials(authenticator_id) do
    params = as_query([{"authenticatorId", authenticator_id}])
    {"WebAuthn.getCredentials", params}
  end

  @doc """
  Removes a credential from the authenticator.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  - `credential_id`:description not provided :(
  """
  @spec remove_credential(CDPotion.Domain.WebAuthn.AuthenticatorId, String.t()) ::
          {String.t(), map()}
  def remove_credential(authenticator_id, credential_id) do
    params = as_query([{"authenticatorId", authenticator_id}, {"credentialId", credential_id}])
    {"WebAuthn.removeCredential", params}
  end

  @doc """
  Clears all the credentials from the specified device.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  """
  @spec clear_credentials(CDPotion.Domain.WebAuthn.AuthenticatorId) :: {String.t(), map()}
  def clear_credentials(authenticator_id) do
    params = as_query([{"authenticatorId", authenticator_id}])
    {"WebAuthn.clearCredentials", params}
  end

  @doc """
  Sets whether User Verification succeeds or fails for an authenticator.
  The default is true.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  - `is_user_verified`:description not provided :(
  """
  @spec set_user_verified(CDPotion.Domain.WebAuthn.AuthenticatorId, boolean()) ::
          {String.t(), map()}
  def set_user_verified(authenticator_id, is_user_verified) do
    params =
      as_query([{"authenticatorId", authenticator_id}, {"isUserVerified", is_user_verified}])

    {"WebAuthn.setUserVerified", params}
  end

  @doc """
  Sets whether tests of user presence will succeed immediately (if true) or fail to resolve (if false) for an authenticator.
  The default is true.
  ## Parameters:
    - `authenticator_id`:description not provided :(
  - `enabled`:description not provided :(
  """
  @spec set_automatic_presence_simulation(CDPotion.Domain.WebAuthn.AuthenticatorId, boolean()) ::
          {String.t(), map()}
  def set_automatic_presence_simulation(authenticator_id, enabled) do
    params = as_query([{"authenticatorId", authenticator_id}, {"enabled", enabled}])
    {"WebAuthn.setAutomaticPresenceSimulation", params}
  end
end
