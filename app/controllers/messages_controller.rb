class MessagesController < ApplicationController
  before_action :set_current_message, except: [:create, :index]

  def index
    @messages = Message.all
    render json: @messages, status: 200
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render json: {
                renspone:
                    {message: @message.message}
                  }
    else
      render json: @message.errors, status: 422
    end
  end

  def show
    render :show, status: 200
  end

  def update
    if @message.update(message_params)
      render :show, status: 200
    else
      render json: @message.errors, status: 422
    end
  end

  def destroy
    if @message.destroy
      render json: @message, status: 402
    end
  end

  #######
  private
  #######

    def set_current_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.permit(:message)
    end
end
