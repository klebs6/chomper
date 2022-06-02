unit module Chomper::Cpp::GcppKeywords;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

sub is-cpp-keyword($token) returns Bool is export {

    #need be a better way
    #
    #is it possible to access tokens from Rules
    #below?
    my @keywords = [
        'alignas',
        'alignof',
        'asm',
        'auto',
        'bool',
        'break',
        'case',
        'catch',
        'char',
        'char16_t',
        'char32_t',
        'class',
        'const',
        'constexpr',
        'const_cast',
        'continue',
        'decltype',
        'default',
        'delete',
        'do',
        'double',
        'dynamic_cast',
        'else',
        'enum',
        'explicit',
        'export',
        'extern',
        'false',
        'final',
        'float',
        'for',
        'friend',
        'goto',
        'if',
        'inline',
        'int',
        'long',
        'mutable',
        'namespace',
        'new',
        'noexcept',
        'nullptr',
        'operator',
        'override',
        'private',
        'protected',
        'public',
        'register',
        'reinterpret_cast',
        'return',
        'short',
        'signed',
        'sizeof',
        'static',
        'static_assert',
        'static_cast',
        'struct',
        'switch',
        'template',
        'this',
        'thread_local',
        'throw',
        'true',
        'try',
        'typedef',
        'typeid',
        'typename',
        'union',
        'unsigned',
        'using',
        'virtual',
        'void',
        'volatile',
        'wchar_t',
        'while',
    ];

    my $match = $token.Str ~~ /^^ @keywords $$/;

    so $match
}

package KeywordGrammar is export {

    our role Rules {

        token alignas          { 'alignas'          } 
        token alignof          { 'alignof'          } 
        token asm              { 'asm'              } 
        token auto             { 'auto'             } 
        token bool_            { 'bool'             } 
        token break_           { 'break'            } 
        token case             { 'case'             } 
        token catch            { 'catch'            } 
        token char_            { 'char'             } 
        token char16           { 'char16_t'         } 
        token char32           { 'char32_t'         } 
        token class_           { 'class'            } 
        token const            { 'const'            } 
        token constexpr        { 'constexpr'        } 
        token const_cast       { 'const_cast'       } 
        token continue_        { 'continue'         } 
        token decltype         { 'decltype'         } 
        token default_         { 'default'          } 
        token delete           { 'delete'           } 
        token do_              { 'do'               } 
        token double           { 'double'           } 
        token dynamic_cast     { 'dynamic_cast'     } 
        token else_            { 'else'             } 
        token enum_            { 'enum'             } 
        token explicit         { 'explicit'         } 
        token export           { 'export'           } 
        token extern           { 'extern'           } 
        token false_           { 'false'            } 
        token final            { 'final'            } 
        token float            { 'float'            } 
        token for_             { 'for'              } 
        token friend           { 'friend'           } 
        token goto_            { 'goto'             } 
        token if_              { 'if'               } 
        token inline           { 'inline'           } 
        token int_             { 'int'              } 
        token long_            { 'long'             } 
        token mutable          { 'mutable'          } 
        token namespace        { 'namespace'        } 
        token new_             { 'new'              } 
        token noexcept         { 'noexcept'         } 
        token nullptr          { 'nullptr'          } 
        token operator         { 'operator'         } 
        token override         { 'override'         } 
        token private          { 'private'          } 
        token protected        { 'protected'        } 
        token public           { 'public'           } 
        token register         { 'register'         } 
        token reinterpret_cast { 'reinterpret_cast' } 
        token return_          { 'return'           } 
        token short            { 'short'            } 
        token signed           { 'signed'           } 
        token sizeof           { 'sizeof'           } 
        token static           { 'static'           } 
        token static_assert    { 'static_assert'    } 
        token static_cast      { 'static_cast'      } 
        token struct           { 'struct'           } 
        token switch           { 'switch'           } 
        token template         { 'template'         } 
        token this             { 'this'             } 
        token thread_local     { 'thread_local'     } 
        token throw            { 'throw'            } 
        token true_            { 'true'             } 
        token try_             { 'try'              } 
        token typedef          { 'typedef'          } 
        token typeid_          { 'typeid'           } 
        token typename_        { 'typename'         } 
        token union            { 'union'            } 
        token unsigned         { 'unsigned'         } 
        token using            { 'using'            } 
        token virtual          { 'virtual'          } 
        token void_            { 'void'             } 
        token volatile         { 'volatile'         } 
        token wchar            { 'wchar_t'          } 
        token while_           { 'while'            } 

        proto token keyword { * }
        token keyword:sym<kw-alignas>          { <alignas>          } 
        token keyword:sym<kw-alignof>          { <alignof>          } 
        token keyword:sym<kw-asm>              { <asm>              } 
        token keyword:sym<kw-auto>             { <auto>             } 
        token keyword:sym<kw-bool>             { <bool_>            } 
        token keyword:sym<kw-break>            { <break_>           } 
        token keyword:sym<kw-case>             { <case>             } 
        token keyword:sym<kw-catch>            { <catch>            } 
        token keyword:sym<kw-char>             { <char_>            } 
        token keyword:sym<kw-char16>           { <char16>           } 
        token keyword:sym<kw-char32>           { <char32>           } 
        token keyword:sym<kw-class>            { <class_>           } 
        token keyword:sym<kw-const>            { <const>            } 
        token keyword:sym<kw-constexpr>        { <constexpr>        } 
        token keyword:sym<kw-const_cast>       { <const_cast>       } 
        token keyword:sym<kw-continue>         { <continue_>        } 
        token keyword:sym<kw-decltype>         { <decltype>         } 
        token keyword:sym<kw-default>          { <default_>         } 
        token keyword:sym<kw-delete>           { <delete>           } 
        token keyword:sym<kw-do>               { <do_>              } 
        token keyword:sym<kw-double>           { <double>           } 
        token keyword:sym<kw-dynamic_cast>     { <dynamic_cast>     } 
        token keyword:sym<kw-else>             { <else_>            } 
        token keyword:sym<kw-enum>             { <enum_>            } 
        token keyword:sym<kw-explicit>         { <explicit>         } 
        token keyword:sym<kw-export>           { <export>           } 
        token keyword:sym<kw-extern>           { <extern>           } 
        token keyword:sym<kw-false>            { <false_>           } 
        token keyword:sym<kw-final>            { <final>            } 
        token keyword:sym<kw-float>            { <float>            } 
        token keyword:sym<kw-for>              { <for_>             } 
        token keyword:sym<kw-friend>           { <friend>           } 
        token keyword:sym<kw-goto>             { <goto_>            } 
        token keyword:sym<kw-if>               { <if_>              } 
        token keyword:sym<kw-inline>           { <inline>           } 
        token keyword:sym<kw-int>              { <int_>             } 
        token keyword:sym<kw-long>             { <long_>            } 
        token keyword:sym<kw-mutable>          { <mutable>          } 
        token keyword:sym<kw-namespace>        { <namespace>        } 
        token keyword:sym<kw-new>              { <new_>             } 
        token keyword:sym<kw-noexcept>         { <noexcept>         } 
        token keyword:sym<kw-nullptr>          { <nullptr>          } 
        token keyword:sym<kw-operator>         { <operator>         } 
        token keyword:sym<kw-override>         { <override>         } 
        token keyword:sym<kw-private>          { <private>          } 
        token keyword:sym<kw-protected>        { <protected>        } 
        token keyword:sym<kw-public>           { <public>           } 
        token keyword:sym<kw-register>         { <register>         } 
        token keyword:sym<kw-reinterpret_cast> { <reinterpret_cast> } 
        token keyword:sym<kw-return>           { <return_>          } 
        token keyword:sym<kw-short>            { <short>            } 
        token keyword:sym<kw-signed>           { <signed>           } 
        token keyword:sym<kw-sizeof>           { <sizeof>           } 
        token keyword:sym<kw-static>           { <static>           } 
        token keyword:sym<kw-static_assert>    { <static_assert>    } 
        token keyword:sym<kw-static_cast>      { <static_cast>      } 
        token keyword:sym<kw-struct>           { <struct>           } 
        token keyword:sym<kw-switch>           { <switch>           } 
        token keyword:sym<kw-template>         { <template>         } 
        token keyword:sym<kw-this>             { <this>             } 
        token keyword:sym<kw-thread_local>     { <thread_local>     } 
        token keyword:sym<kw-throw>            { <throw>            } 
        token keyword:sym<kw-true>             { <true_>            } 
        token keyword:sym<kw-try>              { <try_>             } 
        token keyword:sym<kw-typedef>          { <typedef>          } 
        token keyword:sym<kw-typeid>           { <typeid_>          } 
        token keyword:sym<kw-typename>         { <typename_>        } 
        token keyword:sym<kw-union>            { <union>            } 
        token keyword:sym<kw-unsigned>         { <unsigned>         } 
        token keyword:sym<kw-using>            { <using>            } 
        token keyword:sym<kw-virtual>          { <virtual>          } 
        token keyword:sym<kw-void>             { <void_>            } 
        token keyword:sym<kw-volatile>         { <volatile>         } 
        token keyword:sym<kw-wchar>            { <wchar>            } 
        token keyword:sym<kw-while>            { <while_>           } 
    }
}
