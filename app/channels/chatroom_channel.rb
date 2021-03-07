class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel" pour les tring / stream_for pour des variables
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
end