require 'uri'

module Fontina

  class Fetchers::Preprocessor
    include Fetcher

    def fetch(location)
      begin
        uri = URI.parse location
        location = uri if uri.scheme && !uri.opaque
      rescue URI::Error; end

      super
    end
  end

end
