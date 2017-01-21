require 'pathname'

module Fontina

  class Fetchers::LocalFilePath
    include Fetcher

    def fetch(location)
      return super unless location.is_a? String

      Result[Pathname.new(location).binread, File.basename(location)]
    end
  end

end
