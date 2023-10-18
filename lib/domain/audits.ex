defmodule CDPotion.Domain.Audits do

@doc """
Returns the response body and size if it were re-encoded with the specified settings. Only
applies to images.
## Parameters:
- `requestId:Network.RequestId`: Identifier of the network request to get content for.
  - `encoding:string`: The encoding to use.
  - `quality:number`: (Optional) The quality of the encoding (0-1). (defaults to 1)
  - `sizeOnly:boolean`: (Optional) Whether to only return the size information (defaults to false).
"""
def get_encoded_response(request_id, encoding, quality \\ nil, size_only \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disables issues domain, prevents further issues from being reported to the client.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables issues domain, sends the issues collected so far to the client by means of the
`issueAdded` event.
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Runs the contrast check for the target page. Found issues are reported
using Audits.issueAdded event.
## Parameters:
- `reportAAA:boolean`: (Optional) Whether to report WCAG AAA level issues. Default is false.
"""
def check_contrast(report_aa_a \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Runs the form issues check for the target page. Found issues are reported
using Audits.issueAdded event.
"""
def check_forms_issues() do
  execute(session, :navigate, %{"url" => url})
end
end