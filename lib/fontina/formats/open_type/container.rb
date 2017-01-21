module Fontina::Formats::OpenType

  class OT_Container < BinData::Record
    search_prefix :ot

    offset_table :offset_table
    table_directory :table_directory
  end

end
