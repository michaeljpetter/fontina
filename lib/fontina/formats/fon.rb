module Fontina

  module Formats::FON
    extend Format
    extension '.fon'

    class << self
      def read(io)
        package container.read io
      end

      private

      def container
        @container ||= begin
          %w[
            ../windows/language_codes
            shared/p_string
            fon/constants
            fon/dos_header
            fon/ne_header
            fon/ne_exported_name_table
            fon/ne_font_dir
            fon/ne_vs_version_info
            fon/ne_resource
            fon/ne_resource_name_info
            fon/ne_resource_type_info
            fon/ne_resource_table
            fon/container
          ].each { |file| require_relative file }

          Class.new(FON_Container) { auto_call_delayed_io }
        end
      end

      def package(fon)
        language = get_language(fon)

        Package[
          [QualifiedName[
            fon.nrestab.first.name.sub(/^.*:\s*/, ''), :windows, language
          ]],

          get_rsrc_data(fon, RT_FONTDIR)
            .flat_map(&:dir).map(&:entry)
            .map do |e|
              Font[
                [],
                [QualifiedName[e.face_name, :windows, language]],
                e.font_type[0] == 1 ? :vector : :raster,
                e.points,
                e.weight,
                e.italic[0] == 1,
                e.underline[0] == 1,
                e.strikeout[0] == 1,
              ]
            end
        ]
      end

      def get_language(fon)
        language_id = get_rsrc_data(fon, RT_VERSION)
          .flat_map(&:children).find_all { |c| c.name == 'VarFileInfo' }
          .flat_map(&:children).find_all { |c| c.name == 'Translation' }
          .flat_map(&:data).map(&:locale)
          .first

        Windows::LANGUAGE_CODES[language_id]
      end

      def get_rsrc_data(fon, type)
        fon.rsrctab
          .types.find_all { |t| t.type_id == WORD_HIGHBIT | type }
          .flat_map(&:name_info)
          .map(&:data)
      end
    end
  end

end
