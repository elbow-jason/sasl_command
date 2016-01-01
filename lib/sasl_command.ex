defmodule SaslCommand do
  require SaslEx

  @magic_request           0x80
  @magic_response          0x81
  @opcode_list_mechanism   0x20

  def list_mechanism do
    %SaslEx{magic: @magic_request, opcode: @opcode_list_mechanism}
  end




end
