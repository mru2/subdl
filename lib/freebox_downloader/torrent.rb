# A model for representing a piratebay torrent
module FreeboxDownloader

  class Torrent

    attr_reader :title, :url

    def initialize(opts)
      @title        = opts[:title]
      @url          = opts[:url]

      @id           = opts[:id]
      @magnet_link  = opts[:magnet_link]
      @torrent_link = opts[:torrent_link]

      raise ArgumentError.new('title, url, and id or torrent link must be defined') unless valid?
    end


    def torrent_file_url
      if @torrent_link
        torrent_link
      else
        get_torrent_link
      end
    end

    def download_link
      @magnet_link || torrent_file_url
    end

    private

    def valid?
      @title && @url && ( @id || @torrent_link )
    end

    # Builds a torrent link from its title and id
    def get_torrent_link
      "http://torrents.thepiratebay.se/"+@id+"/"+@title.gsub(/ /, '_')+"."+@id+".TPB.torrent"
    end

  end
  
end