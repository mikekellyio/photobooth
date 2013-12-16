class PagesController < ApplicationController
  def home
    @photos = Event.current.photos
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def about
  end
end
