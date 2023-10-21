defmodule CDPotion.Domain.WebAuthn do
  use CDPotion.Utils
  @doc "description not provided :("
  @type AuthenticatorId :: String.t()

  @doc "description not provided :("
  @type AuthenticatorProtocol :: :u2f | :ctap2

  @doc "description not provided :("
  @type AuthenticatorTransport :: :usb | :nfc | :ble | :cable | :internal

  @doc "description not provided :("
  @type Credential :: %{
          credentialId: String.t(),
          isResidentCredential: boolean(),
          largeBlob: String.t() | nil,
          privateKey: String.t(),
          rpId: String.t() | nil,
          signCount: integer(),
          userHandle: String.t() | nil
        }

  @doc "description not provided :("
  @type Ctap2Version :: :ctap2_0 | :ctap2_1

  @doc "description not provided :("
  @type VirtualAuthenticatorOptions :: %{
          automaticPresenceSimulation: boolean() | nil,
          ctap2Version: WebAuthn.Ctap2Version | nil,
          hasCredBlob: boolean() | nil,
          hasLargeBlob: boolean() | nil,
          hasMinPinLength: boolean() | nil,
          hasPrf: boolean() | nil,
          hasResidentKey: boolean() | nil,
          hasUserVerification: boolean() | nil,
          isUserVerified: boolean() | nil,
          protocol: WebAuthn.AuthenticatorProtocol,
          transport: WebAuthn.AuthenticatorTransport
        }

  @doc """
  Enable the WebAuthn domain and start intercepting credential storage and
  retrieval with a virtual authenticator.
  ## Parameters:
    - `enableUI:boolean`: (Optional) Whether to enable the WebAuthn user interface. Enabling the UI is
  recommended for debugging and demo purposes, as it is closer to the real
  experience. Disabling the UI is recommended for automated testing.
  Supported at the embedder's discretion if UI is available.
  Defaults to false.
  """
  def enable(enable_ui \\ nil) do
    params = as_query([{"enableUI", enable_ui}])
    {"WebAuthn.enable", params}
  end

  @doc """
  Disable the WebAuthn domain.
  """
  def disable() do
    {"WebAuthn.disable", %{}}
  end

  @doc """
  Creates and adds a virtual authenticator.
  ## Parameters:
    - `options:VirtualAuthenticatorOptions`: description not provided :(
  """
  def add_virtual_authenticator(options) do
    params = as_query([{"options", options}])
    {"WebAuthn.addVirtualAuthenticator", params}
  end

  @doc """
  Resets parameters isBogusSignature, isBadUV, isBadUP to false if they are not present.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
    - `isBogusSignature:boolean`: (Optional) If isBogusSignature is set, overrides the signature in the authenticator response to be zero.
  Defaults to false.
    - `isBadUV:boolean`: (Optional) If isBadUV is set, overrides the UV bit in the flags in the authenticator response to
  be zero. Defaults to false.
    - `isBadUP:boolean`: (Optional) If isBadUP is set, overrides the UP bit in the flags in the authenticator response to
  be zero. Defaults to false.
  """
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
    - `authenticatorId:AuthenticatorId`: description not provided :(
  """
  def remove_virtual_authenticator(authenticator_id) do
    params = as_query([{"authenticatorId", authenticator_id}])
    {"WebAuthn.removeVirtualAuthenticator", params}
  end

  @doc """
  Adds the credential to the specified authenticator.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
    - `credential:Credential`: description not provided :(
  """
  def add_credential(authenticator_id, credential) do
    params = as_query([{"authenticatorId", authenticator_id}, {"credential", credential}])
    {"WebAuthn.addCredential", params}
  end

  @doc """
  Returns a single credential stored in the given virtual authenticator that
  matches the credential ID.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
    - `credentialId:string`: description not provided :(
  """
  def get_credential(authenticator_id, credential_id) do
    params = as_query([{"authenticatorId", authenticator_id}, {"credentialId", credential_id}])
    {"WebAuthn.getCredential", params}
  end

  @doc """
  Returns all the credentials stored in the given virtual authenticator.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
  """
  def get_credentials(authenticator_id) do
    params = as_query([{"authenticatorId", authenticator_id}])
    {"WebAuthn.getCredentials", params}
  end

  @doc """
  Removes a credential from the authenticator.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
    - `credentialId:string`: description not provided :(
  """
  def remove_credential(authenticator_id, credential_id) do
    params = as_query([{"authenticatorId", authenticator_id}, {"credentialId", credential_id}])
    {"WebAuthn.removeCredential", params}
  end

  @doc """
  Clears all the credentials from the specified device.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
  """
  def clear_credentials(authenticator_id) do
    params = as_query([{"authenticatorId", authenticator_id}])
    {"WebAuthn.clearCredentials", params}
  end

  @doc """
  Sets whether User Verification succeeds or fails for an authenticator.
  The default is true.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
    - `isUserVerified:boolean`: description not provided :(
  """
  def set_user_verified(authenticator_id, is_user_verified) do
    params =
      as_query([{"authenticatorId", authenticator_id}, {"isUserVerified", is_user_verified}])

    {"WebAuthn.setUserVerified", params}
  end

  @doc """
  Sets whether tests of user presence will succeed immediately (if true) or fail to resolve (if false) for an authenticator.
  The default is true.
  ## Parameters:
    - `authenticatorId:AuthenticatorId`: description not provided :(
    - `enabled:boolean`: description not provided :(
  """
  def set_automatic_presence_simulation(authenticator_id, enabled) do
    params = as_query([{"authenticatorId", authenticator_id}, {"enabled", enabled}])
    {"WebAuthn.setAutomaticPresenceSimulation", params}
  end
end
