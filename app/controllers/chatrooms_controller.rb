class ChatroomsController < ApplicationController
  def new
    @user = User.find(params[:user].to_i)
    @chatrooms = Chatroom.includes(:chatroom_users)
                        .where(chatroom_users: { user: current_user })
                        .merge(Chatroom.includes(:chatroom_users)
                        .where(chatroom_users: { user: @user }))
    if @chatrooms.first
      retrieve_chatroom
    else
      create_chatroom
    end
    redirect_to chatroom_path(@chatroom, anchor: "bottom-chat")
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new()
    authorize @chatroom
    respond_to do |format|
      format.html do
        chatroom_user = ChatroomUser.where(chatroom: @chatroom, user: current_user).first
        chatroom_user.seen_at = DateTime.now
        chatroom_user.save
      end
      format.json { render json: { counter: @chatroom.new_message_counter(current_user) } }
    end
  end

  private

  def retrieve_chatroom
    @chatroom = @chatrooms.first
    authorize @chatroom
  end

  def create_chatroom
    @chatroom = Chatroom.new(name: "#{@user.full_name} & #{current_user.full_name}")
    authorize @chatroom
    @chatroom.save
    ChatroomUser.create(chatroom: @chatroom, user: current_user, seen_at: DateTime.now)
    ChatroomUser.create(chatroom: @chatroom, user: @user, seen_at: DateTime.now)
  end
end
