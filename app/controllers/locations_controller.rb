class LocationsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    #@location = current_user.location.build()
  end
end
