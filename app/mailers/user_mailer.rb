class UserMailer < ApplicationMailer
  def subsequent_expiration_notification(user, item, maintenance_history)
    @user = user
    @item = item
    @maintenance_history = maintenance_history
    mail(to: @user.email, subject: '消耗品の交換期限が近づいています')
  end

  def initial_expiration_notification(user, item)
    @user = user
    @item = item
    mail(to: @user.email, subject: '消耗品の交換期限が近づいています')
  end
end
