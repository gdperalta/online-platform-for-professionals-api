class UsersController < ApplicationController
  def approve
    authorize User
    @user = User.find(params[:id])
    @user.approved = true

    if @user.save
      UserMailer.with(user: @user).approved_notification.deliver_later
      render json: UserSerializer.new(@user)
    else
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end
end
