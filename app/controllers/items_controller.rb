class ItemsController < ApplicationController
  

  def index
    @items = Item.all
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

  private
  
  def item_params
    params.require(:item).permit(:consumable_name, :consumable_model_number, :consumable_maker, :equipment_name, :equipment_model_number,
                                  :serial_number, :inspection_interval, :start_date)
  end
end
