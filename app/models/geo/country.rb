class Geo::Country
  include Mongoid::Document

  field :vk_id, type: Integer
  field :title, type: String, localize: true

  has_many :cities, class_name: 'Geo::City'
  has_many :regions, class_name: 'Geo::Region'
end