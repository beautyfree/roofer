class Roof::Photo
  include Rails.application.routes.url_helpers
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :image, :image_cache, :user_id

  mount_uploader :image, PhotoUploader

  embedded_in :roof, inverse_of: :photos
  belongs_to :user

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
        "name" => read_attribute(:image),
        "size" => image.size,
        "url" => image.url,
        "thumbnail_url" => image.thumb.url,
        "delete_url" => roof_photo_path(roof, _id),
        "delete_type" => "DELETE"
    }
  end
end
