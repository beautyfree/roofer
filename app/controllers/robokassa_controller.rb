class RobokassaController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token # skip before filter if you chosen POST request for callbacks

  before_filter :create_notification
  before_filter :find_payment

  # Robokassa call this action after transaction
  def paid
    if @notification.acknowledge # check if it’s genuine Robokassa request
      #@payment.approve! # project-specific code
      Transaction.find_or_create_by({
        amount: @notification.amount,
        user_id: params['shp_uid'],
        target_id: @notification.item_id,
        target_type: 'balance'
      })

      render :text => @notification.success_response
    else
      head :bad_request
    end
  end

  # Robokassa redirect user to this action if it’s all ok
  def success
    # !@payment.approved? &&
    if @notification.acknowledge
      p 1
      #@payment.approve!
    end

    #redirect_to @payment, :notice => I18n.t("notice.robokassa.success")
    redirect_to balance_url, :notice => I18n.t("notice.robokassa.success")
  end
  # Robokassa redirect user to this action if it’s not
  def fail
    redirect_to @payment, :notice => I18n.t("notice.robokassa.fail")
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => Roofer::Application.config.robokassa_secret2)
  end

  def find_payment
    #@payment = Payment.find(@notification.item_id)
  end
end
