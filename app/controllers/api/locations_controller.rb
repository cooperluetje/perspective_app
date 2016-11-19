class API::LocationsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :destroy]
  skip_before_action  :verify_authenticity_token

  def create
    if(params.has_key?(:micropost))
      @micropost = current_user.microposts.find(params[:micropost])
      @location = @micropost.build_location(location_params)
      if @location.save
        render :json => {:success => true}.to_json
      else
        render :json => {:success => false, :error => "Picture not selected!"}.to_json
      end
    else
      @location = current_user.build_location(location_params)
      if @location.save
        render :json => {:success => true}.to_json
      else
        render :json => {:success => false, :error => "Picture not selected!"}.to_json
      end
    end
  end
  
  private
  
  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end