class PhotosController < ApplicationController
  protect_from_forgery :except => :create 
  def create
    Event.add_photos
    redirect_to root_path
  end
end
