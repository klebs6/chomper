unit module Chomper::Cpp::GcppTypeSpecifier;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppSimpleTypeSpecifier;
use Chomper::Cpp::GcppAttr;

package TrailingTypeSpecifier is export {

    # rule trailing-type-specifier:sym<cv-qualifier> { 
    #   <cv-qualifier> 
    #   <simple-type-specifier> 
    # }
    our class CvQualifier does ITrailingTypeSpecifier {
        has ICvQualifier         $.cv-qualifier          is required;
        has ISimpleTypeSpecifier $.simple-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            if $treemark {
                "T"
            } else {
                $.cv-qualifier.gist(:$treemark) ~ " " ~ $.simple-type-specifier.gist(:$treemark)
            }
        }
    }
}

# rule type-specifier-seq { 
#   <type-specifier>+ 
#   <attribute-specifier-seq>? 
# }
class TypeSpecifierSeq does ITypeSpecifierSeq is export { 
    has ITypeNameSpecifier     @.type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = @.type-specifiers>>.gist(:$treemark).join(" ");

        $builder = $builder.&maybe-extend(:$treemark,$.attribute-specifier-seq);

        $builder
    }
}

# rule trailing-type-specifier-seq { 
#   <trailing-type-specifier>+ 
#   <attribute-specifier-seq>? 
# }
class TrailingTypeSpecifierSeq is export { 
    has ITrailingTypeSpecifier @.trailing-type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = @.trailing-type-specifiers>>.gist(:$treemark).join(" ");

        $builder = $builder.&maybe-extend(:$treemark,$.attribute-specifier-seq);

        $builder
    }
}

class TypeSpecifier 
does IDeclSpecifierSeq is export {
    has $.value is required;

    method gist(:$treemark=False) {
        if $treemark {
            return "T"
        }

        $.value.gist(:$treemark)
    }
}

package TypeSpecifierGrammar is export {

    our role Actions {

        method type-specifier($/) {
            make TypeSpecifier.new(
                value => $<type-specifier-item>.made
            )
        }

        # rule type-specifier:sym<trailing-type-specifier> { <trailing-type-specifier> }
        method type-specifier-item:sym<trailing-type-specifier>($/) {
            make $<trailing-type-specifier>.made
        }

        # rule type-specifier:sym<class-specifier> { <class-specifier> }
        method type-specifier-item:sym<class-specifier>($/) {
            make $<class-specifier>.made
        }

        # rule type-specifier:sym<enum-specifier> { <enum-specifier> } 
        method type-specifier-item:sym<enum-specifier>($/) {
            make $<enum-specifier>.made
        }

        # rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
        method trailing-type-specifier:sym<cv-qualifier>($/) {
            make TrailingTypeSpecifier::CvQualifier.new(
                cv-qualifier          => $<cv-qualifier>.made,
                simple-type-specifier => $<simple-type-specifier>.made,
                text                  => ~$/,
            )
        }

        # rule trailing-type-specifier:sym<simple> { <simple-type-specifier> }
        method trailing-type-specifier:sym<simple>($/) {
            make $<simple-type-specifier>.made
        }

        # rule trailing-type-specifier:sym<elaborated> { <elaborated-type-specifier> }
        method trailing-type-specifier:sym<elaborated>($/) {
            make $<elaborated-type-specifier>.made
        }

        # rule trailing-type-specifier:sym<typename> { <type-name-specifier> } 
        method trailing-type-specifier:sym<typename>($/) {
            make $<type-name-specifier>.made
        }

        # rule type-specifier-seq { <type-specifier>+ <attribute-specifier-seq>? }
        method type-specifier-seq($/) {

            my $tail  = $<attribute-specifier-seq>.made;
            my @items = $<type-specifier>>>.made;

            if $tail {

                make TypeSpecifierSeq.new(
                    type-specifiers         => @items,
                    attribute-specifier-seq => $tail,
                    text                    => ~$/,
                )

            } else {

                if @items.elems gt 1 {

                    make @items

                } else {

                    make @items[0]
                }
            }
        }

        # rule trailing-type-specifier-seq { <trailing-type-specifier>+ <attribute-specifier-seq>? }
        method trailing-type-specifier-seq($/) {
            my $tail  = $<attribute-specifier-seq>.made;
            my @items = $<trailing-type-specifier>>>.made;

            if $tail or @items.elems gt 1 {
                make TrailingTypeSpecifierSeq.new(
                    trailing-type-specifiers => @items,
                    attribute-specifier-seq  => $tail,
                    text                     => ~$/,
                )
            } else {
                make @items[0]
            }
        }

        # rule simple-int-type-specifier { <simple-type-signedness-modifier>? <simple-type-length-modifier>* <int_> }
        method simple-int-type-specifier($/) {
            make SimpleIntTypeSpecifier.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                simple-type-length-modifiers    => $<simple-type-length-modifier>>>.made,
                    text                        => ~$/,
            )
        }

        # rule simple-char-type-specifier { <simple-type-signedness-modifier>? <char_> }
        method simple-char-type-specifier($/) {
            make SimpleCharTypeSpecifier.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                text                            => ~$/,
            )
        }

        # rule simple-char16-type-specifier { <simple-type-signedness-modifier>? <char16> }
        method simple-char16-type-specifier($/) {
            make SimpleChar16TypeSpecifier.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                text                            => ~$/,
            )
        }

        # rule simple-char32-type-specifier { <simple-type-signedness-modifier>? <char32> }
        method simple-char32-type-specifier($/) {
            make SimpleChar32TypeSpecifier.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                text                            => ~$/,
            )
        }

        # rule simple-wchar-type-specifier { <simple-type-signedness-modifier>? <wchar> }
        method simple-wchar-type-specifier($/) {
            make SimpleWcharTypeSpecifier.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                text                            => ~$/,
            )
        }

        # rule simple-double-type-specifier { <simple-type-length-modifier>? <double> } 
        method simple-double-type-specifier($/) {
            make SimpleDoubleTypeSpecifier.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                text                            => ~$/,
            )
        }

        # regex simple-type-specifier:sym<int> { <simple-int-type-specifier> }
        method simple-type-specifier:sym<int>($/) {
            make $<simple-int-type-specifier>.made
        }

        # regex simple-type-specifier:sym<full> { <full-type-name> }
        method simple-type-specifier:sym<full>($/) {
            make $<full-type-name>.made
        }

        # regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
        method simple-type-specifier:sym<scoped>($/) {
            make $<scoped-template-id>.made
        }

        # regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
        method simple-type-specifier:sym<signedness-mod>($/) {
            make $<simple-type-signedness-modifier>.made
        }

        # regex simple-type-specifier:sym<signedness-mod-length> { 
        #   <simple-type-signedness-modifier>? 
        #   <simple-type-length-modifier>+ 
        # }
        method simple-type-specifier:sym<signedness-mod-length>($/) {
            make SimpleTypeSpecifier::SignednessModLength.new(
                simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
                simple-type-length-modifier     => $<simple-type-length-modifier>>>.made,
                text                            => ~$/,
            )
        }

        # regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
        method simple-type-specifier:sym<char>($/) {
            make $<simple-char-type-specifier>.made
        }

        # regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
        method simple-type-specifier:sym<char16>($/) {
            make $<simple-char16-type-specifier>.made
        }

        # regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
        method simple-type-specifier:sym<char32>($/) {
            make $<simple-char32-type-specifier>.made
        }

        # regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
        method simple-type-specifier:sym<wchar>($/) {
            make $<simple-wchar-type-specifier>.made
        }

        # regex simple-type-specifier:sym<bool> { <bool_> }
        method simple-type-specifier:sym<bool>($/) {
            make SimpleTypeSpecifier::Bool_.new
        }

        # regex simple-type-specifier:sym<float> { <float> }
        method simple-type-specifier:sym<float>($/) {
            make SimpleTypeSpecifier::Float_.new
        }

        # regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
        method simple-type-specifier:sym<double>($/) {
            make $<simple-double-type-specifier>.made
        }

        # regex simple-type-specifier:sym<void> { <void_> }
        method simple-type-specifier:sym<void>($/) {
            make SimpleTypeSpecifier::Void_.new
        }

        # regex simple-type-specifier:sym<auto> { <auto> }
        method simple-type-specifier:sym<auto>($/) {
            make SimpleTypeSpecifier::Auto_.new
        }

        # regex simple-type-specifier:sym<decltype> { <decltype-specifier> } 
        method simple-type-specifier:sym<decltype>($/) {
            make $<decltype-specifier>.made
        }
    }

    our role Rules {

        rule simple-int-type-specifier {
            <simple-type-signedness-modifier>? 
            <simple-type-length-modifier>* 
            <int_>
        }

        rule simple-char-type-specifier {
            <simple-type-signedness-modifier>?
            <char_>
        }

        rule simple-char16-type-specifier {
            <simple-type-signedness-modifier>?  
            <char16>
        }

        rule simple-char32-type-specifier {
            <simple-type-signedness-modifier>?
            <char32>
        }

        rule simple-wchar-type-specifier {
            <simple-type-signedness-modifier>? 
            <wchar>
        }

        rule simple-double-type-specifier {
            <simple-type-length-modifier>?
            <double>
        }

        #------------------------------
        proto regex simple-type-specifier { * }
        regex simple-type-specifier:sym<int>                   { <simple-int-type-specifier>                                  } 
        regex simple-type-specifier:sym<full>                  { <full-type-name>                                             } 
        regex simple-type-specifier:sym<scoped>                { <scoped-template-id>                                         } 
        regex simple-type-specifier:sym<signedness-mod>        { <simple-type-signedness-modifier>                               } 
        regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>?  <simple-type-length-modifier>+ } 
        regex simple-type-specifier:sym<char>                  { <simple-char-type-specifier>                                 } 
        regex simple-type-specifier:sym<char16>                { <simple-char16-type-specifier>                               } 
        regex simple-type-specifier:sym<char32>                { <simple-char32-type-specifier>                               } 
        regex simple-type-specifier:sym<wchar>                 { <simple-wchar-type-specifier>                                } 
        regex simple-type-specifier:sym<bool>                  { <bool_>                                                      } 
        regex simple-type-specifier:sym<float>                 { <float>                                                      } 
        regex simple-type-specifier:sym<double>                { <simple-double-type-specifier>                               } 
        regex simple-type-specifier:sym<void>                  { <void_>                                                       } 
        regex simple-type-specifier:sym<auto>                  { <auto>                                                       } 
        regex simple-type-specifier:sym<decltype>              { <decltype-specifier>                                          } 

        rule type-specifier { <type-specifier-item> }

        proto rule type-specifier-item { * }
        rule type-specifier-item:sym<trailing-type-specifier> { <trailing-type-specifier> }
        rule type-specifier-item:sym<class-specifier>         { <class-specifier>        }
        rule type-specifier-item:sym<enum-specifier>          { <enum-specifier>         }

        proto rule trailing-type-specifier { * }
        rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
        rule trailing-type-specifier:sym<simple>       { <simple-type-specifier>     } 
        rule trailing-type-specifier:sym<elaborated>   { <elaborated-type-specifier> } 
        rule trailing-type-specifier:sym<typename>     { <type-name-specifier>       } 

        rule type-specifier-seq {
            <type-specifier>+ <attribute-specifier-seq>?
        }

        rule trailing-type-specifier-seq {
            <trailing-type-specifier>+ <attribute-specifier-seq>?
        }
    }
}
