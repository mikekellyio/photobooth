class PhotosController < ApplicationController
  protect_from_forgery :except => :create 

  def index
    @photos = event.sorted_photos
  end

  def show
    @photo = event.photos.find(params[:id])
  end

  def create
    Event.add_photos
    redirect_to root_path
  end

  def event
    @event = params[:event_id].present? ? Event.find(params[:event_id]) : Event.current
  end
end
