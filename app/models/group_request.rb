class GroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: :group_id }

  enum :status, {
    pending: 0,
    approved: 1,
    rejected: 2
  }
end
