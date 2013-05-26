# The main module and its dependencies

require_relative './freebox_downloader/helpers.rb'
require_relative './freebox_downloader/torrent.rb'
require_relative './freebox_downloader/file.rb'
require_relative './freebox_downloader/torrent_searcher.rb'
require_relative './freebox_downloader/torrent_files_extractor.rb'
require_relative './freebox_downloader/subs_searcher.rb'


module FreeboxDownloader

  # Queries for a movie/tvshow, returns a list of matching torrents
  def self.query(query)

    torrents = FreeboxDownloader::TorrentSearcher.new(query, :limit => 10).results

    return torrents

  end


  # Returns the sub files matching a torrent
  def self.subs(torrent_file_url)

    files = FreeboxDownloader::TorrentFilesExtractor.new(torrent_file_url).video_files

    subs = files.map do |file|
      FreeboxDownloader::SubsSearcher.new(file).find_by_size
    end

    return subs.compact

  end

end