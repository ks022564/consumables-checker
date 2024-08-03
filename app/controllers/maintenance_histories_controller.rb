class MaintenanceHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @maintenance_histories = MaintenanceHistory.order(created_at: :desc).limit(30)
    
  end

  def new
    @maintenance_history = MaintenanceHistory.new
  end

  def create
    @item = Item.find(params[:item_id])
    @maintenance_history = @item.maintenance_histories.build(maintenance_history_params)
    
    if @maintenance_history.save
        redirect_to @item
    else
        redirect_to @item
    end
  end

  private

  def maintenance_history_params
    params.require(:maintenance_history).permit(:exchange_date, :next_maintenance_day, :worker, :maintenance_comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end