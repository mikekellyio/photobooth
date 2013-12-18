class PhotosController < ApplicationController
  protect_from_forgery :except => :create 
  def create
    Dir.glob([Rails.root, "/ingest/**/*.jpg"].join).each do |file|
      puts "loading #{file}..."
      @photo = Event.current.add_photo file
      File.unlink file if photo.valid?
    end
    redirect_to root_path
  end
end
