defmodule CDPotion.Domain.Autofill do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type address :: %{
          fields: list(CDPotion.Domain.Autofill.address_field())
        }

  @typedoc "description not provided :("
  @type address_field :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "description not provided :("
  @type credit_card :: %{
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
    - `field_id`:Identifies a field that serves as an anchor for autofill.
  - `frame_id`:(Optional) Identifies the frame that field belongs to.
  - `card`:Credit card information to fill out the form. Credit card data is not saved.
  """
  @spec trigger(
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Page.FrameId,
          CDPotion.Domain.Autofill.CreditCard
        ) :: {String.t(), map()}
  def trigger(field_id, frame_id \\ nil, card) do
    params = as_query([{"fieldId", field_id}, {"frameId", frame_id}, {"card", card}])
    {"Autofill.trigger", params}
  end

  @doc """
  Set addresses so that developers can verify their forms implementation.
  ## Parameters:
    - `addresses`:description not provided :(
  """
  @spec set_addresses(list(CDPotion.Domain.Autofill.Address)) :: {String.t(), map()}
  def set_addresses(addresses) do
    params = as_query([{"addresses", addresses}])
    {"Autofill.setAddresses", params}
  end
end
