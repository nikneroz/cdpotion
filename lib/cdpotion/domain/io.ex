defmodule CDPotion.Domain.IO do
  use CDPotion.Utils
  @typedoc "This is either obtained from another method or specified as `blob:<uuid>` where
`<uuid>` is an UUID of a Blob."
  @type stream_handle :: String.t()

  @doc """
  Close the stream, discard any temporary backing storage.
  ## Parameters:
    - (Required) `handle`: Handle of the stream to close.
  """
  @spec close(CDPotion.Domain.IO.StreamHandle) :: {String.t(), map()}
  def close(handle) do
    params = as_query([{"handle", handle}])
    {"IO.close", params}
  end

  @doc """
  Read a chunk of the stream
  ## Parameters:
    - (Required) `handle`: Handle of the stream to read.
  - (Optional) `offset`: Seek to the specified offset before reading (if not specificed, proceed with offset
  following the last read). Some types of streams may only support sequential reads.
  - (Optional) `size`: Maximum number of bytes to read (left upon the agent discretion if not specified).
  """
  @spec read(CDPotion.Domain.IO.StreamHandle, integer(), integer()) :: {String.t(), map()}
  def read(handle, offset \\ nil, size \\ nil) do
    params = as_query([{"handle", handle}, {"offset", offset}, {"size", size}])
    {"IO.read", params}
  end

  @doc """
  Return UUID of Blob object specified by a remote object id.
  ## Parameters:
    - (Required) `object_id`: Object id of a Blob object wrapper.
  """
  @spec resolve_blob(CDPotion.Domain.Runtime.RemoteObjectId) :: {String.t(), map()}
  def resolve_blob(object_id) do
    params = as_query([{"objectId", object_id}])
    {"IO.resolveBlob", params}
  end
end
