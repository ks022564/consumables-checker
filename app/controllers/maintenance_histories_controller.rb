class MaintenanceHistoriesController < ApplicationController

  def new
    @maintenance_history = MaintenanceHistory.new
  end

  def create
    @maintenance_history = MaintenanceHistory.new(maintenance_history_params)

    if @maintenance_history.save
      @item = Item.find(params[:id])
    @maintenance_history = @item.maintenance_histories.build

    latest_history = @item.maintenance_histories.order(created_at: :desc).first

    if latest_history
      @previous_inspection_date = latest_history.exchange_date
    else
      @previous_inspection_date = @item.start_date
    end

    if @previous_inspection_date && @item.inspection_interval
      @next_maintenance_day = @previous_inspection_date + @item.inspection_interval.days
    end
      redirect_to @maintenance_history, notice: 'Maintenance history was successfully created.'
    else
      render :new
    end
  end



  private

  def maintenance_history_params
    params.require(:maintenance_history).permit(:exchange_date, :next_maintnance_day, :worker, :maintenance_comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end