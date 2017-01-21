require 'uri'
require 'pathname'

module Fontina

  class Fetchers::LocalFileURI
    include Fetcher

    def fetch(location)
      return super unless
        location.is_a?(URI::Generic) &&
        location.scheme == 'file' &&
        [nil, 'localhost'].include?(location.host)

      path = URI.decode location.path

      Result[Pathname.new(path).binread, File.basename(path)]
    end
  end

end
