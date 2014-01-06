class City
  include Mongoid::Document

  field :name, type: String
  field :alias, type: String

  embeds_many :areas
end
