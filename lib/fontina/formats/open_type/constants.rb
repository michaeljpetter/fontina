module Fontina

  module Formats::OpenType
    OT_VERSION = 0x4f54544f  # OTTO
    TT_VERSION = 0x00010000

    FW_NORMAL = 400
    FW_BOLD   = 700

    PLATFORMS = {
      0 => :unicode,
      1 => :mac,
      3 => :windows,
    }.freeze

    ENCODINGS = {
      unicode: {
         0 => :unicode_1_0,
         1 => :unicode_1_1,
         3 => :unicode_2_0_bmp,
         4 => :unicode_2_0,
      }.freeze,

      mac: {
         0 => :roman,
         1 => :japanese,
         2 => :chinese_traditional,
         3 => :korean,
         4 => :arabic,
         5 => :hebrew,
         6 => :greek,
         7 => :russian,
         8 => :r_symbol,
         9 => :devanagari,
        10 => :gurmukhi,
        11 => :gujarati,
        12 => :oriya,
        13 => :bengali,
        14 => :tamil,
        15 => :telugu,
        16 => :kannada,
        17 => :malayalam,
        18 => :sinhalese,
        19 => :burmese,
        20 => :khmer,
        21 => :thai,
        22 => :laotian,
        23 => :georgian,
        24 => :armenian,
        25 => :chinese_simplified,
        26 => :tibetan,
        27 => :mongolian,
        28 => :geez,
        29 => :slavic,
        30 => :vietnamese,
        31 => :sindhi,
        32 => :uninterpreted,
      }.freeze,

      windows: {
         0 => :symbol,
         1 => Encoding::UCS_2BE,
         2 => Encoding::Shift_JIS,
         3 => Encoding::GBK,
         4 => Encoding::Big5,
         5 => :wansung,
         6 => :johab,
        10 => Encoding::UCS_4BE,
      }.freeze,
    }.freeze

    LANGUAGES = {
      unicode: { 0 => nil }.freeze,
      mac: { 0xffff => nil }.merge!(LanguageCodes::MAC).freeze,
      windows: LanguageCodes::WINDOWS,
    }.freeze
  end

end
