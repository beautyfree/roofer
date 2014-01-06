class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :target_type, type: String
  field :target_id, type: String

  field :amount, type: Float
  field :balance, type: Float

  belongs_to :user

  validate :positive_balance
  validates_inclusion_of :target_type, in: %[balance roof]

  before_save :convert_currency
  # Просчитываем новое значение баланса
  before_save :update_balance

  def convert_currency
    bonus_table = {
        30 => 1,
        50 => 5,
        100 => 15,
        250 => 50
    }
    currency = 7

    if target_type == 'balance'
      self.amount = self.amount / currency

      # Алгоритм начисления бонусов
      bonus = 0
      bonus_table.each do |v,b|
          if (self.amount >= v)
              _bonus = (self.amount * b / v).floor
              if (_bonus > bonus)
                  bonus = _bonus
              end
          end
      end
      self.amount += bonus
    end
  end

  def update_balance
    t = Transaction.where(user_id: self.user_id).first
    if t
      self.balance = t.balance + self.amount
    else
      self.balance = self.amount.to_f
    end
  end

  # Валидация на наличие средств для покупки
  def positive_balance
    if target_type == 'roof'
      t = Transaction.where(user_id: self.user_id).first
      if !t || (t && (t.balance + amount) < 0)
        errors.add(:balance, "you don't have enought rockets")
      end
    end
  end

  default_scope order_by(:created_at => :desc)
end
