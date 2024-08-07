class ItemCheckJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Item.check_expiration_dates
  end
end