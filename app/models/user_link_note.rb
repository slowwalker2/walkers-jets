class UserLinkNote < ApplicationRecord
  belongs_to :user
  belongs_to :user_link
end
