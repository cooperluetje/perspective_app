require 'json'

class API::MicropostsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :destroy]
  #before_action :correct_user,   only: :destroy
  skip_before_action  :verify_authenticity_token

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      render :json => {:success => true}.to_json
    else
      render :json => {:success => false, :error => "Picture not selected!"}.to_json
    end
  end
  
  def index
    @microposts = current_user.microposts.paginate(:per_page => 10, :page => params[:page])
    render :json => {:microposts => @microposts}.to_json
  end
  
  def show
    @micropost = current_user.microposts.find(params[:id])
    render :json => {:micropost => @micropost}.to_json
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  def getLocation
    @micropost = Micropost.find(params[:id])
    @location = @micropost.location
    render :json => {:location => @location}.to_json
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end