module Fontina::Formats::OpenType

  class OT_OffsetTable < BinData::Record
    endian :big
    search_prefix :ot
    hide :table_count

    uint32 :version, assert: -> { [OT_VERSION, TT_VERSION].include? value }
    uint16 :table_count
    uint16 :search_range
    uint16 :entry_selector
    uint16 :range_shift
  end

end
