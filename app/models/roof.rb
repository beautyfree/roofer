class Roof
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  field :location, :type => Array, :default => [0, 0]

  field :city, type: String
  field :state, type: String
  field :address, type: String

  field :cost, type: Integer, :default => 0

  field :status, type: Boolean
  field :checked_at, type: Time

  embeds_many :statuses, class_name: 'Roof::Status', cascade_callbacks: true
  embeds_many :photos, class_name: 'Roof::Photo', cascade_callbacks: true
  embeds_one :instruction, class_name: 'Roof::Instruction', cascade_callbacks: true
  belongs_to :user


  accepts_nested_attributes_for :instruction
  accepts_nested_attributes_for :statuses

  index({:location => "2d"}, { min: -200, max: 200 })

  def latitude
    location[0]
  end

  def latitude=( lat )
    self.location = [lat.to_f, self.location[1]]
  end

  def longitude
    location[1]
  end

  def longitude=( lng )
    self.location = [self.location[0], lng.to_f]
  end

  attr_accessible :steps_attributes, :photos_attributes, :instruction_attributes, :statuses_attributes, :user_id,
                  :status, :checked_at,
                  :location, :latitude, :longitude, :name, :city, :state, :address, :description, :cost, :instruction
end
