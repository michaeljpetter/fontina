module Fontina

  module Formats::OpenType
    extend Format
    extension '.otf', '.ttf'

    class << self
      def read(io)
        package container.read io
      end

      private

      def container
        @container ||= begin
          %w[
            ../language_codes/mac
            ../language_codes/windows
            shared/e_string
            open_type/constants
            open_type/name_table
            open_type/head_table
            open_type/os2_table
            open_type/table
            open_type/table_directory
            open_type/offset_table
            open_type/container
          ].each { |file| require_relative file }

          Class.new(OT_Container) { auto_call_delayed_io }
        end
      end

      def package(ot)
        name_records = get_table(ot, 'name').names

        Package[
          name_records.find_all { |n| n.name_id == 4 }
            .map { |n| QualifiedName[n.string, n.platform.value, n.language.value] },

          [Font[
            name_records.find_all { |n| n.name_id == 1 }
              .map { |n| QualifiedName[n.string, n.platform.value, n.language.value] },
            :vector,
            nil,
            *get_style(ot)
          ]]
        ]
      end

      def get_table(ot, tag)
        entry = ot.table_directory.find { |t| t.tag == tag } and
        entry.table
      end

      def get_style(ot)
        get_table(ot, 'OS/2').tap do |t|
          return [
            t.weight_class,
            t.fs_selection[0] == 1,
            t.fs_selection[1] == 1,
            t.fs_selection[4] == 1
          ] if t
        end

        get_table(ot, 'head').tap do |t|
          return [
            t.mac_style[0] == 1 ? FW_BOLD : FW_NORMAL,
            t.mac_style[1] == 1,
            t.mac_style[2] == 1,
            nil
          ]
        end
      end
    end
  end

end
