class ItemsController < ApplicationController
  

  def index
    @items = Item.all
    if params[:sort].present?
      case params[:sort]
      when 'equipment_name_asc'
        @items = @items.order(equipment_name: :asc)
      when 'equipment_name_desc'
        @items = @items.order(equipment_name: :desc)
      when 'consumable_name_asc'
        @items = @items.order(consumable_name: :asc)
      when 'consumable_name_desc'
        @items = @items.order(consumable_name: :desc)
      when 'next_inspection_date_asc'
        @items = @items.order(next_inspection_date: :asc)
      when 'next_inspection_date_desc'
        @items = @items.order(next_inspection_date: :desc)
      end
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
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
  end

  private
  
  def item_params
    params.require(:item).permit(:consumable_name, :consumable_model_number, :consumable_maker, :equipment_name, :equipment_model_number,
                                  :serial_number, :inspection_interval, :start_date)
  end
end
