class Admin::DashboardController < ApplicationController
  before_filter :verify_admin

  def index
  end

  private
  def verify_admin
    redirect_to root_url unless current_user.role? :admin
  end

end
