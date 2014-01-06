class Roof::Status
  include Mongoid::Document

  attr_accessible :status, :checked_at, :note, :image, :image_cache, :user_id

  field :status, type: Boolean
  field :checked_at, type: Time
  field :note, type: String
  mount_uploader :image, ImageUploader

  embedded_in :roof, inverse_of: :statuses
  belongs_to :user
end