require 'uri'
require 'net/http'

module RequestProcessing

  def self.send_params(return_uri, params)
    url = URI("https://login.uber.com/oauth/token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    code_params = params[:code]
    request_url = "#{return_uri.protocol}#{return_uri.host}/api/uber_request"
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'multipart/form-data; boundary=---011000010111000001101001'
    request.body = "-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"client_secret\"\r\n\r\nSjIhX-lHEJ4de-AS320Qq4yS1qfJ0j_UN1yHDOLB\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"client_id\"\r\n\r\nyUJEE_KqWDr-CJ4J9q0_VrIcpRutdmUU\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"grant_type\"\r\n\r\nauthorization_code\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"redirect_uri\"\r\n\r\n#{request_url}\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"code\"\r\n\r\n#{code_params}\r\n-----011000010111000001101001--"
    response = http.request(request)
    response.read_body
  end
end
