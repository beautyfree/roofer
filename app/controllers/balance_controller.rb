class BalanceController < ApplicationController
  before_filter :authenticate_user!
  layout 'pay', :only => :pay

  def index
    #@payment = Payment.create(amount: 10)
  end

  def pay
    rocket =  params[:rocket]
    @amount = rocket.to_i * 7
  end
end
