class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :ensure_logged_in, only: [:show]

  def index
    @users = User.all

    render :index
  end

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = ['User has been created']
      redirect_to user_url(@user)
    else  
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  private 

  def user_params
    params.require(:user).permit(:username, :password)
  end
end