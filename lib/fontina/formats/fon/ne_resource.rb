module Fontina::Formats::FON

  class FON_NEResource < BinData::Choice
    search_prefix :fon

    default_parameter selection: -> { type_id & ~WORD_HIGHBIT }

    ne_font_dir RT_FONTDIR
    ne_vs_version_info RT_VERSION

    virtual :default
  end

end
