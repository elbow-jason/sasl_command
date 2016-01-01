defmodule SaslCommandTest do
  use ExUnit.Case
  doctest SaslCommand
  alias SaslEx

  test "list mechanism" do
    assert SaslCommand.list_mechanism == %SaslEx{magic: 128, opcode: 32}
  end

  test "list mechanism response plain" do
    expected = %SaslEx{magic: 129, opcode: 32, total_body: 5, payload: "PLAIN"}
    assert SaslCommand.list_mechanism_response_plain == expected
  end

  test "list mechanism response plain_and_cram_md5" do
    expected = %SaslEx{magic: 129, opcode: 32, total_body: 14, payload: "PLAIN CRAM-MD5"}
    assert SaslCommand.list_mechanism_response_plain_cram_md5 == expected
  end

  test "plain_request auth_token wrong size raises error" do
    err = "SaslCommand.request_plain: auth_token must be exactly 10 bytes long"
    assert_raise RuntimeError, err, fn ->
      SaslCommand.request_plain("too_short")
    end
  end

  test "plain_request works with correctly sized token" do
    expected = %SaslEx{
      key_length: 5,
      magic: 128,
      opcode: 33,
      payload: "PLAINjust_right",
      total_body: 15
    }
    assert SaslCommand.request_plain("just_right") == expected
  end


end
