class Roof::Step
  include Mongoid::Document

  attr_accessible :description, :image, :image_cache

  field :description, type: String
  mount_uploader :image, ImageUploader

  embedded_in :instruction, inverse_of: :steps
end
