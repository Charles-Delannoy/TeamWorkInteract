class Admin::DashboardsController < ApplicationController

  def show
    today = Date.today
    @ongoin_campaigns = Campaign.where('start_date <= ?', today).where('end_date >= ?', today)
  end
end
