class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :active, type: Boolean, default: false

  validate do
    errors.add(:active, 'Only one event can be active at a time.') unless Event.where(active: true).count <= 1
  end
  embeds_many :photos

  def activate!
    Event.where(active: true).find_and_modify({ "$set" => { active: false }})
    update_attributes(active: true)
  end
end