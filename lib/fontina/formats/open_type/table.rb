module Fontina::Formats::OpenType

  class OT_Table < BinData::Choice
    search_prefix :ot

    default_parameter selection: :tag

    name_table 'name'
    head_table 'head'
    os2_table 'OS/2'

    virtual :default
  end

end
