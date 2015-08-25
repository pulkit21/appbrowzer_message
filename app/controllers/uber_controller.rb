class UberController < ApplicationController

  def uber_request

    uber_code = params[:code]
    @uber_response = RequestProcessing.send_params(request, params)
    render json: @uber_response, status: 200
    user_auth = JSON.parse @uber_response
    auth_token = user_auth["access_token"]
    msg = {
      jid: 'android1@roidsoftware.com',
      auth_token: auth_token
    }
    msg = ActiveSupport::JSON.encode(msg)
    $redis.publish "push.new", msg
  end
end
