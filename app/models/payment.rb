class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, :type => Integer
  field :invid, :type => Integer

  field :amount, :type => Float
end
