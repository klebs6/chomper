use JSON::Class;

our subset Id of Str;

our class ExternalCrate does JSON::Class {
    has Str $.name is required;
    has Str $.html_root_url;
}

our role IItem does JSON::Class { }

our class Module does IItem {

}

our class ExternCrate does IItem {
    has Str $.name is required;
    has Str $.rename;
}

our class Import does IItem {

}

our class Union does IItem {

}

our class Struct does IItem {

}

our class StructField does IItem {

}

our class Enum does IItem {

}

our class Variant does IItem {

}

our class Function does IItem {

}

our class Trait does IItem {

}

our class TraitAlias does IItem {

}

our class Method does IItem {

}

our class Impl does IItem {

}

our class Typedef does IItem {

}

our class OpaqueTy does IItem {

}

our class Constant does IItem {

}

our class Static does IItem {

}

our class ForeignType does IItem {

}

our class Macro does IItem {

}

our class ProcMacro does IItem {

}

our class PrimitiveType does IItem {

}

our class AssocConst does IItem {
    has Type $.type is required;
    has Str  $.default;
}

our class AssocType does IItem {
    has GenericBound @.bounds is required;
    has Type         $.default;
}

#------------------------
our role IVisibility does JSON::Class { }

our enum Visibility does IVisibility <public default crate>;

our class RestrictedVisibility does IVisibility {
    has Id  $.parent is required;
    has Str $.path   is required;
}

our class Deprecation does JSON::Class {
    has Str $.since;
    has Str $.note;
}

our subset Range of List where (uint32, uint32); 

our class Span does JSON::Class {
    has IO::Path $.filename is required;
    has Range $.begin       is required;
    has Range $.end         is required;
}

our class Item does JSON::Class {
    has Id                  $.id           is required;
    has uint32              $.crate_id     is required;
    has Str                 $.name;
    has Span                $.span;
    has IVisibility         $.visibility   is required;
    has Str                 $.docs;
    has Associative[Str,Id] $.links        is required;
    has Positional[Str]     $.attrs        is required;
    has Deprecation         $.deprecation;
    has IItem               $.inner        is required;
}

our enum ItemKind does JSON::Class <
    Module
    ExternCrate
    Import
    Struct
    StructField
    Union
    Enum
    Variant
    Function
    Typedef
    OpaqueTy
    Constant
    Trait
    TraitAlias
    Method
    Impl
    Static
    ForeignType
    Macro
    ProcAttribute
    ProcDerive
    AssocConst
    AssocType
    Primitive
    Keyword
>;

our class ItemSummary does JSON::Class {
    has uint32          $.crate_id is required;
    has Positional[Str] $.path     is required;
    has ItemKind        $.kind     is required;
}

our class Crate does JSON::Class {
    has Id                                $.root             is required;
    has Str                               $.crate_version;
    has Bool                              $.includes_private is required;
    has Associative[Id,Item]              $.index            is required;
    has Associative[Id,ItemSummary]       $.paths            is required;
    has Associative[uint32,ExternalCrate] $.external_crates  is required;
    has uint32                            $.format_version   is required;
}
