class Geo::Area
  include Mongoid::Document

  field :title, type: String

  belongs_to :city, class_name: 'Geo::City'
  belongs_to :country, class_name: 'Geo::Country'
  belongs_to :region, class_name: 'Geo::Region'
end