module Fontina::Formats::FON

  class FON_DOSHeader < BinData::Record
    endian :little
    hide :magic, :reloc_addr

    uint16 :magic, assert: IMAGE_DOS_SIGNATURE
    skip length: 22
    uint16 :reloc_addr, assert: 0x40
    skip length: 34
    int32 :new_addr
  end

end
