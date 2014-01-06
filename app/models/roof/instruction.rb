class Roof::Instruction
  include Mongoid::Document

  embeds_many :steps, class_name: 'Roof::Step', cascade_callbacks: true
  accepts_nested_attributes_for :steps, allow_destroy: true

  belongs_to :user
  embedded_in :roof, inverse_of: :instructions
end
