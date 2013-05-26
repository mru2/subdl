# Query and format results from the piratebay

require 'thepiratebay'

module FreeboxDownloader

  class TorrentSearcher

    def initialize(query, opts)
      @query = query
      @limit = opts[:limit] || 5
    end

    def results(opts = {})
      @results ||= get_results
    end


    private

    # Queries thepiratebay and parses the results
    def get_results
      api_results = ThePirateBay::Search.new(@query, 0, ThePirateBay::SortBy::Seeders).results.first(@limit)
      return api_results.map{|result|parse_result(result)}
    end

    # Convert a result from the api in a torrent object
    def parse_result(res)
      FreeboxDownloader::Torrent.new({
        :title       => res[:title],
        :id          => res[:torrent_id],
        :url         => 'http://thepiratebay.sx' + res[:url],
        :magnet_link => res[:magnet_link]
      })
    end

  end
  
end