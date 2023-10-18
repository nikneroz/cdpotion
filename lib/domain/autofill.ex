defmodule CDPotion.Domain.Autofill do

@doc """
Trigger autofill on a form identified by the fieldId.
If the field and related form cannot be autofilled, returns an error.
## Parameters:
  - `fieldId:DOM.BackendNodeId`: Identifies a field that serves as an anchor for autofill.
  - `frameId:Page.FrameId`: (Optional) Identifies the frame that field belongs to.
  - `card:CreditCard`: Credit card information to fill out the form. Credit card data is not saved.
"""
def trigger(field_id, frame_id \\ nil, card) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Set addresses so that developers can verify their forms implementation.
## Parameters:
  - `addresses:array`: description not provided :(
"""
def set_addresses(addresses) do
  execute(session, :navigate, %{"url" => url})
end
end