class PhotosController < ApplicationController
  protect_from_forgery :except => :create 

  def index
    @photos = Event.current.sorted_photos
  end

  def show
    @photo = Event.current.photos.find(params[:id])
  end

  def create
    Event.add_photos
    redirect_to root_path
  end
end
