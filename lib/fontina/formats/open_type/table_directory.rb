module Fontina::Formats::OpenType

  class OT_TableDirectoryEntry < BinData::Record
    endian :big
    search_prefix :ot
    hide :checksum

    string :tag, length: 4
    uint32 :checksum
    uint32 :addr
    uint32 :len

    delayed_io :table, read_abs_offset: :addr do
      buffer type: :table, length: :len
    end
  end

  class OT_TableDirectory < BinData::Array
    search_prefix :ot

    default_parameter initial_length: -> { offset_table.table_count }

    table_directory_entry
  end

end
