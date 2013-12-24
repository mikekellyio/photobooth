class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :active, type: Boolean, default: false

  validate do
    errors.add(:active, 'Only one event can be active at a time.') unless Event.where(active: true).count <= 1
  end
  embeds_many :photos

  def self.current
    event = Event.where(active: true).first_or_create
    event.name || event.update_attribute(:name, Date.today.to_s)
    event
  end

  def sorted_photos
    photos.order_by(:created_at.desc)
  end

  def most_recent_time
    sorted_photos.first.created_at
  end

  def more_recent_than time
    sorted_photos.gt(created_at: Integer(time)+1)
  end

  def activate!
    Event.where(active: true).find_and_modify({ "$set" => { active: false }})
    update_attributes(active: true)
  end

  def add_photo filename
    photo = photos.build
    photo.file = File.open filename
    photo.save
    photo
  end

  def self.add_photos
    Dir.glob([Rails.root, "/ingest/**/*.jpg"].join).each do |file|
      puts "loading #{file}..."
      @photo = Event.current.add_photo file
      FileUtils.mv file, "ingested/" if @photo.valid?
      #File.unlink file if @photo.valid?
    end
  end
end