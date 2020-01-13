class SubsController < ApplicationController

  def index
    @subs = Sub.all

    render :index
  end

  def new
    @sub = Sub.new

    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      flash[:success] = ['Successfully created your Sub']
      redirect_to sub_url(@sub)
    else
      flash.now[:error] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])

    render :show
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub.id)
    else
      flash.now[:error] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end