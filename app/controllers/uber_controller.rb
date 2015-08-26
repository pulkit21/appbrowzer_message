class UberController < ApplicationController

  def uber_request
    client_jid = params["client_jid"]
    @uber_response = RequestProcessing.send_params(request, params)
    user_auth = JSON.parse @uber_response
    auth_token = user_auth["access_token"]
    render json: "successfull", status: 200
    msg = {
      jid: client_jid
      auth_token: auth_token
    }
    msg = ActiveSupport::JSON.encode(msg)
    $redis.publish "push.new", msg
  end
end
