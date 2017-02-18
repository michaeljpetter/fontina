module Fontina

  class Fetchers::LocalFilePath
    include Fetcher

    def fetch(location)
      return super unless location.is_a? String

      Result[IO.binread(location), File.basename(location)]
    end
  end

end
