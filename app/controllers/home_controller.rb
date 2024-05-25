class HomeController < ApplicationController
  before_action :authenticate_user!
  layout :generate_layout_name

  def index
  end

  def daily_progress
    @results = Subdomain::Results::GetResultBuilder.call(current_user)
  end
end
