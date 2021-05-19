our role Types {

    token unique-ptr {
        [ 'std::' ]? 'unique_ptr' '<' <nonvector-identifier> '>'
    }

    token unordered-set {
        [ 'std::' ]? 'unordered_set' '<' <nonvector-identifier> '>'
    }

    rule unordered-map {
        [ 'std::' ]? 
        [
            | 'unordered_map'
            | 'CaffeMap'
            | 'map'
        ]
        '<' <type> ',' <type> '>'
    }

    token bit-set {
        [ 'std::' ]? 'bitset' '<' <nonvector-identifier> '>'
    }

    token c10-optional {
        [ 'c10::' ]? 'optional' '<' <nonvector-identifier> '>'
    }

    token std-deque {
        [ 'std::' ]? 'deque' '<' <nonvector-identifier> '>'
    }

    token std-list {
        [ 'std::' ]? 'list' '<' <nonvector-identifier> '>'
    }

    token shared-ptr {
        [ 'std::' ]? 'shared_ptr' '<' <nonvector-identifier> '>'
    }

    rule std-pair {
        [ 'std::' ]? 'pair' '<' 
        <nonvector-identifier> ',' 
        <nonvector-identifier> 
        '>'
    }

    token std-set {
        [ 'std::' ]? 'set' '<' <nonvector-identifier> '>'
    }

    token nonvector-identifier {
        [
            | 'std::'
            | 'zx::'
            | 'c10::'
            | 'at::'
            | 'tbb::'
            | 'google::'
        ]?
        [
            | <unique-ptr>
            | <unordered-set>
            | <unordered-map>
            | <bit-set>
            | <c10-optional>
            | <shared-ptr>
            | <std-pair>
            | <std-list>
            | <std-deque>
            | <std-set>
            | <.identifier>
            | 'std::regex'
            | 'std::type_info'
            | 'c10::OperatorHandle'
            | 'torch::jit::Stack'
            | 'TfToken::HashSet'
            | 'DoubleToStringConverter::DtoaMode'
            | 'Vector<const char>'
            | 'Vector<char>'
            | 'set<string>'
            | 'std::ostream'
            | 'std::istream'
            | 'std::thread::id'
            | 'TfDebug::_Node'
            | 'std::string'
            | 'google::protobuf::MessageLite'
            | 'google::protobuf::RepeatedField'
            | 'kVmapMaxTensorDims'
            | 'kVmapNumLevels'
            | 'std::atomic<bool>'
            | 'atomic<bool>'
            | 'unsigned short'
            | 'unsigned int'
            | 'unsigned char'
            | 'unsigned long'
            | 'unsigned long long'
            | 'unsigned long long int'
            | 'tbb::spin_mutex::scoped_lock'
            | 'tbb::spin_mutex'
            | 'tbb::task_group'
            | <template-identifier>
        ]
    }
}

