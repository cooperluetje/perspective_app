require 'json'

class API::SessionsController < ApplicationController
  skip_before_action  :verify_authenticity_token
  
  def new
  end
  
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      render :json => {:success => true, :user => user}.to_json
    else
      render :json => {:success => false, :error => "Invalid username/password combination"}.to_json
    end
  end
  
  def verify
    user = User.find_by(username: params[:session][:username])
    if user.remember_digest == params[:session][:token]
      log_in user
      remember(user)
      render :json => {:success => true}.to_json
    else
      render :json => {:success => false}.to_json
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end