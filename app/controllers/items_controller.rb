class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_company
  
  before_action :set_item, only: [:edit, :show, :destroy, :update]

  def index
    @items = @company.items

    # 各アイテムについて次回点検予定日を計算
    @items_with_maintenance_dates = @items.map do |item|
      latest_history = item.maintenance_histories.order(created_at: :desc).first
      previous_inspection_date = latest_history ? latest_history.exchange_date : item.start_date
      next_maintenance_day = latest_history&.next_maintenance_day || (previous_inspection_date + item.inspection_interval.days if previous_inspection_date && item.inspection_interval)

      {
        item: item,
        next_maintenance_day: next_maintenance_day
      }
    end

    # デフォルトで交換日時の近い順にソート
    @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:next_maintenance_day] || Date.new(3000, 1, 1) }

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
        when 'created_at_asc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:item].created_at }
      when 'created_at_desc'
        @items_with_maintenance_dates.sort_by! { |item_with_dates| item_with_dates[:item].created_at }.reverse!
      end
    end

    #「点検が近い消耗品のお知らせ」にだけ日数設定を適用
    @near_inspection_items = @items_with_maintenance_dates.dup
    if params[:days].present?
      days = params[:days].to_i
      @near_inspection_items.select! do |item_with_dates|
        item_with_dates[:next_maintenance_day] && item_with_dates[:next_maintenance_day] <= Date.today + days.days
      end
    else
      @near_inspection_items.select! do |item_with_dates|
        item_with_dates[:next_maintenance_day] && item_with_dates[:next_maintenance_day] <= Date.today + 7.days
      end
    end
  end


  def new
    @item = Item.new
  end

  def create
    @item = @company.items.new(item_params)
    @item.user = current_user
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

  def set_company
    @company = current_user.company
  end
  
  def item_params
    params.require(:item).permit(:consumable_name, :consumable_model_number, :consumable_maker, :equipment_name, :equipment_model_number,
                                  :serial_number, :inspection_interval, :start_date)
  end

  def set_item
    @item = @company.items.find(params[:id])
    
  end
end
