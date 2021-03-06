class MessagesController < ApplicationController
  def index
    id = params.fetch(:chatable_id)
    chat = params.fetch(:chatable_type)
    if id
      @messages = Message.limit(1000).order("created_at desc").where("chatable_id =? and chatable_type =?", id, chat).includes(:user)
      respond_to do |format|
        format.json do
          render json: @messages.reverse
        end
      end
    else
      @messages = Message.all
      redirect_to :back
    end
  end

  def update
    message = get_message
    if message.update(message_params)
      respond_to do |format|
        format.json do
          render json: { message: "Message updated" }
        end
      end
    end
  end

  def create
    chat_type = get_chat_type.find(params.fetch(:message).fetch(:chat_session_id))
    message = chat_type.messages.build(message_params)
    message.user_id = current_user.id
    if message.body[0..4] == "/roll"
      message.roll_dice
    end
    if message.save
      respond_to do |format|
        format.json do
          render json: { message: "Message posted!" }
        end
      end
    end
  end

  def destroy
    @message = get_message
    @message.destroy
    render json: { message: "Message deleted!" }
  end

  private
  def get_message
    Message.find(params.fetch(:id))
  end

  def message_params
    params.require(:message).permit(:body, :user_id, :chatable_id, :chatable_type)
  end

  def get_chat_type
    if params.fetch(:message).fetch(:chat_type) == "UserChat"
      UserChat
    elsif params.fetch(:message).fetch(:chat_type) == "ChatSession"
      ChatSession
    end
  end
end
