class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link
  has_one :user_link_note
  has_many :user_link_tags
  has_many :tags, through: :user_link_tags
  has_many :user_link_stars
end
