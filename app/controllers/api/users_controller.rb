require 'json'

class API::UsersController < ApplicationController
  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :feed]
  #before_action :admin_user, only: :destroy
  skip_before_action  :verify_authenticity_token
  
  def index
    @users = User.all
    #puts "{user: #{@users.to_json}}"
    #respond_to do |format|
    #  format.html
    #  format.json{
    #    render :json => {:users => @users}.to_json
    #  }
    #end
    render :json => {:users => @users}.to_json
  end
  
  def show
    @user = User.find(params[:id])
    render :json => {:users => @user}.to_json
  end
  
  def new
    @user = User.new
    render :json => {:users => @user}.to_json
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      render :json => {:users => @user}.to_json
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def feed
    @user = User.find(params[:id])
    @microposts = @user.feed.paginate(page: params[:page])
    render :json => {:feed => @microposts}.to_json
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render :json => {:user => @user, :following => @users}.to_json
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render :json => {:user => @user, :followers => @users}.to_json
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end
  
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
    store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end