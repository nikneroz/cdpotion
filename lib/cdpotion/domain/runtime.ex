defmodule CDPotion.Domain.Runtime do
  use CDPotion.Utils
  @doc "Represents function call argument. Either remote object id `objectId`, primitive `value`,
unserializable primitive value or neither of (for undefined) them should be specified."
  @type CallArgument :: %{
          objectId: Runtime.RemoteObjectId | nil,
          unserializableValue: Runtime.UnserializableValue | nil,
          value: any() | nil
        }

  @doc "Stack entry for runtime errors and assertions."
  @type CallFrame :: %{
          columnNumber: integer(),
          functionName: String.t(),
          lineNumber: integer(),
          scriptId: Runtime.ScriptId,
          url: String.t()
        }

  @doc "description not provided :("
  @type CustomPreview :: %{
          bodyGetterId: Runtime.RemoteObjectId | nil,
          header: String.t()
        }

  @doc "Represents deep serialized value."
  @type DeepSerializedValue :: %{
          objectId: String.t() | nil,
          type:
            :undefined
            | :null
            | :string
            | :number
            | :boolean
            | :bigint
            | :regexp
            | :date
            | :symbol
            | :array
            | :object
            | :function
            | :map
            | :set
            | :weakmap
            | :weakset
            | :error
            | :proxy
            | :promise
            | :typedarray
            | :arraybuffer
            | :node
            | :window,
          value: any() | nil,
          weakLocalObjectReference: integer() | nil
        }

  @doc "description not provided :("
  @type EntryPreview :: %{
          key: Runtime.ObjectPreview | nil,
          value: Runtime.ObjectPreview
        }

  @doc "Detailed information about exception (or error) that was thrown during script compilation or
execution."
  @type ExceptionDetails :: %{
          columnNumber: integer(),
          exception: Runtime.RemoteObject | nil,
          exceptionId: integer(),
          exceptionMetaData: map() | nil,
          executionContextId: Runtime.ExecutionContextId | nil,
          lineNumber: integer(),
          scriptId: Runtime.ScriptId | nil,
          stackTrace: Runtime.StackTrace | nil,
          text: String.t(),
          url: String.t() | nil
        }

  @doc "Description of an isolated world."
  @type ExecutionContextDescription :: %{
          auxData: map() | nil,
          id: Runtime.ExecutionContextId,
          name: String.t(),
          origin: String.t(),
          uniqueId: String.t()
        }

  @doc "Id of an execution context."
  @type ExecutionContextId :: integer()

  @doc "Object internal property descriptor. This property isn't normally visible in JavaScript code."
  @type InternalPropertyDescriptor :: %{
          name: String.t(),
          value: Runtime.RemoteObject | nil
        }

  @doc "Object containing abbreviated remote object value."
  @type ObjectPreview :: %{
          description: String.t() | nil,
          entries: list(Runtime.EntryPreview) | nil,
          overflow: boolean(),
          properties: list(Runtime.PropertyPreview),
          subtype:
            :array
            | :null
            | :node
            | :regexp
            | :date
            | :map
            | :set
            | :weakmap
            | :weakset
            | :iterator
            | :generator
            | :error
            | :proxy
            | :promise
            | :typedarray
            | :arraybuffer
            | :dataview
            | :webassemblymemory
            | :wasmvalue
            | nil,
          type:
            :object | :function | :undefined | :string | :number | :boolean | :symbol | :bigint
        }

  @doc "Object private field descriptor."
  @type PrivatePropertyDescriptor :: %{
          get: Runtime.RemoteObject | nil,
          name: String.t(),
          set: Runtime.RemoteObject | nil,
          value: Runtime.RemoteObject | nil
        }

  @doc "Object property descriptor."
  @type PropertyDescriptor :: %{
          configurable: boolean(),
          enumerable: boolean(),
          get: Runtime.RemoteObject | nil,
          isOwn: boolean() | nil,
          name: String.t(),
          set: Runtime.RemoteObject | nil,
          symbol: Runtime.RemoteObject | nil,
          value: Runtime.RemoteObject | nil,
          wasThrown: boolean() | nil,
          writable: boolean() | nil
        }

  @doc "description not provided :("
  @type PropertyPreview :: %{
          name: String.t(),
          subtype:
            :array
            | :null
            | :node
            | :regexp
            | :date
            | :map
            | :set
            | :weakmap
            | :weakset
            | :iterator
            | :generator
            | :error
            | :proxy
            | :promise
            | :typedarray
            | :arraybuffer
            | :dataview
            | :webassemblymemory
            | :wasmvalue
            | nil,
          type:
            :object
            | :function
            | :undefined
            | :string
            | :number
            | :boolean
            | :symbol
            | :accessor
            | :bigint,
          value: String.t() | nil,
          valuePreview: Runtime.ObjectPreview | nil
        }

  @doc "Mirror object referencing original JavaScript object."
  @type RemoteObject :: %{
          className: String.t() | nil,
          customPreview: Runtime.CustomPreview | nil,
          deepSerializedValue: Runtime.DeepSerializedValue | nil,
          description: String.t() | nil,
          objectId: Runtime.RemoteObjectId | nil,
          preview: Runtime.ObjectPreview | nil,
          subtype:
            :array
            | :null
            | :node
            | :regexp
            | :date
            | :map
            | :set
            | :weakmap
            | :weakset
            | :iterator
            | :generator
            | :error
            | :proxy
            | :promise
            | :typedarray
            | :arraybuffer
            | :dataview
            | :webassemblymemory
            | :wasmvalue
            | nil,
          type:
            :object | :function | :undefined | :string | :number | :boolean | :symbol | :bigint,
          unserializableValue: Runtime.UnserializableValue | nil,
          value: any() | nil,
          webDriverValue: Runtime.DeepSerializedValue | nil
        }

  @doc "Unique object identifier."
  @type RemoteObjectId :: String.t()

  @doc "Unique script identifier."
  @type ScriptId :: String.t()

  @doc "Represents options for serialization. Overrides `generatePreview`, `returnByValue` and
`generateWebDriverValue`."
  @type SerializationOptions :: %{
          additionalParameters: map() | nil,
          maxDepth: integer() | nil,
          serialization: :deep | :json | :idOnly
        }

  @doc "Call frames for assertions or error messages."
  @type StackTrace :: %{
          callFrames: list(Runtime.CallFrame),
          description: String.t() | nil,
          parent: Runtime.StackTrace | nil,
          parentId: Runtime.StackTraceId | nil
        }

  @doc "If `debuggerId` is set stack trace comes from another debugger and can be resolved there. This
allows to track cross-debugger calls. See `Runtime.StackTrace` and `Debugger.paused` for usages."
  @type StackTraceId :: %{
          debuggerId: Runtime.UniqueDebuggerId | nil,
          id: String.t()
        }

  @doc "Number of milliseconds."
  @type TimeDelta :: number()

  @doc "Number of milliseconds since epoch."
  @type Timestamp :: number()

  @doc "Unique identifier of current debugger."
  @type UniqueDebuggerId :: String.t()

  @doc "Primitive value which cannot be JSON-stringified. Includes values `-0`, `NaN`, `Infinity`,
`-Infinity`, and bigint literals."
  @type UnserializableValue :: String.t()

  @doc """
  Add handler to promise with given promise object id.
  ## Parameters:
    - `promiseObjectId:RemoteObjectId`: Identifier of the promise.
    - `returnByValue:boolean`: (Optional) Whether the result is expected to be a JSON object that should be sent by value.
    - `generatePreview:boolean`: (Optional) Whether preview should be generated for the result.
  """
  def await_promise(promise_object_id, return_by_value \\ nil, generate_preview \\ nil) do
    params =
      as_query([
        {"promiseObjectId", promise_object_id},
        {"returnByValue", return_by_value},
        {"generatePreview", generate_preview}
      ])

    {"Runtime.awaitPromise", params}
  end

  @doc """
  Calls function with given declaration on the given object. Object group of the result is
  inherited from the target object.
  ## Parameters:
    - `functionDeclaration:string`: Declaration of the function to call.
    - `objectId:RemoteObjectId`: (Optional) Identifier of the object to call function on. Either objectId or executionContextId should
  be specified.
    - `arguments:array`: (Optional) Call arguments. All call arguments must belong to the same JavaScript world as the target
  object.
    - `silent:boolean`: (Optional) In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
    - `returnByValue:boolean`: (Optional) Whether the result is expected to be a JSON object which should be sent by value.
  Can be overriden by `serializationOptions`.
    - `generatePreview:boolean`: (Optional) Whether preview should be generated for the result.
    - `userGesture:boolean`: (Optional) Whether execution should be treated as initiated by user in the UI.
    - `awaitPromise:boolean`: (Optional) Whether execution should `await` for resulting value and return once awaited promise is
  resolved.
    - `executionContextId:ExecutionContextId`: (Optional) Specifies execution context which global object will be used to call function on. Either
  executionContextId or objectId should be specified.
    - `objectGroup:string`: (Optional) Symbolic group name that can be used to release multiple objects. If objectGroup is not
  specified and objectId is, objectGroup will be inherited from object.
    - `throwOnSideEffect:boolean`: (Optional) Whether to throw an exception if side effect cannot be ruled out during evaluation.
    - `uniqueContextId:string`: (Optional) An alternative way to specify the execution context to call function on.
  Compared to contextId that may be reused across processes, this is guaranteed to be
  system-unique, so it can be used to prevent accidental function call
  in context different than intended (e.g. as a result of navigation across process
  boundaries).
  This is mutually exclusive with `executionContextId`.
    - `generateWebDriverValue:boolean`: (Optional) Deprecated. Use `serializationOptions: {serialization:"deep"}` instead.
  Whether the result should contain `webDriverValue`, serialized according to
  https://w3c.github.io/webdriver-bidi. This is mutually exclusive with `returnByValue`, but
  resulting `objectId` is still provided.
    - `serializationOptions:SerializationOptions`: (Optional) Specifies the result serialization. If provided, overrides
  `generatePreview`, `returnByValue` and `generateWebDriverValue`.
  """
  def call_function_on(
        function_declaration,
        object_id \\ nil,
        arguments \\ nil,
        silent \\ nil,
        return_by_value \\ nil,
        generate_preview \\ nil,
        user_gesture \\ nil,
        await_promise \\ nil,
        execution_context_id \\ nil,
        object_group \\ nil,
        throw_on_side_effect \\ nil,
        unique_context_id \\ nil,
        generate_web_driver_value \\ nil,
        serialization_options \\ nil
      ) do
    params =
      as_query([
        {"functionDeclaration", function_declaration},
        {"objectId", object_id},
        {"arguments", arguments},
        {"silent", silent},
        {"returnByValue", return_by_value},
        {"generatePreview", generate_preview},
        {"userGesture", user_gesture},
        {"awaitPromise", await_promise},
        {"executionContextId", execution_context_id},
        {"objectGroup", object_group},
        {"throwOnSideEffect", throw_on_side_effect},
        {"uniqueContextId", unique_context_id},
        {"generateWebDriverValue", generate_web_driver_value},
        {"serializationOptions", serialization_options}
      ])

    {"Runtime.callFunctionOn", params}
  end

  @doc """
  Compiles expression.
  ## Parameters:
    - `expression:string`: Expression to compile.
    - `sourceURL:string`: Source url to be set for the script.
    - `persistScript:boolean`: Specifies whether the compiled script should be persisted.
    - `executionContextId:ExecutionContextId`: (Optional) Specifies in which execution context to perform script run. If the parameter is omitted the
  evaluation will be performed in the context of the inspected page.
  """
  def compile_script(expression, source_url, persist_script, execution_context_id \\ nil) do
    params =
      as_query([
        {"expression", expression},
        {"sourceURL", source_url},
        {"persistScript", persist_script},
        {"executionContextId", execution_context_id}
      ])

    {"Runtime.compileScript", params}
  end

  @doc """
  Disables reporting of execution contexts creation.
  """
  def disable() do
    {"Runtime.disable", %{}}
  end

  @doc """
  Discards collected exceptions and console API calls.
  """
  def discard_console_entries() do
    {"Runtime.discardConsoleEntries", %{}}
  end

  @doc """
  Enables reporting of execution contexts creation by means of `executionContextCreated` event.
  When the reporting gets enabled the event will be sent immediately for each existing execution
  context.
  """
  def enable() do
    {"Runtime.enable", %{}}
  end

  @doc """
  Evaluates expression on global object.
  ## Parameters:
    - `expression:string`: Expression to evaluate.
    - `objectGroup:string`: (Optional) Symbolic group name that can be used to release multiple objects.
    - `includeCommandLineAPI:boolean`: (Optional) Determines whether Command Line API should be available during the evaluation.
    - `silent:boolean`: (Optional) In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
    - `contextId:ExecutionContextId`: (Optional) Specifies in which execution context to perform evaluation. If the parameter is omitted the
  evaluation will be performed in the context of the inspected page.
  This is mutually exclusive with `uniqueContextId`, which offers an
  alternative way to identify the execution context that is more reliable
  in a multi-process environment.
    - `returnByValue:boolean`: (Optional) Whether the result is expected to be a JSON object that should be sent by value.
    - `generatePreview:boolean`: (Optional) Whether preview should be generated for the result.
    - `userGesture:boolean`: (Optional) Whether execution should be treated as initiated by user in the UI.
    - `awaitPromise:boolean`: (Optional) Whether execution should `await` for resulting value and return once awaited promise is
  resolved.
    - `throwOnSideEffect:boolean`: (Optional) Whether to throw an exception if side effect cannot be ruled out during evaluation.
  This implies `disableBreaks` below.
    - `timeout:TimeDelta`: (Optional) Terminate execution after timing out (number of milliseconds).
    - `disableBreaks:boolean`: (Optional) Disable breakpoints during execution.
    - `replMode:boolean`: (Optional) Setting this flag to true enables `let` re-declaration and top-level `await`.
  Note that `let` variables can only be re-declared if they originate from
  `replMode` themselves.
    - `allowUnsafeEvalBlockedByCSP:boolean`: (Optional) The Content Security Policy (CSP) for the target might block 'unsafe-eval'
  which includes eval(), Function(), setTimeout() and setInterval()
  when called with non-callable arguments. This flag bypasses CSP for this
  evaluation and allows unsafe-eval. Defaults to true.
    - `uniqueContextId:string`: (Optional) An alternative way to specify the execution context to evaluate in.
  Compared to contextId that may be reused across processes, this is guaranteed to be
  system-unique, so it can be used to prevent accidental evaluation of the expression
  in context different than intended (e.g. as a result of navigation across process
  boundaries).
  This is mutually exclusive with `contextId`.
    - `generateWebDriverValue:boolean`: (Optional) Deprecated. Use `serializationOptions: {serialization:"deep"}` instead.
  Whether the result should contain `webDriverValue`, serialized
  according to
  https://w3c.github.io/webdriver-bidi. This is mutually exclusive with `returnByValue`, but
  resulting `objectId` is still provided.
    - `serializationOptions:SerializationOptions`: (Optional) Specifies the result serialization. If provided, overrides
  `generatePreview`, `returnByValue` and `generateWebDriverValue`.
  """
  def evaluate(
        expression,
        object_group \\ nil,
        include_command_line_api \\ nil,
        silent \\ nil,
        context_id \\ nil,
        return_by_value \\ nil,
        generate_preview \\ nil,
        user_gesture \\ nil,
        await_promise \\ nil,
        throw_on_side_effect \\ nil,
        timeout \\ nil,
        disable_breaks \\ nil,
        repl_mode \\ nil,
        allow_unsafe_eval_blocked_by_csp \\ nil,
        unique_context_id \\ nil,
        generate_web_driver_value \\ nil,
        serialization_options \\ nil
      ) do
    params =
      as_query([
        {"expression", expression},
        {"objectGroup", object_group},
        {"includeCommandLineAPI", include_command_line_api},
        {"silent", silent},
        {"contextId", context_id},
        {"returnByValue", return_by_value},
        {"generatePreview", generate_preview},
        {"userGesture", user_gesture},
        {"awaitPromise", await_promise},
        {"throwOnSideEffect", throw_on_side_effect},
        {"timeout", timeout},
        {"disableBreaks", disable_breaks},
        {"replMode", repl_mode},
        {"allowUnsafeEvalBlockedByCSP", allow_unsafe_eval_blocked_by_csp},
        {"uniqueContextId", unique_context_id},
        {"generateWebDriverValue", generate_web_driver_value},
        {"serializationOptions", serialization_options}
      ])

    {"Runtime.evaluate", params}
  end

  @doc """
  Returns the isolate id.
  """
  def get_isolate_id() do
    {"Runtime.getIsolateId", %{}}
  end

  @doc """
  Returns the JavaScript heap usage.
  It is the total usage of the corresponding isolate not scoped to a particular Runtime.
  """
  def get_heap_usage() do
    {"Runtime.getHeapUsage", %{}}
  end

  @doc """
  Returns properties of a given object. Object group of the result is inherited from the target
  object.
  ## Parameters:
    - `objectId:RemoteObjectId`: Identifier of the object to return properties for.
    - `ownProperties:boolean`: (Optional) If true, returns properties belonging only to the element itself, not to its prototype
  chain.
    - `accessorPropertiesOnly:boolean`: (Optional) If true, returns accessor properties (with getter/setter) only; internal properties are not
  returned either.
    - `generatePreview:boolean`: (Optional) Whether preview should be generated for the results.
    - `nonIndexedPropertiesOnly:boolean`: (Optional) If true, returns non-indexed properties only.
  """
  def get_properties(
        object_id,
        own_properties \\ nil,
        accessor_properties_only \\ nil,
        generate_preview \\ nil,
        non_indexed_properties_only \\ nil
      ) do
    params =
      as_query([
        {"objectId", object_id},
        {"ownProperties", own_properties},
        {"accessorPropertiesOnly", accessor_properties_only},
        {"generatePreview", generate_preview},
        {"nonIndexedPropertiesOnly", non_indexed_properties_only}
      ])

    {"Runtime.getProperties", params}
  end

  @doc """
  Returns all let, const and class variables from global scope.
  ## Parameters:
    - `executionContextId:ExecutionContextId`: (Optional) Specifies in which execution context to lookup global scope variables.
  """
  def global_lexical_scope_names(execution_context_id \\ nil) do
    params = as_query([{"executionContextId", execution_context_id}])
    {"Runtime.globalLexicalScopeNames", params}
  end

  @doc """
  ## Parameters:
    - `prototypeObjectId:RemoteObjectId`: Identifier of the prototype to return objects for.
    - `objectGroup:string`: (Optional) Symbolic group name that can be used to release the results.
  """
  def query_objects(prototype_object_id, object_group \\ nil) do
    params = as_query([{"prototypeObjectId", prototype_object_id}, {"objectGroup", object_group}])
    {"Runtime.queryObjects", params}
  end

  @doc """
  Releases remote object with given id.
  ## Parameters:
    - `objectId:RemoteObjectId`: Identifier of the object to release.
  """
  def release_object(object_id) do
    params = as_query([{"objectId", object_id}])
    {"Runtime.releaseObject", params}
  end

  @doc """
  Releases all remote objects that belong to a given group.
  ## Parameters:
    - `objectGroup:string`: Symbolic object group name.
  """
  def release_object_group(object_group) do
    params = as_query([{"objectGroup", object_group}])
    {"Runtime.releaseObjectGroup", params}
  end

  @doc """
  Tells inspected instance to run if it was waiting for debugger to attach.
  """
  def run_if_waiting_for_debugger() do
    {"Runtime.runIfWaitingForDebugger", %{}}
  end

  @doc """
  Runs script with given id in a given context.
  ## Parameters:
    - `scriptId:ScriptId`: Id of the script to run.
    - `executionContextId:ExecutionContextId`: (Optional) Specifies in which execution context to perform script run. If the parameter is omitted the
  evaluation will be performed in the context of the inspected page.
    - `objectGroup:string`: (Optional) Symbolic group name that can be used to release multiple objects.
    - `silent:boolean`: (Optional) In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
    - `includeCommandLineAPI:boolean`: (Optional) Determines whether Command Line API should be available during the evaluation.
    - `returnByValue:boolean`: (Optional) Whether the result is expected to be a JSON object which should be sent by value.
    - `generatePreview:boolean`: (Optional) Whether preview should be generated for the result.
    - `awaitPromise:boolean`: (Optional) Whether execution should `await` for resulting value and return once awaited promise is
  resolved.
  """
  def run_script(
        script_id,
        execution_context_id \\ nil,
        object_group \\ nil,
        silent \\ nil,
        include_command_line_api \\ nil,
        return_by_value \\ nil,
        generate_preview \\ nil,
        await_promise \\ nil
      ) do
    params =
      as_query([
        {"scriptId", script_id},
        {"executionContextId", execution_context_id},
        {"objectGroup", object_group},
        {"silent", silent},
        {"includeCommandLineAPI", include_command_line_api},
        {"returnByValue", return_by_value},
        {"generatePreview", generate_preview},
        {"awaitPromise", await_promise}
      ])

    {"Runtime.runScript", params}
  end

  @doc """
  Enables or disables async call stacks tracking.
  ## Parameters:
    - `maxDepth:integer`: Maximum depth of async call stacks. Setting to `0` will effectively disable collecting async
  call stacks (default).
  """
  def set_async_call_stack_depth(max_depth) do
    params = as_query([{"maxDepth", max_depth}])
    {"Runtime.setAsyncCallStackDepth", params}
  end

  @doc """
  ## Parameters:
    - `enabled:boolean`: description not provided :(
  """
  def set_custom_object_formatter_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Runtime.setCustomObjectFormatterEnabled", params}
  end

  @doc """
  ## Parameters:
    - `size:integer`: description not provided :(
  """
  def set_max_call_stack_size_to_capture(size) do
    params = as_query([{"size", size}])
    {"Runtime.setMaxCallStackSizeToCapture", params}
  end

  @doc """
  Terminate current or next JavaScript execution.
  Will cancel the termination when the outer-most script execution ends.
  """
  def terminate_execution() do
    {"Runtime.terminateExecution", %{}}
  end

  @doc """
  If executionContextId is empty, adds binding with the given name on the
  global objects of all inspected contexts, including those created later,
  bindings survive reloads.
  Binding function takes exactly one argument, this argument should be string,
  in case of any other input, function throws an exception.
  Each binding function call produces Runtime.bindingCalled notification.
  ## Parameters:
    - `name:string`: description not provided :(
    - `executionContextId:ExecutionContextId`: (Optional) If specified, the binding would only be exposed to the specified
  execution context. If omitted and `executionContextName` is not set,
  the binding is exposed to all execution contexts of the target.
  This parameter is mutually exclusive with `executionContextName`.
  Deprecated in favor of `executionContextName` due to an unclear use case
  and bugs in implementation (crbug.com/1169639). `executionContextId` will be
  removed in the future.
    - `executionContextName:string`: (Optional) If specified, the binding is exposed to the executionContext with
  matching name, even for contexts created after the binding is added.
  See also `ExecutionContext.name` and `worldName` parameter to
  `Page.addScriptToEvaluateOnNewDocument`.
  This parameter is mutually exclusive with `executionContextId`.
  """
  def add_binding(name, execution_context_id \\ nil, execution_context_name \\ nil) do
    params =
      as_query([
        {"name", name},
        {"executionContextId", execution_context_id},
        {"executionContextName", execution_context_name}
      ])

    {"Runtime.addBinding", params}
  end

  @doc """
  This method does not remove binding function from global object but
  unsubscribes current runtime agent from Runtime.bindingCalled notifications.
  ## Parameters:
    - `name:string`: description not provided :(
  """
  def remove_binding(name) do
    params = as_query([{"name", name}])
    {"Runtime.removeBinding", params}
  end

  @doc """
  This method tries to lookup and populate exception details for a
  JavaScript Error object.
  Note that the stackTrace portion of the resulting exceptionDetails will
  only be populated if the Runtime domain was enabled at the time when the
  Error was thrown.
  ## Parameters:
    - `errorObjectId:RemoteObjectId`: The error object for which to resolve the exception details.
  """
  def get_exception_details(error_object_id) do
    params = as_query([{"errorObjectId", error_object_id}])
    {"Runtime.getExceptionDetails", params}
  end
end
