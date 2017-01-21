module Fontina::Formats::OpenType

  class OT_HeadTable < BinData::Record
    endian :big
    hide :checksum_adjustment, :magic

    uint16 :major_version
    uint16 :minor_version
    skip length: 4
    uint32 :checksum_adjustment
    uint32 :magic, assert: 0x5f0f3cf5
    skip length: 28
    uint16 :mac_style
    skip length: 8
  end

end
