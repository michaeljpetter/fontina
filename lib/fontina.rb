%w[
  bindata
  faraday
  faraday_middleware
  mores
].each { |lib| require lib }

module Fontina
  module Fetchers end
  module Formats
    module Shared end
  end
end

%w[
  version
  package
  format
  fetcher
  meta_package
].each { |file| require "fontina/#{file}" }

module Fontina

  def self.open(location)
    MetaPackage.new location
  end

end
