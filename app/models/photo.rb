class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :file, type: String
  mount_uploader :file, FileUploader

  embedded_in :event
end