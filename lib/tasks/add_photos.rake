namespace :photobooth do 
  desc "load photos"
  task :add_photos => :environment do
    Event.add_photos
  end
  
end