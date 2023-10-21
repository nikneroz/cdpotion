defmodule CDPotion.Domain.DOMStorage do
  use CDPotion.Utils
  @typedoc "DOM Storage item."
  @type item :: list(String.t())

  @typedoc "description not provided :("
  @type serialized_storage_key :: String.t()

  @typedoc "DOM Storage identifier."
  @type storage_id :: %{
          isLocalStorage: boolean(),
          securityOrigin: String.t() | nil,
          storageKey: CDPotion.Domain.DOMStorage.serialized_storage_key() | nil
        }

  @doc """

  ## Parameters:
    - (Required) `storage_id`: description not provided :(
  """
  @spec clear(CDPotion.Domain.DOMStorage.storage_id()) :: {String.t(), map()}
  def clear(storage_id) do
    params = as_query([{"storageId", storage_id}])
    {"DOMStorage.clear", params}
  end

  @doc """
  Disables storage tracking, prevents storage events from being sent to the client.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"DOMStorage.disable", %{}}
  end

  @doc """
  Enables storage tracking, storage events will now be delivered to the client.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"DOMStorage.enable", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `storage_id`: description not provided :(
  """
  @spec get_dom_storage_items(CDPotion.Domain.DOMStorage.storage_id()) :: {String.t(), map()}
  def get_dom_storage_items(storage_id) do
    params = as_query([{"storageId", storage_id}])
    {"DOMStorage.getDOMStorageItems", params}
  end

  @doc """

  ## Parameters:
    - (Required) `storage_id`: description not provided :(
  - (Required) `key`: description not provided :(
  """
  @spec remove_dom_storage_item(CDPotion.Domain.DOMStorage.storage_id(), String.t()) ::
          {String.t(), map()}
  def remove_dom_storage_item(storage_id, key) do
    params = as_query([{"storageId", storage_id}, {"key", key}])
    {"DOMStorage.removeDOMStorageItem", params}
  end

  @doc """

  ## Parameters:
    - (Required) `storage_id`: description not provided :(
  - (Required) `key`: description not provided :(
  - (Required) `value`: description not provided :(
  """
  @spec set_dom_storage_item(CDPotion.Domain.DOMStorage.storage_id(), String.t(), String.t()) ::
          {String.t(), map()}
  def set_dom_storage_item(storage_id, key, value) do
    params = as_query([{"storageId", storage_id}, {"key", key}, {"value", value}])
    {"DOMStorage.setDOMStorageItem", params}
  end
end
