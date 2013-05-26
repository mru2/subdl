# A model for representing a video file
module FreeboxDownloader

  class File

    VIDEO_EXTENSIONS = %w(mp4 mkv avi mpeg mpg wmv)

    attr_accessor :name, :size

    def initialize(opts)
      @name = opts[:name]
      @size = opts[:size]
    end

    def is_video?
      @name.match /\.(#{FreeboxDownloader::File::VIDEO_EXTENSIONS.join('|')})/
    end

  end

end