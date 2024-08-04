class MaintenanceHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company

  def index
    @maintenance_histories = @company.maintenance_histories.order(created_at: :desc).limit(30)
  end

  def new
    @maintenance_history = MaintenanceHistory.new
  end

  def create
    @item = @company.items.find(params[:item_id])
    @maintenance_history = @item.maintenance_histories.build(maintenance_history_params)
    @maintenance_history.user = current_user
    @maintenance_history.company = @company
    if @maintenance_history.save
        redirect_to @item
    else
      Rails.logger.error @maintenance_history.errors.full_messages
        redirect_to @item
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def maintenance_history_params
    params.require(:maintenance_history).permit(:exchange_date, :next_maintenance_day, :worker, :maintenance_comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end