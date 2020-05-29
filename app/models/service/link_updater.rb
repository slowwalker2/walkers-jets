require 'faraday'
require 'faraday_middleware'

module Service
  class LinkUpdater
    def self.call(user_id:, user_link_id:, params:)
      self.new.call(user_id, user_link_id, params)      
    end

    def call(user_id, user_link_id, params)
      user_link = UserLink.find(user_link_id)
      ApplicationRecord.transaction do
        userdata = {site_name: params[:site_name],
        title: params[:title],
        description: params[:description]}

        user_link.update!(userdata: userdata)
        
        user_link.note = UserLinkNote.create unless user_link.note.present?
        user_link.note.update!(body: params[:note])
        if params[:tags].present?
          user_link.user_link_tags.delete_all
          tags = params[:tags].split('#').map(&:strip).select(&:present?).compact
          tags.each do |tag_name|
            tag_id = Tag.find_or_create_by(name: "#{tag_name}").id
            UserLinkTag.create!(tag_id: tag_id, user_link_id: user_link.id)
          end
        end

        star_kinds = UserLinkStar.kinds
        star_kinds.keys.each do |star|
          if (0..(UserLinkStar::VALUE_MAX)).include?(params[star].to_i)
            s = UserLinkStar.find_or_create_by(user_link_id: user_link.id, kind: star.to_sym)
            s.value = params[star]
            s.save 
          end
        end
      end
      user_link
    end
  end
end