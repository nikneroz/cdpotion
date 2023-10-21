defmodule CDPotion.Domain.FedCm do
  use CDPotion.Utils
  @doc "Corresponds to IdentityRequestAccount"
  @type Account :: %{
          accountId: String.t(),
          email: String.t(),
          givenName: String.t(),
          idpConfigUrl: String.t(),
          idpSigninUrl: String.t(),
          loginState: FedCm.LoginState,
          name: String.t(),
          pictureUrl: String.t(),
          privacyPolicyUrl: String.t() | nil,
          termsOfServiceUrl: String.t() | nil
        }

  @doc "Whether the dialog shown is an account chooser or an auto re-authentication dialog."
  @type DialogType :: :AccountChooser | :AutoReauthn

  @doc "Whether this is a sign-up or sign-in action for this account, i.e.
whether this account has ever been used to sign in to this RP before."
  @type LoginState :: :SignIn | :SignUp

  @doc """
  ## Parameters:
    - `disableRejectionDelay:boolean`: (Optional) Allows callers to disable the promise rejection delay that would
  normally happen, if this is unimportant to what's being tested.
  (step 4 of https://fedidcg.github.io/FedCM/#browser-api-rp-sign-in)
  """
  def enable(disable_rejection_delay \\ nil) do
    params = as_query([{"disableRejectionDelay", disable_rejection_delay}])
    {"FedCm.enable", params}
  end

  @doc """
  """
  def disable() do
    {"FedCm.disable", %{}}
  end

  @doc """
  ## Parameters:
    - `dialogId:string`: description not provided :(
    - `accountIndex:integer`: description not provided :(
  """
  def select_account(dialog_id, account_index) do
    params = as_query([{"dialogId", dialog_id}, {"accountIndex", account_index}])
    {"FedCm.selectAccount", params}
  end

  @doc """
  ## Parameters:
    - `dialogId:string`: description not provided :(
    - `triggerCooldown:boolean`: (Optional) description not provided :(
  """
  def dismiss_dialog(dialog_id, trigger_cooldown \\ nil) do
    params = as_query([{"dialogId", dialog_id}, {"triggerCooldown", trigger_cooldown}])
    {"FedCm.dismissDialog", params}
  end

  @doc """
  Resets the cooldown time, if any, to allow the next FedCM call to show
  a dialog even if one was recently dismissed by the user.
  """
  def reset_cooldown() do
    {"FedCm.resetCooldown", %{}}
  end
end
