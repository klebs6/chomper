#use Grammar::Tracer;

use grammar;

our grammar Translator does ParserRules {
    rule hook {
        | <simple-ifdef>
        | <struct-member-declarations>
        | <enum-member-declarations>
        | <full-struct>
        | <full-enum>
        | <abstract-function-declarations>
        | <pound-define>
        | <default-ctor>
        | <op-convert-function-header>
        | <constructor-definition-header>
        | <op-mul-function-header>
        | <op-xor-function-header>
        | <op-bitand-function-header>
        | <op-bitor-function-header>
        | <op-eq-function-header>
        | <op-lt-function-header>
        | <op-div-eq-function-header>
        | <class-constructor-declaration>
        | <function-declaration>
        | <hashing-function>
        | <op-add-function-header>
        | <op-add-eq-function-header>
        | <op-bitor-assign-function-header>
        | <op-bitand-assign-function-header>
        | <op-div-function-header>
        | <op-mul-eq-function-header>
        | <op-negate-function-header>
        | <op-sub-function-header>
        | <op-sub-eq-function-header>
        | <freestanding-template-function-header>
        | <op-index-function-header>
        | <op-ostream-function-header>
        | <static-constants>
        | <function-local-declarations>
        | <destructor>
        | <ctor-header>
        | <using-declarations>
        | <typedef-fn-ptrs>
        | <constexpr-global-block>
        | <operator-into-bool>
        | <operator-indirect>
        | <operator-not>
        | <op-shl-function-header>
        | <op-shl-assign-function-header>
        | <op-shr-function-header>
        | <op-shr-assign-function-header>
    }

    rule TOP {
        <.ws>
        [<line-comment>* | <block-comment>]
        <hook>
    }
}
