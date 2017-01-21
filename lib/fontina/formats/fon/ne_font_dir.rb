module Fontina::Formats::FON

  class FON_NEFontDirEntry < BinData::Record
    endian :little

    uint16 :version
    uint32 :len
    string :copyright, length: 60, trim_padding: true
    uint16 :font_type
    uint16 :points
    uint16 :vert_dpi
    uint16 :horiz_dpi
    uint16 :ascent 
    uint16 :internal_leading
    uint16 :external_leading
    uint8 :italic
    uint8 :underline
    uint8 :strikeout
    uint16 :weight
    uint8 :char_set
    uint16 :pix_width
    uint16 :pix_height
    uint8 :pitch_and_family
    uint16 :avg_width
    uint16 :max_width
    uint8 :first_char
    uint8 :last_char
    uint8 :default_char
    uint8 :break_char
    uint16 :width_len
    uint32 :device_addr
    uint32 :face_addr
    skip length: 4
    stringz :device_name
    stringz :face_name
  end

  class FON_NEFontDir < BinData::Record
    endian :little
    search_prefix :fon
    hide :dir_count

    uint16 :dir_count
    array :dir, initial_length: :dir_count do
      uint16 :ordinal
      ne_font_dir_entry :entry
    end
  end

end
