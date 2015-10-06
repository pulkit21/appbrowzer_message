class UberController < ApplicationController
  before_action :find_appbrowzer, only: [:create, :uber_request]

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

  def create
    logger.info "#{params}"
    logger.debug "#{params}"
    render json: "successfull", status: 200
  end

  def appbrowzer
    render json: {message: "hello appbrowzer people"}
  end
end
