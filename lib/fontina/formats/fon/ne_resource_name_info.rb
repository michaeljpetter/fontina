module Fontina::Formats::FON

  class FON_NEResourceNameInfo < BinData::Record
    endian :little
    search_prefix :fon

    uint16 :data_blkaddr
    uint16 :data_blklen
    skip length: 2
    uint16 :id
    skip length: 4

    delayed_io :data, read_abs_offset: -> { data_blkaddr << align_shift } do
      buffer type: :ne_resource, length: -> { data_blklen << align_shift }
    end
  end

end
