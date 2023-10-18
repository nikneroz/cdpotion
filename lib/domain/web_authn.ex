defmodule CDPotion.Domain.WebAuthn do
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
  def enable(enable_u_i \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disable the WebAuthn domain.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Creates and adds a virtual authenticator.
  ## Parameters:
  - `options:VirtualAuthenticatorOptions`: description not provided :(
  """
  def add_virtual_authenticator(options) do
    execute(session, :navigate, %{"url" => url})
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
        is_bad_u_v \\ nil,
        is_bad_u_p \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Removes the given authenticator.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
  """
  def remove_virtual_authenticator(authenticator_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Adds the credential to the specified authenticator.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
    - `credential:Credential`: description not provided :(
  """
  def add_credential(authenticator_id, credential) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns a single credential stored in the given virtual authenticator that
  matches the credential ID.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
    - `credentialId:string`: description not provided :(
  """
  def get_credential(authenticator_id, credential_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns all the credentials stored in the given virtual authenticator.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
  """
  def get_credentials(authenticator_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Removes a credential from the authenticator.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
    - `credentialId:string`: description not provided :(
  """
  def remove_credential(authenticator_id, credential_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Clears all the credentials from the specified device.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
  """
  def clear_credentials(authenticator_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets whether User Verification succeeds or fails for an authenticator.
  The default is true.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
    - `isUserVerified:boolean`: description not provided :(
  """
  def set_user_verified(authenticator_id, is_user_verified) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets whether tests of user presence will succeed immediately (if true) or fail to resolve (if false) for an authenticator.
  The default is true.
  ## Parameters:
  - `authenticatorId:AuthenticatorId`: description not provided :(
    - `enabled:boolean`: description not provided :(
  """
  def set_automatic_presence_simulation(authenticator_id, enabled) do
    execute(session, :navigate, %{"url" => url})
  end
end
