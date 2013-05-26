# Misc helpers
module FreeboxDownloader

  module Helpers
    
    URI_ENCODE_EXTRA_CHARS = "[] "

    # Handle special chars in URIs
    def encode_uri(uri)
      URI.parse(URI.encode(uri, URI_ENCODE_EXTRA_CHARS))
    end

  end
  
end