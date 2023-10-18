defmodule CDPotion.Domain.DOMStorage do

@doc """
## Parameters:
- `storageId:StorageId`: description not provided :(
"""
def clear(storage_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disables storage tracking, prevents storage events from being sent to the client.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables storage tracking, storage events will now be delivered to the client.
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
- `storageId:StorageId`: description not provided :(
"""
def get_dom_storage_items(storage_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
- `storageId:StorageId`: description not provided :(
  - `key:string`: description not provided :(
"""
def remove_dom_storage_item(storage_id, key) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
- `storageId:StorageId`: description not provided :(
  - `key:string`: description not provided :(
  - `value:string`: description not provided :(
"""
def set_dom_storage_item(storage_id, key, value) do
  execute(session, :navigate, %{"url" => url})
end
end