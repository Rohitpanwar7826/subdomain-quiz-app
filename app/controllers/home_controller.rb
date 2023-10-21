class HomeController < ApplicationController
  before_action :authenticate_user!
  layout :generate_layout_name

  def index
  end

  private

  def generate_layout_name
    current_user.roles.pluck(:name).include?('student') ? 'student' : 'teacher'
  end
end
