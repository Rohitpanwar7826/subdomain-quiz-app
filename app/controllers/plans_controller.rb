class PlansController < ApplicationController
  before_action :set_plan

  def show
    @account_plan = @plan.accounts.new
  end

  def create
    @account_plan = @plan.accounts.new(permit_account_params.merge({ admin_user_id: current_admin_user.id }))
    respond_to do |format|
      if @account_plan.save
        format.turbo_stream
      else
        format.turbo_stream { render :show, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_plan
      plan = Plan.find_by_id(params[:id] || params[:account][:plan])

      @plan = plan.present? ? plan : Plan.first
    end

    def permit_account_params
      params.require(:account).permit(:subdomain, :name, :title, :default_locale, :target_id)
    end
end
