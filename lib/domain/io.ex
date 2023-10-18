defmodule CDPotion.Domain.IO do

@doc """
Close the stream, discard any temporary backing storage.
## Parameters:
- `handle:StreamHandle`: Handle of the stream to close.
"""
def close(handle) do
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
end

@doc """
Return UUID of Blob object specified by a remote object id.
## Parameters:
- `objectId:Runtime.RemoteObjectId`: Object id of a Blob object wrapper.
"""
def resolve_blob(object_id) do
  execute(session, :navigate, %{"url" => url})
end
end