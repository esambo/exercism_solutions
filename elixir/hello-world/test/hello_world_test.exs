if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("hello_world.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(trace: true)

defmodule HelloWorldTest do
  use ExUnit.Case

  test "says 'Hello, World!'" do
    assert HelloWorld.hello() == "Hello, World!"
  end

  test "says 'Hello, John'" do
    assert HelloWorld.hello("John") == "Hello, John!"
  end
end
