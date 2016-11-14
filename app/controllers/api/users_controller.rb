require 'json'

class API::UsersController < ApplicationController
  
  def index
    @users = User.all
    #puts "{user: #{@users.to_json}}"
    respond_to do |format|
    #format.html
    format.json{
      render :json => {:users => @users}.to_json
    } end
  end
  
  def show
    @user = User.find(params[:id])
    #puts "{user: #{@user.to_json}}"
    respond_to do |format|
    format.html
    format.json{
      render :json => {:user => @user}.to_json
    } end
  end
  
  def new
    @user = User.new
    #puts "{user: #{@user.to_json}}"
    respond_to do |format|
    format.html
    format.json{
      render :json => {:user => @user}.to_json
    } end
  end
  
end