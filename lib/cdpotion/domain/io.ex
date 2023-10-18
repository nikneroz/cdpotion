defmodule CDPotion.Domain.IO do
  use CDPotion.Utils

  @doc """
  Close the stream, discard any temporary backing storage.
  ## Parameters:
    - `handle:StreamHandle`: Handle of the stream to close.
  """
  def close(handle) do
    params = as_query([{"handle", handle}])
    {"IO.close", params}
  end

  @doc """
  Read a chunk of the stream
  ## Parameters:
    - `handle:StreamHandle`: Handle of the stream to read.
    - `offset:integer`: (Optional) Seek to the specified offset before reading (if not specificed, proceed with offset
  following the last read). Some types of streams may only support sequential reads.
    - `size:integer`: (Optional) Maximum number of bytes to read (left upon the agent discretion if not specified).
  """
  def read(handle, offset \\ nil, size \\ nil) do
    params = as_query([{"handle", handle}, {"offset", offset}, {"size", size}])
    {"IO.read", params}
  end

  @doc """
  Return UUID of Blob object specified by a remote object id.
  ## Parameters:
    - `objectId:Runtime.RemoteObjectId`: Object id of a Blob object wrapper.
  """
  def resolve_blob(object_id) do
    params = as_query([{"objectId", object_id}])
    {"IO.resolveBlob", params}
  end
end
