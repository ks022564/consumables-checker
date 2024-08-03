class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :show, :destroy, :update]

  def index
    @items = Item.all
    @items_with_maintenance_dates = @items.map do |item|
      latest_history = item.maintenance_histories.order(created_at: :desc).first
      previous_inspection_date = latest_history ? latest_history.exchange_date : item.start_date
      next_maintenance_day = latest_history&.next_maintenance_day || (previous_inspection_date + item.inspection_interval.days if previous_inspection_date && item.inspection_interval)

      {
        item: item,
        next_maintenance_day: next_maintenance_day
      }
    end
    if params[:days].present?
      days = params[:days].to_i
      @items_with_maintenance_dates.select! do |item_with_dates|
        item_with_dates[:next_maintenance_day] && item_with_dates[:next_maintenance_day] <= Date.today + days.days
      end
    end

    if params[:sort].present?
      case params[:sort]
      when 'equipment_name_asc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:item].equipment_name }
      when 'equipment_name_desc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:item].equipment_name }.reverse!
      when 'consumable_name_asc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:item].consumable_name }
      when 'consumable_name_desc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:item].consumable_name }.reverse!
      when 'next_inspection_date_asc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:next_maintenance_day] || Date.new(3000, 1, 1) }
      when 'next_inspection_date_desc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:next_maintenance_day] || Date.new(3000, 1, 1) }.reverse!
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
    @maintenance_history = @item.maintenance_histories.build

    latest_history = @item.maintenance_histories.order(created_at: :desc).first

    if latest_history
      @previous_inspection_date = latest_history.exchange_date
    else
      @previous_inspection_date = @item.start_date
    end

    history = @item.maintenance_histories.order(created_at: :desc).first
      if history
        @next_maintenance_day = history.next_maintenance_day
      else
        @next_maintenance_day = @item.start_date + @item.inspection_interval.days
      end
    @maintenance_comment = latest_history&.maintenance_comment
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  
  private
  
  def item_params
    params.require(:item).permit(:consumable_name, :consumable_model_number, :consumable_maker, :equipment_name, :equipment_model_number,
                                  :serial_number, :inspection_interval, :start_date)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
