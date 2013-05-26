# Query opensubtitles for the subs matching a video file

require 'nokogiri'

module FreeboxDownloader

  class SubsSearcher

    include FreeboxDownloader::Helpers

    def initialize(file)
      @video_file = file
    end

    # Look for a subtitle based on the file size
    def find_by_size
      query_url = build_query_url
      results_page = open query_url

      sub = get_top_result(results_page)
    end


    private

    def build_query_url
      encode_uri "http://www.opensubtitles.org/en/search/sublanguageid-all/moviebytesize-#{@video_file.size}/sort-7/asc-0"
    end

    def get_top_result(html)
      doc = Nokogiri::HTML(html)

      if !doc.css('.msg.warn').empty? && doc.css('.msg.warn').first.text.match(/No results found/)
        return nil
      end

      top_result_link = doc.css('#search_results tr[2] td strong a').first

      if top_result_link.nil?
        return nil
      else
        return build_sub_from_link(top_result_link)
      end
    end

    def build_sub_from_link(dom_link)
      sub_page_url = dom_link.attr('href')
      sub_id = sub_page_url.match(/\/en\/subtitles\/(\d+)\//)[1]

      sub_download_url = "http://dl.opensubtitles.org/fr/download/sub/#{sub_id}"

      return {
        :name => dom_link.text,
        :url => sub_page_url,
        :file => sub_download_url
      }
    end
  end
  
end
