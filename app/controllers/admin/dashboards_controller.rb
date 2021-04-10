class Admin::DashboardsController < ApplicationController

  def show
    today = Date.today
    @ongoin_campaigns = Campaign.includes(:survey)
                                .where('start_date <= ?', today)
                                .where('end_date >= ?', today)
                                .where(surveys: { user: current_user })
  end
end
