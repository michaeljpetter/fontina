module Fontina

  module Format
    class << self
      def for(criteria)
        criteria.lazy
          .map { |key, value| registry[key][value] }
          .find(&:itself) or fail "no format matches #{criteria}"
      end

      private

      def register(format, criteria)
        criteria.each do |key, args|
          args.each { |arg| registry[key][arg] = format }
        end
      end

      def registry
        @registry ||= %i[extension mime_type]
          .reduce(Hash.new({}.freeze)) { |h, k| h[k] = {}; h }
      end
    end

    private

    registry.each_key do |key|
      define_method key do |*args|
        Format.send :register, self, key => args
      end
    end
  end

end

%w[
  fon
  open_type
].each { |format| require_relative "formats/#{format}" }
