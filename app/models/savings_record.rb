class SavingsRecord < ApplicationRecord
  belongs_to :user
  validates :savings_name, presence: true, length: { maximum: 25 }
  validates :earned_time, presence: true, length: { maximum: 4 }
  validates :savings_date, presence: true
  validate :date_not_after_today

  def date_not_after_today
    unless savings_date.nil?
      errors.add(:savings_date, 'は今日以前のものを選択してください') if savings_date > Date.today
    end
  end
end
