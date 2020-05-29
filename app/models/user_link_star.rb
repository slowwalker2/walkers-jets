class UserLinkStar < ApplicationRecord
  belongs_to :user
  belongs_to :user_link

  enum kind: {
    helpful: 1,
  }

  VALUE_MAX = 5
end
