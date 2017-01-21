module Fontina::Formats::FON

  class FON_Container < BinData::Record
    search_prefix :fon

    dos_header :dos

    skip to_abs_offset: -> { dos.new_addr }
    ne_header :ne

    skip to_abs_offset: -> { ne.abs_offset + ne.restab_offs }
    ne_exported_name_table :restab
    virtual :restab_count, assert: -> { restab.count == 2 }

    skip to_abs_offset: -> { ne.nrestab_addr }
    ne_exported_name_table :nrestab
    virtual :nrestab_num_bytes, assert: -> { nrestab.num_bytes == ne.nrestab_len }
    virtual :nrestab_count, assert: -> { nrestab.count == 2 }
    virtual :nrestab_first, assert: -> { nrestab.first.start_with?('FONTRES ') }

    delayed_io :rsrctab, type: :ne_resource_table, read_abs_offset: -> { ne.abs_offset + ne.rsrctab_offs }
  end

end
