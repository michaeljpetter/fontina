module Fontina::Formats::FON

  class FON_NEVersionData < BinData::Choice
    endian :little

    default_parameter selection: -> {
      return STRINGZ if path[1...-2] == ['StringFileInfo']
      return TRANSLATION if path[1..-1] == ['VarFileInfo', 'Translation']
      :default
    }

    stringz STRINGZ = 1

    array TRANSLATION = 2, read_until: :eof do
      uint16 :locale
      uint16 :codepage
    end

    virtual :default
  end

  class FON_NEVersionNode < BinData::Record
    endian :little
    search_prefix :fon
    hide :node_len, :data_len, :children_len

    uint16 :node_len
    uint16 :data_len
    stringz :name
    virtual byte_align: 4

    buffer :data, length: :data_len, type: :ne_version_data, onlyif: -> { data_len.nonzero? }
    virtual :data_end
    virtual byte_align: 4

    virtual :children_len, initial_value: -> { node_len - data_end.rel_offset }

    buffer :children, length: :children_len, onlyif: -> { children_len.nonzero? } do
      array type: :ne_version_node, read_until: :eof
    end
    virtual byte_align: 4

    def path
      @path ||= (parent_node.path + [name]).freeze
    end

    private

    def parent_node
      @parent_node ||= begin
        value = self
        loop { value = value.parent; break if value.is_a? self.class }
        value
      end
    end
  end

  class FON_NEVsVersionInfo < FON_NEVersionNode
    virtual :root_name, assert: -> { name == 'VS_VERSION_INFO' }

    virtual :root_num_bytes,
      byte_align: -> { 1 << align_shift },
      assert: -> { num_bytes == data_blklen << align_shift }

    def path
      @path ||= [name].freeze
    end
  end

end
