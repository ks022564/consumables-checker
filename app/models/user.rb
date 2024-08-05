class User < ApplicationRecord
  attr_accessor :company_name

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, authentication_keys: [:email, :company_name]

  belongs_to :company, optional: true
  has_many :maintenance_histories
  has_many :items

  before_validation :assign_company

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :company_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validate :password_complexity
  validate :password_confirmation_matches, if: -> { password.present? }
  validate :unique_email_within_company

  private

  def assign_company
    self.company = Company.find_or_create_by(company_name: company_name) if company_name.present?
  end

  def unique_email_within_company
    if company.present? && User.where(email: email, company_id: company.id).exists?
      errors.add(:email, "is already taken within this company")
    end
  end
    #単体テストコード################################################
  def password_complexity
    return if password.blank? || password =~ PASSWORD_REGEX
    errors.add :password, 'must include both letters and numbers'
  end

  def password_confirmation_matches
    return if password == password_confirmation
    errors.add :password_confirmation, "doesn't match Password"
  end
  ###################################################################
  def self.find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    company_name = conditions.delete(:company_name)
    email = conditions.delete(:email)
    joins(:company).where(companies: { company_name: company_name }).where(["lower(email) = :value", { value: email.downcase }]).first
  end
end