require 'faraday'
require 'faraday_middleware'

module Service
  class LinkRegister
    def self.call(url:)
      self.new.call(url)      
    end

    def call(url)
      ApplicationRecord.transaction do
        ogp = OgpCollector.call(url: url)
        if ogp.present?
          link = Link.find_or_initialize_by(url: url)
          link.metadata = ogp
          link.save!
          user_link = UserLink.new(link_id: link.id)
          user_link.userdata = ogp
          user_link.save!
        end
        user_link
      end
    end
  end
end