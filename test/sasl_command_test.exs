defmodule SaslCommandTest do
  use ExUnit.Case
  doctest SaslCommand
  alias SaslEx

  test "list mechanism" do
    assert SaslCommand.list_mechanism == %SaslEx{magic: 0x80, opcode: 0x20}
  end
end
