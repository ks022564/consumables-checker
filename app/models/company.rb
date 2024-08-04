class Company < ApplicationRecord
  has_many :users
  has_many :items
  has_many :maintenance_histories

  validates :company_name, presence: true
end
