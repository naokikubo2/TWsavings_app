class HomesController < ApplicationController
  def top
    if user_signed_in?
      @savings_records = SavingsRecord.where(user_id: current_user.id)
    end
  end
end
