defmodule CDPotion.Domain.FedCm do

@doc """
## Parameters:
  - `disableRejectionDelay:boolean`: (Optional) Allows callers to disable the promise rejection delay that would
normally happen, if this is unimportant to what's being tested.
(step 4 of https://fedidcg.github.io/FedCM/#browser-api-rp-sign-in)
"""
def enable(disable_rejection_delay \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `dialogId:string`: description not provided :(
  - `accountIndex:integer`: description not provided :(
"""
def select_account(dialog_id, account_index) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `dialogId:string`: description not provided :(
  - `triggerCooldown:boolean`: (Optional) description not provided :(
"""
def dismiss_dialog(dialog_id, trigger_cooldown \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Resets the cooldown time, if any, to allow the next FedCM call to show
a dialog even if one was recently dismissed by the user.
"""
def reset_cooldown() do
  execute(session, :navigate, %{"url" => url})
end
end