module Fontina::Formats::OpenType

  class OT_NameRecord < BinData::Record
    endian :big
    hide :len, :offs, :platform_id, :encoding_id, :language_id

    uint16 :platform_id, assert: -> { PLATFORMS.key? value }
    virtual :platform, initial_value: -> { PLATFORMS[platform_id] }
    uint16 :encoding_id, assert: -> { ENCODINGS[platform.value].key? value }
    virtual :encoding, initial_value: -> { ENCODINGS[platform.value][encoding_id] }
    uint16 :language_id, assert: -> { LANGUAGES[platform.value].key? value }
    virtual :language, initial_value: -> { LANGUAGES[platform.value][language_id] }
    uint16 :name_id
    uint16 :len
    uint16 :offs

    delayed_io :string, read_abs_offset: -> { addr + string_offs + offs } do
      string length: :len
    end
  end

  class OT_NameTable < BinData::Record
    endian :big
    search_prefix :ot
    hide :name_count, :string_offs

    uint16 :format
    uint16 :name_count
    uint16 :string_offs

    array :names, type: :name_record, initial_length: :name_count
  end

end
