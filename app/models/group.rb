class Group < ApplicationRecord
  belongs_to :user
  has_many :group_requests, dependent: :destroy

  has_many :approved_group_requests,
           -> { approved },
           class_name: "GroupRequest"

  has_many :members,
           through: :approved_group_requests,
           source: :user

  validates :name, presence: true
  validates :description,presence: true
  validates :rules, presence: true

  def self.search(keyword)
    if keyword.present?
      where(
        "name LIKE ? OR description LIKE ? OR rules LIKE ?",
        "%#{keyword}%",
        "%#{keyword}%",
        "%#{keyword}%"
      )
    else
      all
    end
  end
end
