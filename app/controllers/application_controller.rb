class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :find_appbrowzer
  before_action :set_default_response_format

  def home

  end

  #######
  private
  #######

  def find_appbrowzer
    if request.headers["X-User-Agent"] == "appbrowzer"
      redirect_to '/api/appbrowzer' , status: 302
    end
  end

    def set_default_response_format
      request.format = :json
    end
end
