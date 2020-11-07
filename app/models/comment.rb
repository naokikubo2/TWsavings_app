class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :savings_record
  validates :content, presence: true
end
