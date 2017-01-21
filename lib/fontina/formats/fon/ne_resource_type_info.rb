module Fontina::Formats::FON

  class FON_NEResourceTypeInfo < BinData::Record
    VALID_TYPE_IDS = ([0] + [
      RT_FONTDIR,
      RT_FONT,
      RT_VERSION,
      15  # unknown; occurs in some system fonts
    ].map!(&WORD_HIGHBIT.method(:|))).freeze

    endian :little
    search_prefix :fon
    hide :rsrc_count

    uint16 :type_id, assert: -> { VALID_TYPE_IDS.include? value }
    uint16 :rsrc_count, onlyif: -> { type_id.nonzero? } 
    skip length: 4, onlyif: -> { type_id.nonzero? } 
    array :name_info, type: :ne_resource_name_info, initial_length: :rsrc_count, onlyif: -> { type_id.nonzero? } 
  end

end
