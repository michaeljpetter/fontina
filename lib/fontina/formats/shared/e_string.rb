module Fontina::Formats::Shared

  class EString < BinData::String
    mandatory_parameter :encoding

    def snapshot
      super.tap { |s| e = eval_parameter(:encoding) and s.force_encoding e }
    end
  end

end
