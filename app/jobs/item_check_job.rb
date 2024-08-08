class ItemCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Item.check_expiration_dates
  end
end
