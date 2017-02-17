require 'uri'

module Fontina

  class Fetchers::HTTP
    include Fetcher

    def fetch(location)
      return super unless location.is_a? URI::HTTP

      response = connection.get(location)

      Result[response.body, get_filename(response), get_mime_type(response)]
    end

    private

    def connection
      @connection ||= Faraday.new do |c|
        c.use FaradayMiddleware::FollowRedirects, limit: 2
        c.use Faraday::Response::RaiseError
        c.adapter Faraday.default_adapter
      end
    end

    def get_filename(response)
      get_attachment_filename(response) || File.basename(URI.decode response.env.url.path)
    end

    def get_attachment_filename(response)
      disposition = response.headers[:content_disposition] and
      match = disposition.match(/^attachment; *filename=(?<q>"?)(?<filename>(\w| |\.|\\")*)\k<q>$/) and
      match[:filename].gsub('\"', '"')
    end

    def get_mime_type(response)
      type = response.headers[:content_type] and
      match = type.match(/^(?<type>[\w-]+\/[\w-]+)(;.*)?$/) and
      match[:type]
    end
  end

end
