defmodule SaslCommand do
  require SaslEx

  @magic_request            128 # 0x80
  @magic_response           129 # 0x81

  @plain                    "PLAIN"
  @cram_md5                 "CRAM-MD5"
  @plain_and_cram_md5       "#{@plain} #{@cram_md5}"

  @opcode_list_mechanism    32  # 0x20
  @opcode_auth              33  # 0x21

  @status_success           0 # 0x0000


  def list_mechanism do
    %SaslEx{magic: @magic_request, opcode: @opcode_list_mechanism}
  end

  def list_mechanism_response_plain_cram_md5 do
    %SaslEx{
      magic:      @magic_response,
      opcode:     @opcode_list_mechanism,
      total_body: String.length(@plain_and_cram_md5),
      payload:    @plain_and_cram_md5,
    }
  end

  def list_mechanism_response_plain do
    %SaslEx{
      magic:      @magic_response,
      opcode:     @opcode_list_mechanism,
      total_body: String.length(@plain),
      payload:    @plain,
    }
  end

  def request_plain(auth_token) when auth_token |> is_binary do
    if byte_size(auth_token) != 10 do
      raise "SaslCommand.request_plain: auth_token must be exactly 10 bytes long"
    end
    payload = @plain <> auth_token
    %SaslEx{
      magic:      @magic_request,
      opcode:     @opcode_auth,
      key_length: 5,
      total_body: String.length(payload),
      payload:    payload,
    }
  end 

end
