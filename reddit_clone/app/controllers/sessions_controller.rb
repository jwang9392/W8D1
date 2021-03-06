class SessionsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :ensure_logged_in, only: [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      flash[:success] = ["Welcome back #{@user.username}"]
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = ["Invalid username or password. Try again"]
      render :new
    end
  end

  def destroy
    log_out!
  end

end