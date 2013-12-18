namespace :photobooth do 
  desc "load photos"
  task :add_photos => :environment do
    Dir.glob([Rails.root, "/ingest/**/*.jpg"].join).each do |file|
      puts "loading #{file}..."
      photo = Event.current.add_photo file
      File.unlink file if photo.valid?
    end
  end
  
end