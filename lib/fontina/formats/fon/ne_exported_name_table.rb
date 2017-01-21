module Fontina::Formats::FON

  class FON_NEExportedName < BinData::Primitive
    p_string :name
    uint8 :enttab_idx, assert: 0

    def get
      name
    end

    def set(value)
      name = value
    end
  end

  class FON_NEExportedNameTable < BinData::Array
    search_prefix :fon

    default_parameter read_until: -> { element.empty? }

    ne_exported_name
  end

end
