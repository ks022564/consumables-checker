class Item < ApplicationRecord
  scope :by_company, ->(company_id) { where(company_id: company_id) }

  belongs_to :company
  belongs_to :user
  has_many :maintenance_histories, dependent: :destroy

  validates :company, presence: true
  validates :consumable_name, presence: true
  validates :consumable_model_number, presence: true
  validates :consumable_maker, presence: true
  validates :equipment_name, presence: true
  validates :equipment_model_number, presence:true
  validates :serial_number, presence:true
  validates :inspection_interval, presence:true
  validates :start_date, presence:true
end
