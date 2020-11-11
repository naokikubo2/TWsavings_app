class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :current_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :hourly_pay, presence: true, length: { maximum: 6 }

  has_many :undone_actions, dependent: :destroy
  has_many :savings_records, dependent: :destroy
  has_many :comments, dependent: :destroy
end
