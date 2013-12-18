class PagesController < ApplicationController
  def home
    @photos = Event.current.sorted_photos
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def about
  end
end
