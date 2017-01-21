module Fontina

  module Fetcher
    Result = Mores::ImmutableStruct.new(:content, :filename, :mime_type)

    class << self
      extend Forwardable

      delegate :fetch => :succession

      private

      def succession
        @succession ||= Mores::Succession.new do
          line :fetch do |location|
            raise "Location '#{location}' is not supported"
          end
        end
      end

      def included(base)
        succession >> base.new
      end
    end
  end

end

%w[
  preprocessor
  http
  local_file_uri
  local_file_path
].each { |fetcher| require_relative "fetchers/#{fetcher}" }
