module Fontina::Formats::OpenType

  class OT_OS2Table < BinData::Record
    endian :big

    uint16 :version
    skip length: 2
    uint16 :weight_class
    skip length: 56
    uint16 :fs_selection
    skip length: 14
  end

end
