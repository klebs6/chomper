our role Types {

    rule function-sig-type {
        <return-type> 
        '(' <maybe-unnamed-args>  ')'
    }

    token unique-ptr {
        [ 'std::' ]? 'unique_ptr' '<' <kw-type> '>'
    }

    token unordered-set {
        [ 'std::' ]? 'unordered_set' '<' <kw-type> '>'
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
        <kw-type> | <arg>
    }

    token std-atomic {
        [ 'std::' ]? 'atomic' '<' <kw-type> '>'
    }

    token std-queue {
        [ 'std::' ]? 'queue' '<' <kw-type> '>'
    }

    rule unordered-map {
        [ 'std::' ]? 
        [
            | 'unordered_map'
            | 'CaffeMap'
            | 'map'
        ]
        '<' <kw-type> ',' <kw-type> '>'
    }

    token bit-set {
        [ 'std::' ]? 'bitset' '<' <kw-type> '>'
    }

    token std-vector {
        [ 'std::' ]? 'vector' '<' <kw-type> '>'
    }

    token std-tuple {
        [ 'std::' ]? 'tuple' '<' [<kw-type>+ %% ', '] '>'
    }

    token c10-optional {
        [ 'c10::' ]? 'optional' '<' <kw-type> '>'
    }

    token std-deque {
        [ 'std::' ]? 'deque' '<' <kw-type> '>'
    }

    token std-list {
        [ 'std::' ]? 'list' '<' <kw-type> '>'
    }

    token shared-ptr {
        [ 'std::' ]? 'shared_ptr' '<' <kw-type> '>'
    }

    rule std-pair {
        [ 'std::' ]? 'pair' '<' 
        <kw-type> ',' 
        <kw-type> 
        '>'
    }

    token std-set {
        [ 'std::' ]? 'set' '<' <kw-type> '>'
    }

    token type {
        [<mutable> <.ws>]?
        [[<kw-struct> | <class>] <.ws>]?
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
