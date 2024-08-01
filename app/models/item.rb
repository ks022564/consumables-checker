class Item < ApplicationRecord
  validates :consumable_name, presence: true
  validates :consumable_model_number, presence: true
  validates :consumable_maker, presence: true
  validates :equipment_name, presence: true
  validates :equipment_model_number, presence:true
  validates :serial_number, presence:true
  validates :inspection_interval, presence:true
  validates :start_date, presence:true
end
