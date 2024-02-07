defmodule <%= inspect context.module %>.AgentHandler do
  use GenServer

  require Logger

  @response_topic "responses"

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def broadcast_response(response_id, message) do
    <%= inspect context.web_module %>.Endpoint.broadcast(@response_topic, "new_response", {response_id, message})
  end

  def ask_prompt(prompt) do
    response_id = generate_response_id()

    # create a post request to the server
    GenServer.cast(
      __MODULE__,
      {:ask, prompt, response_id}
    )

    response_id
  end

  def generate_response_id() do
    response_id =
      :crypto.strong_rand_bytes(10)
      |> Base.encode16(case: :lower)

    response_id
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  @impl true
  def handle_cast(
        {:ask, prompt, response_id},
        _state
      ) do
    Logger.info("Anon user asked prompt: #{prompt}. Response ID: #{response_id}")

    IO.inspect("Mock agent is false", label: "mock agent")
    # ask_prompt(prompt, response_id)
    {:noreply, nil}
  end

end
