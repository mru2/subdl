# Parses a torrent file for file names and sizes

require 'bencode'

module FreeboxDownloader

  class TorrentFilesExtractor

    include FreeboxDownloader::Helpers

    def initialize(torrent_url)
      @torrent = Net::HTTP.get(encode_uri torrent_url)
    end

    def video_files
      files = get_files

      return files.select(&:is_video?)
    end


    private

    def get_files
      info_hash = get_info_hash
      files_hash = extract_files(info_hash)

      return files_hash.map do |file_hash|
        FreeboxDownloader::File.new(file_hash)
      end
    end

    def get_info_hash
      meta = BEncode::Parser.new(@torrent).parse!
      return meta['info']
    end

    # Handlings cases for multiple and single files
    def extract_files(hash)
      if hash['files']
        files = hash['files'].flatten.map do |file_hash|
          {
            :name => file_hash['path'].last,
            :size => file_hash['length']
          }
        end
      else
        files = [{
          :name => file_hash['name'],
          :size => file_hash['length']
        }]
      end
    end

  end
  
end




# def get_torrent_filenames(torrent)

#   

#   # Different case wether there is one file or multiple
#   if meta["info"]["files"]
#     filenames = meta["info"]["files"].map{|file|file["path"]}
#   else
#     filenames = [ meta["info"]["name"] ]
#   end

#   puts "got info, #{meta['info']}"


# end
