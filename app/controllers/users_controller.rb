class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "User created successfully"
    else
      render :new, alert: "Something went wrong"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password)
  end
end
