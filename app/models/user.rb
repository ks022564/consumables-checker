class User < ApplicationRecord

attr_accessor :company_name

  scope :by_company, ->(company_id) { where(company_id: company_id) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :maintenance_histories
  belongs_to :company, optional: true
  has_many :items

  before_validation :assign_company
  
  validates :name, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX

  private

  def assign_company
    self.company = Company.find_or_create_by(company_name: company_name) if company_name.present?
  end
end
