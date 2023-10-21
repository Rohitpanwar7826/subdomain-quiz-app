class WelcomeController < ApplicationController
  before_action :authenticate_admin_user! 

  def index
    @planes = ::Plan.order(created_at: :desc).limit(5)
  end
end
