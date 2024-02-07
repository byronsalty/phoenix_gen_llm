defmodule PhoenixGenLlmTest do
  use ExUnit.Case
  doctest PhoenixGenLlm

  test "greets the world" do
    assert PhoenixGenLlm.hello() == :world
  end
end
