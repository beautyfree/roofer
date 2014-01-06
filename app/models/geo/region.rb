class Geo::Region
  include Mongoid::Document

  field :vk_id, type: Integer
  field :title, type: String

  belongs_to :country, class_name: 'Geo::Country'
  has_many :cities, class_name: 'Geo::City'
  has_many :areas, class_name: 'Geo::Area'
end