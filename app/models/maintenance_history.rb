class MaintenanceHistory < ApplicationRecord
  belongs_to :item
  scope :latest, -> { order(created_at: :desc).first }

  belongs_to :user

  
end
