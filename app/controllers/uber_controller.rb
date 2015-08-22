class UberController < ApplicationController

  def uber_request

    uber_code = params[:code]
    @uber_response = RequestProcessing.send_params(request, params)
    render json: @uber_response, status: 200
  end
end
