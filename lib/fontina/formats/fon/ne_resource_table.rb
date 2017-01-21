module Fontina::Formats::FON

  class FON_NEResourceTable < BinData::Record
    endian :little
    search_prefix :fon

    uint16 :align_shift, assert: -> { value > 1 }
    array :types, type: :ne_resource_type_info, read_until: -> { element.type_id.zero? }
    array :rsrc_names, type: :p_string, read_until: -> { element.empty? }
  end

end
