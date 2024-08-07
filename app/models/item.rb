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

  def self.check_expiration_dates
    # 初回の期限が近いアイテムを取得
    initial_items = Item.select('items.*, DATE_ADD(start_date, INTERVAL inspection_interval DAY) AS expiration_date')
                        .where("DATE_ADD(start_date, INTERVAL inspection_interval DAY) <= ?", Date.today + 7.days)
                        .where.not(id: MaintenanceHistory.pluck(:item_id))  # メンテナンス履歴が存在しないアイテムを取得
                        .distinct
  
    # 2回目以降の期限が近いアイテムを取得
    subsequent_items = Item.joins(:maintenance_histories)
                           .where("maintenance_histories.next_maintenance_day <= ?", Date.today + 7.days)
                           .distinct
  
    # 初回の期限が近いアイテムを処理
    initial_items.each do |item|
      # アイテムに関連するユーザーを取得
      item.company.users.each do |user|
        # メールを送信
        UserMailer.initial_expiration_notification(user, item).deliver_now  # 2つの引数で初回通知メソッドを呼び出し
      end
    end
  
    # 2回目以降の期限が近いアイテムを処理
    subsequent_items.each do |item|
      # 最新のメンテナンス履歴を取得
      latest_maintenance_history = item.maintenance_histories.order(next_maintenance_day: :desc).first
      next unless latest_maintenance_history
  
      # アイテムに関連するユーザーを取得
      item.company.users.each do |user|
        # メールを送信
        UserMailer.subsequent_expiration_notification(user, item, latest_maintenance_history).deliver_now  # 3つの引数で複数回通知メソッドを呼び出し
      end
    end
  end
end