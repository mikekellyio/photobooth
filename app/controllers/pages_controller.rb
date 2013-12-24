class PagesController < ApplicationController
  def home
    if params[:lastPhoto]
      @photos = Event.current.more_recent_than(params[:lastPhoto])
    else
      @photos = Event.current.sorted_photos.limit(10)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def about
  end
end
