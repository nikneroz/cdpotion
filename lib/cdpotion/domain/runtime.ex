defmodule CDPotion.Domain.Runtime do
  use CDPotion.Utils

  @typedoc "Represents function call argument. Either remote object id `objectId`, primitive `value`,
unserializable primitive value or neither of (for undefined) them should be specified."
  @type call_argument :: %{
          objectId: CDPotion.Domain.Runtime.remote_object_id() | nil,
          unserializableValue: CDPotion.Domain.Runtime.unserializable_value() | nil,
          value: any() | nil
        }

  @typedoc "Stack entry for runtime errors and assertions."
  @type call_frame :: %{
          columnNumber: integer(),
          functionName: String.t(),
          lineNumber: integer(),
          scriptId: CDPotion.Domain.Runtime.script_id(),
          url: String.t()
        }

  @typedoc "description not provided :("
  @type custom_preview :: %{
          bodyGetterId: CDPotion.Domain.Runtime.remote_object_id() | nil,
          header: String.t()
        }

  @typedoc "Represents deep serialized value."
  @type deep_serialized_value :: %{
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

  @typedoc "description not provided :("
  @type entry_preview :: %{
          key: CDPotion.Domain.Runtime.object_preview() | nil,
          value: CDPotion.Domain.Runtime.object_preview()
        }

  @typedoc "Detailed information about exception (or error) that was thrown during script compilation or
execution."
  @type exception_details :: %{
          columnNumber: integer(),
          exception: CDPotion.Domain.Runtime.remote_object() | nil,
          exceptionId: integer(),
          exceptionMetaData: map() | nil,
          executionContextId: CDPotion.Domain.Runtime.execution_context_id() | nil,
          lineNumber: integer(),
          scriptId: CDPotion.Domain.Runtime.script_id() | nil,
          stackTrace: CDPotion.Domain.Runtime.stack_trace() | nil,
          text: String.t(),
          url: String.t() | nil
        }

  @typedoc "Description of an isolated world."
  @type execution_context_description :: %{
          auxData: map() | nil,
          id: CDPotion.Domain.Runtime.execution_context_id(),
          name: String.t(),
          origin: String.t(),
          uniqueId: String.t()
        }

  @typedoc "Id of an execution context."
  @type execution_context_id :: integer()

  @typedoc "Object internal property descriptor. This property isn't normally visible in JavaScript code."
  @type internal_property_descriptor :: %{
          name: String.t(),
          value: CDPotion.Domain.Runtime.remote_object() | nil
        }

  @typedoc "Object containing abbreviated remote object value."
  @type object_preview :: %{
          description: String.t() | nil,
          entries: list(CDPotion.Domain.Runtime.entry_preview()) | nil,
          overflow: boolean(),
          properties: list(CDPotion.Domain.Runtime.property_preview()),
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

  @typedoc "Object private field descriptor."
  @type private_property_descriptor :: %{
          get: CDPotion.Domain.Runtime.remote_object() | nil,
          name: String.t(),
          set: CDPotion.Domain.Runtime.remote_object() | nil,
          value: CDPotion.Domain.Runtime.remote_object() | nil
        }

  @typedoc "Object property descriptor."
  @type property_descriptor :: %{
          configurable: boolean(),
          enumerable: boolean(),
          get: CDPotion.Domain.Runtime.remote_object() | nil,
          isOwn: boolean() | nil,
          name: String.t(),
          set: CDPotion.Domain.Runtime.remote_object() | nil,
          symbol: CDPotion.Domain.Runtime.remote_object() | nil,
          value: CDPotion.Domain.Runtime.remote_object() | nil,
          wasThrown: boolean() | nil,
          writable: boolean() | nil
        }

  @typedoc "description not provided :("
  @type property_preview :: %{
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
          valuePreview: CDPotion.Domain.Runtime.object_preview() | nil
        }

  @typedoc "Mirror object referencing original JavaScript object."
  @type remote_object :: %{
          className: String.t() | nil,
          customPreview: CDPotion.Domain.Runtime.custom_preview() | nil,
          deepSerializedValue: CDPotion.Domain.Runtime.deep_serialized_value() | nil,
          description: String.t() | nil,
          objectId: CDPotion.Domain.Runtime.remote_object_id() | nil,
          preview: CDPotion.Domain.Runtime.object_preview() | nil,
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
          unserializableValue: CDPotion.Domain.Runtime.unserializable_value() | nil,
          value: any() | nil,
          webDriverValue: CDPotion.Domain.Runtime.deep_serialized_value() | nil
        }

  @typedoc "Unique object identifier."
  @type remote_object_id :: String.t()

  @typedoc "Unique script identifier."
  @type script_id :: String.t()

  @typedoc "Represents options for serialization. Overrides `generatePreview`, `returnByValue` and
`generateWebDriverValue`."
  @type serialization_options :: %{
          additionalParameters: map() | nil,
          maxDepth: integer() | nil,
          serialization: :deep | :json | :idOnly
        }

  @typedoc "Call frames for assertions or error messages."
  @type stack_trace :: %{
          callFrames: list(CDPotion.Domain.Runtime.call_frame()),
          description: String.t() | nil,
          parent: CDPotion.Domain.Runtime.stack_trace() | nil,
          parentId: CDPotion.Domain.Runtime.stack_trace_id() | nil
        }

  @typedoc "If `debuggerId` is set stack trace comes from another debugger and can be resolved there. This
allows to track cross-debugger calls. See `Runtime.StackTrace` and `Debugger.paused` for usages."
  @type stack_trace_id :: %{
          debuggerId: CDPotion.Domain.Runtime.unique_debugger_id() | nil,
          id: String.t()
        }

  @typedoc "Number of milliseconds."
  @type time_delta :: number()

  @typedoc "Number of milliseconds since epoch."
  @type timestamp :: number()

  @typedoc "Unique identifier of current debugger."
  @type unique_debugger_id :: String.t()

  @typedoc "Primitive value which cannot be JSON-stringified. Includes values `-0`, `NaN`, `Infinity`,
`-Infinity`, and bigint literals."
  @type unserializable_value :: String.t()

  @doc """
  Add handler to promise with given promise object id.
  ## Parameters:
    - (Required) `promise_object_id`: Identifier of the promise.
  - (Optional) `return_by_value`: Whether the result is expected to be a JSON object that should be sent by value.
  - (Optional) `generate_preview`: Whether preview should be generated for the result.
  """
  @spec await_promise(CDPotion.Domain.Runtime.remote_object_id(), boolean(), boolean()) ::
          {String.t(), map()}
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
    - (Required) `function_declaration`: Declaration of the function to call.
  - (Optional) `object_id`: Identifier of the object to call function on. Either objectId or executionContextId should
  be specified.
  - (Optional) `arguments`: Call arguments. All call arguments must belong to the same JavaScript world as the target
  object.
  - (Optional) `silent`: In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
  - (Optional) `return_by_value`: Whether the result is expected to be a JSON object which should be sent by value.
  Can be overriden by `serializationOptions`.
  - (Optional) `generate_preview`: Whether preview should be generated for the result.
  - (Optional) `user_gesture`: Whether execution should be treated as initiated by user in the UI.
  - (Optional) `await_promise`: Whether execution should `await` for resulting value and return once awaited promise is
  resolved.
  - (Optional) `execution_context_id`: Specifies execution context which global object will be used to call function on. Either
  executionContextId or objectId should be specified.
  - (Optional) `object_group`: Symbolic group name that can be used to release multiple objects. If objectGroup is not
  specified and objectId is, objectGroup will be inherited from object.
  - (Optional) `throw_on_side_effect`: Whether to throw an exception if side effect cannot be ruled out during evaluation.
  - (Optional) `unique_context_id`: An alternative way to specify the execution context to call function on.
  Compared to contextId that may be reused across processes, this is guaranteed to be
  system-unique, so it can be used to prevent accidental function call
  in context different than intended (e.g. as a result of navigation across process
  boundaries).
  This is mutually exclusive with `executionContextId`.
  - (Optional) `generate_web_driver_value`: Deprecated. Use `serializationOptions: {serialization:"deep"}` instead.
  Whether the result should contain `webDriverValue`, serialized according to
  https://w3c.github.io/webdriver-bidi. This is mutually exclusive with `returnByValue`, but
  resulting `objectId` is still provided.
  - (Optional) `serialization_options`: Specifies the result serialization. If provided, overrides
  `generatePreview`, `returnByValue` and `generateWebDriverValue`.
  """
  @spec call_function_on(
          String.t(),
          CDPotion.Domain.Runtime.remote_object_id(),
          list(CDPotion.Domain.Runtime.call_argument()),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          CDPotion.Domain.Runtime.execution_context_id(),
          String.t(),
          boolean(),
          String.t(),
          boolean(),
          CDPotion.Domain.Runtime.serialization_options()
        ) :: {String.t(), map()}
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
    - (Required) `expression`: Expression to compile.
  - (Required) `source_url`: Source url to be set for the script.
  - (Required) `persist_script`: Specifies whether the compiled script should be persisted.
  - (Optional) `execution_context_id`: Specifies in which execution context to perform script run. If the parameter is omitted the
  evaluation will be performed in the context of the inspected page.
  """
  @spec compile_script(
          String.t(),
          String.t(),
          boolean(),
          CDPotion.Domain.Runtime.execution_context_id()
        ) :: {String.t(), map()}
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
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Runtime.disable", %{}}
  end

  @doc """
  Discards collected exceptions and console API calls.
  """
  @spec discard_console_entries() :: {String.t(), map()}
  def discard_console_entries() do
    {"Runtime.discardConsoleEntries", %{}}
  end

  @doc """
  Enables reporting of execution contexts creation by means of `executionContextCreated` event.
  When the reporting gets enabled the event will be sent immediately for each existing execution
  context.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Runtime.enable", %{}}
  end

  @doc """
  Evaluates expression on global object.
  ## Parameters:
    - (Required) `expression`: Expression to evaluate.
  - (Optional) `object_group`: Symbolic group name that can be used to release multiple objects.
  - (Optional) `include_command_line_api`: Determines whether Command Line API should be available during the evaluation.
  - (Optional) `silent`: In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
  - (Optional) `context_id`: Specifies in which execution context to perform evaluation. If the parameter is omitted the
  evaluation will be performed in the context of the inspected page.
  This is mutually exclusive with `uniqueContextId`, which offers an
  alternative way to identify the execution context that is more reliable
  in a multi-process environment.
  - (Optional) `return_by_value`: Whether the result is expected to be a JSON object that should be sent by value.
  - (Optional) `generate_preview`: Whether preview should be generated for the result.
  - (Optional) `user_gesture`: Whether execution should be treated as initiated by user in the UI.
  - (Optional) `await_promise`: Whether execution should `await` for resulting value and return once awaited promise is
  resolved.
  - (Optional) `throw_on_side_effect`: Whether to throw an exception if side effect cannot be ruled out during evaluation.
  This implies `disableBreaks` below.
  - (Optional) `timeout`: Terminate execution after timing out (number of milliseconds).
  - (Optional) `disable_breaks`: Disable breakpoints during execution.
  - (Optional) `repl_mode`: Setting this flag to true enables `let` re-declaration and top-level `await`.
  Note that `let` variables can only be re-declared if they originate from
  `replMode` themselves.
  - (Optional) `allow_unsafe_eval_blocked_by_csp`: The Content Security Policy (CSP) for the target might block 'unsafe-eval'
  which includes eval(), Function(), setTimeout() and setInterval()
  when called with non-callable arguments. This flag bypasses CSP for this
  evaluation and allows unsafe-eval. Defaults to true.
  - (Optional) `unique_context_id`: An alternative way to specify the execution context to evaluate in.
  Compared to contextId that may be reused across processes, this is guaranteed to be
  system-unique, so it can be used to prevent accidental evaluation of the expression
  in context different than intended (e.g. as a result of navigation across process
  boundaries).
  This is mutually exclusive with `contextId`.
  - (Optional) `generate_web_driver_value`: Deprecated. Use `serializationOptions: {serialization:"deep"}` instead.
  Whether the result should contain `webDriverValue`, serialized
  according to
  https://w3c.github.io/webdriver-bidi. This is mutually exclusive with `returnByValue`, but
  resulting `objectId` is still provided.
  - (Optional) `serialization_options`: Specifies the result serialization. If provided, overrides
  `generatePreview`, `returnByValue` and `generateWebDriverValue`.
  """
  @spec evaluate(
          String.t(),
          String.t(),
          boolean(),
          boolean(),
          CDPotion.Domain.Runtime.execution_context_id(),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          CDPotion.Domain.Runtime.time_delta(),
          boolean(),
          boolean(),
          boolean(),
          String.t(),
          boolean(),
          CDPotion.Domain.Runtime.serialization_options()
        ) :: {String.t(), map()}
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
  @spec get_isolate_id() :: {String.t(), map()}
  def get_isolate_id() do
    {"Runtime.getIsolateId", %{}}
  end

  @doc """
  Returns the JavaScript heap usage.
  It is the total usage of the corresponding isolate not scoped to a particular Runtime.
  """
  @spec get_heap_usage() :: {String.t(), map()}
  def get_heap_usage() do
    {"Runtime.getHeapUsage", %{}}
  end

  @doc """
  Returns properties of a given object. Object group of the result is inherited from the target
  object.
  ## Parameters:
    - (Required) `object_id`: Identifier of the object to return properties for.
  - (Optional) `own_properties`: If true, returns properties belonging only to the element itself, not to its prototype
  chain.
  - (Optional) `accessor_properties_only`: If true, returns accessor properties (with getter/setter) only; internal properties are not
  returned either.
  - (Optional) `generate_preview`: Whether preview should be generated for the results.
  - (Optional) `non_indexed_properties_only`: If true, returns non-indexed properties only.
  """
  @spec get_properties(
          CDPotion.Domain.Runtime.remote_object_id(),
          boolean(),
          boolean(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
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
    - (Optional) `execution_context_id`: Specifies in which execution context to lookup global scope variables.
  """
  @spec global_lexical_scope_names(CDPotion.Domain.Runtime.execution_context_id()) ::
          {String.t(), map()}
  def global_lexical_scope_names(execution_context_id \\ nil) do
    params = as_query([{"executionContextId", execution_context_id}])
    {"Runtime.globalLexicalScopeNames", params}
  end

  @doc """

  ## Parameters:
    - (Required) `prototype_object_id`: Identifier of the prototype to return objects for.
  - (Optional) `object_group`: Symbolic group name that can be used to release the results.
  """
  @spec query_objects(CDPotion.Domain.Runtime.remote_object_id(), String.t()) ::
          {String.t(), map()}
  def query_objects(prototype_object_id, object_group \\ nil) do
    params = as_query([{"prototypeObjectId", prototype_object_id}, {"objectGroup", object_group}])
    {"Runtime.queryObjects", params}
  end

  @doc """
  Releases remote object with given id.
  ## Parameters:
    - (Required) `object_id`: Identifier of the object to release.
  """
  @spec release_object(CDPotion.Domain.Runtime.remote_object_id()) :: {String.t(), map()}
  def release_object(object_id) do
    params = as_query([{"objectId", object_id}])
    {"Runtime.releaseObject", params}
  end

  @doc """
  Releases all remote objects that belong to a given group.
  ## Parameters:
    - (Required) `object_group`: Symbolic object group name.
  """
  @spec release_object_group(String.t()) :: {String.t(), map()}
  def release_object_group(object_group) do
    params = as_query([{"objectGroup", object_group}])
    {"Runtime.releaseObjectGroup", params}
  end

  @doc """
  Tells inspected instance to run if it was waiting for debugger to attach.
  """
  @spec run_if_waiting_for_debugger() :: {String.t(), map()}
  def run_if_waiting_for_debugger() do
    {"Runtime.runIfWaitingForDebugger", %{}}
  end

  @doc """
  Runs script with given id in a given context.
  ## Parameters:
    - (Required) `script_id`: Id of the script to run.
  - (Optional) `execution_context_id`: Specifies in which execution context to perform script run. If the parameter is omitted the
  evaluation will be performed in the context of the inspected page.
  - (Optional) `object_group`: Symbolic group name that can be used to release multiple objects.
  - (Optional) `silent`: In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
  - (Optional) `include_command_line_api`: Determines whether Command Line API should be available during the evaluation.
  - (Optional) `return_by_value`: Whether the result is expected to be a JSON object which should be sent by value.
  - (Optional) `generate_preview`: Whether preview should be generated for the result.
  - (Optional) `await_promise`: Whether execution should `await` for resulting value and return once awaited promise is
  resolved.
  """
  @spec run_script(
          CDPotion.Domain.Runtime.script_id(),
          CDPotion.Domain.Runtime.execution_context_id(),
          String.t(),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
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
    - (Required) `max_depth`: Maximum depth of async call stacks. Setting to `0` will effectively disable collecting async
  call stacks (default).
  """
  @spec set_async_call_stack_depth(integer()) :: {String.t(), map()}
  def set_async_call_stack_depth(max_depth) do
    params = as_query([{"maxDepth", max_depth}])
    {"Runtime.setAsyncCallStackDepth", params}
  end

  @doc """

  ## Parameters:
    - (Required) `enabled`: description not provided :(
  """
  @spec set_custom_object_formatter_enabled(boolean()) :: {String.t(), map()}
  def set_custom_object_formatter_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Runtime.setCustomObjectFormatterEnabled", params}
  end

  @doc """

  ## Parameters:
    - (Required) `size`: description not provided :(
  """
  @spec set_max_call_stack_size_to_capture(integer()) :: {String.t(), map()}
  def set_max_call_stack_size_to_capture(size) do
    params = as_query([{"size", size}])
    {"Runtime.setMaxCallStackSizeToCapture", params}
  end

  @doc """
  Terminate current or next JavaScript execution.
  Will cancel the termination when the outer-most script execution ends.
  """
  @spec terminate_execution() :: {String.t(), map()}
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
    - (Required) `name`: description not provided :(
  - (Optional) `execution_context_id`: If specified, the binding would only be exposed to the specified
  execution context. If omitted and `executionContextName` is not set,
  the binding is exposed to all execution contexts of the target.
  This parameter is mutually exclusive with `executionContextName`.
  Deprecated in favor of `executionContextName` due to an unclear use case
  and bugs in implementation (crbug.com/1169639). `executionContextId` will be
  removed in the future.
  - (Optional) `execution_context_name`: If specified, the binding is exposed to the executionContext with
  matching name, even for contexts created after the binding is added.
  See also `ExecutionContext.name` and `worldName` parameter to
  `Page.addScriptToEvaluateOnNewDocument`.
  This parameter is mutually exclusive with `executionContextId`.
  """
  @spec add_binding(String.t(), CDPotion.Domain.Runtime.execution_context_id(), String.t()) ::
          {String.t(), map()}
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
    - (Required) `name`: description not provided :(
  """
  @spec remove_binding(String.t()) :: {String.t(), map()}
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
    - (Required) `error_object_id`: The error object for which to resolve the exception details.
  """
  @spec get_exception_details(CDPotion.Domain.Runtime.remote_object_id()) :: {String.t(), map()}
  def get_exception_details(error_object_id) do
    params = as_query([{"errorObjectId", error_object_id}])
    {"Runtime.getExceptionDetails", params}
  end
end
