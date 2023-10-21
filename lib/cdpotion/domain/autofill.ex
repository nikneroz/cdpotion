defmodule CDPotion.Domain.Autofill do
  use CDPotion.Utils
  @doc "description not provided :("
  @type Address :: %{
          fields: list(Autofill.AddressField)
        }

  @doc "description not provided :("
  @type AddressField :: %{
          name: String.t(),
          value: String.t()
        }

  @doc "description not provided :("
  @type CreditCard :: %{
          cvc: String.t(),
          expiryMonth: String.t(),
          expiryYear: String.t(),
          name: String.t(),
          number: String.t()
        }

  @doc """
  Trigger autofill on a form identified by the fieldId.
  If the field and related form cannot be autofilled, returns an error.
  ## Parameters:
    - `fieldId:DOM.BackendNodeId`: Identifies a field that serves as an anchor for autofill.
    - `frameId:Page.FrameId`: (Optional) Identifies the frame that field belongs to.
    - `card:CreditCard`: Credit card information to fill out the form. Credit card data is not saved.
  """
  def trigger(field_id, frame_id \\ nil, card) do
    params = as_query([{"fieldId", field_id}, {"frameId", frame_id}, {"card", card}])
    {"Autofill.trigger", params}
  end

  @doc """
  Set addresses so that developers can verify their forms implementation.
  ## Parameters:
    - `addresses:array`: description not provided :(
  """
  def set_addresses(addresses) do
    params = as_query([{"addresses", addresses}])
    {"Autofill.setAddresses", params}
  end
end
