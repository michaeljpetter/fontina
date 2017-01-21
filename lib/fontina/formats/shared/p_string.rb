module Fontina::Formats::Shared

  class PString < BinData::Primitive
    uint8 :len, value: -> { string.length }
    string :string, read_length: :len

    def get
      string
    end

    def set(value)
      string = value
    end
  end

end
