require 'json'

class API::RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    render :json => {:success => true}.to_json
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    render :json => {:success => true}.to_json
  end
end