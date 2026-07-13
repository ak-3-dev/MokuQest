class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :quests, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :group_requests, dependent: :destroy
  has_many :ai_plans, dependent: :destroy
  def current_level
    (exp / 100) + 1
  end
end
