require 'faraday'
require 'faraday_middleware'

module Service
  class OgpCollector
    def self.call(url:)
      self.new.call(url)      
    end

    def call(url)
      conn = Faraday.new url do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.adapter :net_http
        conn.headers = {'user-agent' => 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0'}
      end
      body = conn.get.body.force_encoding('UTF-8')
      
      # http://blog.livedoor.jp/sonots/archives/23652294.html
      body = body.encode('UTF-16BE', 'UTF-8', invalid: :replace, undef: :replace, replace: '?').encode('UTF-8')
      meta = body.scan(/<meta.*\s+*name.*="([^"]*)".*content.*="([^"]*)"/i).to_h
      # meta.transform_values! { |v| v = nil if v&.empty? }
      ogp = body.scan(/property\s*=\s*"og:([^"]*)"\s+content\s*=\s*"([^"]*)"/i).to_h
      # ogp.transform_values! { |v| v = nil if v&.empty? }

      ogp['title'] ||= (meta['description'] || body[/.*<title\s*>(.*)<\/title>.*/i, 1])
      ogp['description'] ||= meta['description']
      Link.new(
        title: ogp['title'],
        image: ogp['image'],
        url: ogp['url'],
        description: ogp['description'],
        locale: ogp['locale'],
        site_name: ogp['site_name']
      )
    end
  end
end
