module Fontina::Formats::FON

  class FON_NEHeader < BinData::Record
    FLAGS_MASK  = 0b1000100000000011
    VALID_FLAGS = 0b1000000000000000

    endian :little
    hide :magic, :enttab_len, :flags

    uint16 :magic, assert: IMAGE_OS2_SIGNATURE
    skip length: 4
    uint16 :enttab_len, assert: -> { value.between?(1, 2) }
    skip length: 4
    uint16 :flags, assert: -> { value & FLAGS_MASK == VALID_FLAGS }
    skip length: 18
    uint16 :nrestab_len
    skip length: 2
    uint16 :rsrctab_offs
    uint16 :restab_offs
    skip length: 4
    int32 :nrestab_addr
    skip length: 16
  end

end
