class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  helper_method :current_user
  layout :generate_layout_name
  
  def is_current_user
    current_user.sign_in?
  end
  private

  
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def record_not_found
    flash[:alert] = "The record you are looking in not present"
    redirect_to '/'
  end

  def generate_layout_name
    if current_user.present?
      current_user.roles.pluck(:name).include?('student') ? 'student' : 'teacher'
    end
  end
end
