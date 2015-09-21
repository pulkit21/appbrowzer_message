class BookingController < ApplicationController

  def booking_request
    client_jid = params["client_jid"]
    card_id = params["card_id"]
    @booking_response = BookingProcessing.send_params(request, params)
    user_auth = JSON.parse @booking_response
    access_token = user_auth["access_token"]
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

end
