class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :current_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :undone_actions, dependent: :destroy
  has_many :savings_records, dependent: :destroy
end
