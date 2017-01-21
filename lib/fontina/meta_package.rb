module Fontina

  class MetaPackage
    attr_reader :location

    def initialize(location)
      @location = location
    end

    def size
      file.content.length
    end

    def format
      @format ||= Format.for(
        mime_type: file.mime_type,
        extension: File.extname(file.filename).downcase
      )
    end

    def package
      @package ||= StringIO.open file.content, 'rb', &format.method(:read)
    end

    private

    def file
      @file ||= Fetcher.fetch location
    end
  end

end
