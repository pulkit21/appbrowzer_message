class UberController < ApplicationController

  def uber_request
    client_jid = params["client_jid"]
    card_id = params["card_id"]
    @uber_response = RequestProcessing.send_params(request, params)
    user_auth = JSON.parse @uber_response
    access_token = user_auth["access_token"]
    render json: "successfull", status: 200
    msg = {
      jid: client_jid,
      access_token: access_token,
      card_id: card_id
    }
    msg = ActiveSupport::JSON.encode(msg)
    $redis.publish "push.new", msg
  end
end
