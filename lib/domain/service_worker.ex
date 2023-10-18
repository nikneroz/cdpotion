defmodule CDPotion.Domain.ServiceWorker do

@doc """
## Parameters:
  - `origin:string`: description not provided :(
  - `registrationId:RegistrationID`: description not provided :(
  - `data:string`: description not provided :(
"""
def deliver_push_message(origin, registration_id, data) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `origin:string`: description not provided :(
  - `registrationId:RegistrationID`: description not provided :(
  - `tag:string`: description not provided :(
  - `lastChance:boolean`: description not provided :(
"""
def dispatch_sync_event(origin, registration_id, tag, last_chance) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `origin:string`: description not provided :(
  - `registrationId:RegistrationID`: description not provided :(
  - `tag:string`: description not provided :(
"""
def dispatch_periodic_sync_event(origin, registration_id, tag) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `versionId:string`: description not provided :(
"""
def inspect_worker(version_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `forceUpdateOnPageLoad:boolean`: description not provided :(
"""
def set_force_update_on_page_load(force_update_on_page_load) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `scopeURL:string`: description not provided :(
"""
def skip_waiting(scope_url) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `scopeURL:string`: description not provided :(
"""
def start_worker(scope_url) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def stop_all_workers() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `versionId:string`: description not provided :(
"""
def stop_worker(version_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `scopeURL:string`: description not provided :(
"""
def unregister(scope_url) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `scopeURL:string`: description not provided :(
"""
def update_registration(scope_url) do
  execute(session, :navigate, %{"url" => url})
end
end