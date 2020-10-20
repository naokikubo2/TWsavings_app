class UndoneAction < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :action_name, presence: true, length: { maximum: 25 }, uniqueness: true
  validates :default_time, presence: true, length: { maximum: 4 }
end
