our role Types {

    token unique-ptr {
        [ 'std::' ]? 'unique_ptr' '<' <type> '>'
    }

    token unordered-set {
        [ 'std::' ]? 'unordered_set' '<' <type> '>'
    }

    token std-atomic {
        [ 'std::' ]? 'atomic' '<' <type> '>'
    }

    token std-queue {
        [ 'std::' ]? 'queue' '<' <type> '>'
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
        [ 'std::' ]? 'bitset' '<' <type> '>'
    }

    token std-vector {
        [ 'std::' ]? 'vector' '<' <type> '>'
    }

    token std-tuple {
        [ 'std::' ]? 'tuple' '<' [<type>+ %% ', '] '>'
    }

    token c10-optional {
        [ 'c10::' ]? 'optional' '<' <type> '>'
    }

    token std-deque {
        [ 'std::' ]? 'deque' '<' <type> '>'
    }

    token std-list {
        [ 'std::' ]? 'list' '<' <type> '>'
    }

    token shared-ptr {
        [ 'std::' ]? 'shared_ptr' '<' <type> '>'
    }

    rule std-pair {
        [ 'std::' ]? 'pair' '<' 
        <type> ',' 
        <type> 
        '>'
    }

    token std-set {
        [ 'std::' ]? 'set' '<' <type> '>'
    }

    token type {
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
            | <std-atomic>
            | <std-pair>
            | <std-tuple>
            | <std-vector>
            | <std-queue>
            | <std-list>
            | <std-deque>
            | <std-set>
            | <.identifier>
            | 'DoubleToStringConverter::DtoaMode'
            | 'TfDebug::_Node'
            | 'TfToken::HashSet'
            | 'Vector<char>'
            | 'Vector<const char>'
            | 'atomic<bool>'
            | 'cv::Mat'
            | 'c10::OperatorHandle'
            | 'google::protobuf::MessageLite'
            | 'google::protobuf::RepeatedField'
            | 'itensor::descriptor'
            | 'itensor::dims'
            | 'set<string>'
            | 'atomic<bool>'
            | 'thread::id'
            | 'tbb::spin_mutex'
            | 'tbb::spin_mutex::scoped_lock'
            | 'tbb::task_group'
            | 'torch::jit::Stack'
            | 'unsigned char'
            | 'unsigned int'
            | 'unsigned long long int'
            | 'unsigned long long'
            | 'unsigned long'
            | 'unsigned short'
            | 'ideep::tensor'
            | 'ideep::scale_t'
            | 'ideep::tensor::dims'
            | 'ideep::convolution_forward_params'
            | 'ideep::tensor::descriptor'
            | <template-identifier>
        ]
    }
}
