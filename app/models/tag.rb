class Tag < ApplicationRecord
  has_many :user_link_tags
  has_many :user_links, through: :user_link_tags
  
  def set_tags(keywords)
    user_links = UserLink.all
    tags = keywords.map do |keyword|
      Tag.find_or_create_by(name: keyword)
    end
  
    user_links.each do |user_link|
      tags.each do |tag|
        if user_link.metadata['title']&.downcase&.include?(tag.name.downcase)
          UserLinkTag.find_or_create_by(user_link_id: user_link.id, tag_id: tag.id)
        end
      end
    end
  end 
end
