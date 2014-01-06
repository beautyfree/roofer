class Geo::City
  include Mongoid::Document

  field :vk_id, type: Integer
  field :title, type: String
  field :important, type: Integer

  belongs_to :country, class_name: 'Geo::Country'
  belongs_to :region, class_name: 'Geo::Region'
  belongs_to :area, class_name: 'Geo::Area'
end