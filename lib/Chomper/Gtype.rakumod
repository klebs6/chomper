our role Types {

    rule function-sig-type {
        <return-type> 
        '(' <maybe-unnamed-args>  ')'
    }

    rule function-ptr-marker {
        '(' '*' ')'
    }

    rule function-ptr-sig-type {
        <return-type> 
        <function-ptr-marker>
        '(' <maybe-unnamed-args>  ')'
    }

    token unique-ptr {
        [ 'std::' ]? 'unique_ptr' '<' <type> '>'
    }

    token unordered-set {
        [ 'std::' ]? 'unordered_set' '<' <type> '>'
    }

    regex std-function {
        [ 'std::' ]? ['function' | 'Function']
        '<' <.ws> <std-function-return-type> <.ws>
        <parenthesized-args> <.ws> '>'
    }
    token void { 
        'void'
    }
    regex std-function-return-type {
        | <void>
        | <return-type>
    }
    regex std-function-args {
        | <void>
        | <type-or-arg>+ %% ","
    }
    regex type-or-arg {
        <type> | <arg>
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
        [<mutable> <.ws>]?
        [[<struct> | <class>] <.ws>]?
        [
            | <typename> <.ws> [<parent=type> '::'[<template> <.ws>]?]+ <child=type>
            | [
                [
                    | 'std::'
                    | 'fs::'
                    | 'ssl::'
                    | 'aux::'
                    | 'tcp::'
                    | 'udp::'
                    | 'onnx::'
                    | 'zx::'
                    | 'fit::'
                    | 'math::'
                    | 'c10::'
                    | 'gles::'
                    | 'at::'
                    | 'fbgemm::'
                    | 'cv::'
                    | 'cl::'
                    | 'tbb::'
                    | 'google::'
                    | 'nom::'
                    | 'ktl::'
                    | 'bitmap::'
                    | 'hypervisor::'
                    | 'boost::'
                ]?
                [
                    #| <unique-ptr>
                    #| <unordered-set>
                    #| <unordered-map>
                    #| <bit-set>
                    #| <c10-optional>
                    #| <shared-ptr>
                    | <std-atomic>
                    | <std-pair>
                    | <std-tuple>
                    #| <std-vector>
                    | <std-queue>
                    #| <std-list>
                    #| <std-deque>
                    #| <std-set>
                    | <std-function>
                    | <.identifier>
                    | 'DoubleToStringConverter::DtoaMode'
                    | 'TfDebug::_Node'
                    | 'TfToken::HashSet'
                    | 'Vector<char>'
                    | 'Vector<const char>'
                    | 'atomic<bool>'
                    | 'cv::Mat'
                    | 'c10::OperatorHandle'
                    | 'TensorProto::DataType'
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
                    | 'SignalHandler::Action'
                    | 'ideep::scale_t'
                    | 'ideep::tensor::dims'
                    | 'ideep::convolution_forward_params'
                    | 'ideep::tensor::descriptor'
                    | 'hypervisor::GuestPhysicalAddressSpace'
                    | <template-identifier>
                ]
            ]
        ]
    }
}
