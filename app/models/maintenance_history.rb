class MaintenanceHistory < ApplicationRecord
  belongs_to :item
  scope :latest, -> { order(created_at: :desc).first }

  belongs_to :user

  validates :exchange_date, presence: true
  validates :next_maintenance_day, presence: true
  validates :maintenance_comment, presence: true
  validates :worker, presence: true
end
