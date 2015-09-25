require 'uri'
require 'net/http'

module BookingProcessing

  def self.send_params(return_uri, params)
    url = URI("https://tablebook.herokuapp.com/oauth/token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    booking_client_id = "bf50f847a8371e710182120cdedf665dbf378254a9ac1bdf637fca0a8570600a"
    booking_client_secret "6017635e0c82b8c597b469e16330c622ac68b276cff77d74466c0845910df423"
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    code_params = params[:code]
    request_url = "#{return_uri.protocol}#{return_uri.host}/api/booking_request"
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'multipart/form-data; boundary=---011000010111000001101001'
    request.body = "-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"client_secret\"\r\n\r\n6017635e0c82b8c597b469e16330c622ac68b276cff77d74466c0845910df423\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"client_id\"\r\n\r\nbf50f847a8371e710182120cdedf665dbf378254a9ac1bdf637fca0a8570600a\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"grant_type\"\r\n\r\nauthorization_code\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"redirect_uri\"\r\n\r\n#{request_url}\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"code\"\r\n\r\n#{code_params}\r\n-----011000010111000001101001--"
    response = http.request(request)
    response.read_body
  end
end
