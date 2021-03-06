class UsersController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
      render :new
    end
  end

  def create
    if current_user
      redirect_to user_path(current_user)
    else
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to user_path(current_user)
      else
        redirect_to signup_path
      end
    end
  end

  def show
    @user = User.friendly.find(params[:username])
    render :show
  end

  def edit 
    id = params[:id]
    @user = User.find(id)
    render :edit
  end

  def update
    current_user.update_attributes(user_params)
    redirect_to user_path(current_user)
  end

  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :city, :username)
    end

    def page_user
      @page_user = User.friendly.find(params[:username])
    end
    helper_method :page_user

end
