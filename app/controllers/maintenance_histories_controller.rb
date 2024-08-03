class MaintenanceHistoriesController < ApplicationController

  def index
    @maintenance_histories = MaintenanceHistory.all
    
  end

  def new
    @maintenance_history = MaintenanceHistory.new
  end

  def create
    @item = Item.find(params[:item_id])
    @maintenance_history = @item.maintenance_histories.build(maintenance_history_params)
    
    if @maintenance_history.save
      
      latest_history = @item.maintenance_histories.order(created_at: :desc).first

      if latest_history
        @previous_inspection_date = latest_history.exchange_date
      else
        @previous_inspection_date = @item.start_date
      end

      if @previous_inspection_date && @item.inspection_interval
        @next_maintenance_day = @previous_inspection_date + @item.inspection_interval.days
      end
        redirect_to @item
    else

      latest_history = @item.maintenance_histories.order(created_at: :desc).first

      if latest_history
        @previous_inspection_date = latest_history.exchange_date
      else
        @previous_inspection_date = @item.start_date
      end

      if @previous_inspection_date && @item.inspection_interval
        @next_maintenance_day = @previous_inspection_date + @item.inspection_interval.days
      end
        redirect_to @item
    end
  end

  private

  def maintenance_history_params
    params.require(:maintenance_history).permit(:exchange_date, :next_maintenance_day, :worker, :maintenance_comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end