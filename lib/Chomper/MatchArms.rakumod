use Chomper::Cpp;
use Chomper::Rust;
use Chomper::SuffixedExpression;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Data::Dump::Tree;

our sub create-basic-match-scrutinee(Str :$single-variable) {

    my $expr = create-suffixed-expression(:$single-variable);

    Rust::Scrutinee.new(
        expression-nostruct => $expr,
    )
}

our sub default-match-arm-pattern {
    Rust::Pattern.new(
        pattern-no-top-alts => [
            Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "_",
                        )
                    ),
                ]
            )
        ]
    )
}

our sub create-default-match-arm(:$block) {

    Rust::MatchArmsOuterItem.new(
        maybe-comment => Nil,
        match-arm => Rust::MatchArm.new(
            outer-attributes      => [],
            pattern               => default-match-arm-pattern(),
            maybe-match-arm-guard => Nil,
        ),
        expression => $block,
    )
}

our sub exception-unpacking-match-pattern(:@exception-nest,:$what-varname) {

    our sub create-struct-pattern-elements(:$what-varname) {
        Rust::StructPatternElementsBasic.new(
            struct-pattern-fields => [
                Rust::StructPatternField.new(
                    outer-attributes => [],
                    struct-pattern-field-variant => Rust::StructPatternFieldVariantId.new(
                        identifier => Rust::Identifier.new(value => "what"),
                        pattern    => Rust::Pattern.new(
                            pattern-no-top-alts => [
                                Rust::IdentifierPattern.new(
                                    ref        => False,
                                    mutable    => False,
                                    identifier => Rust::Identifier.new(value => $what-varname),
                                )
                            ]
                        )
                    )
                )
            ],
            maybe-struct-pattern-etc => Nil,
        )
    }

    our sub create-path-in-expression(@pair) {

        die if not @pair.elems eq 2;

        Rust::PathInExpression.new(
            path-expr-segments => [
                Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => @pair[0],
                    )
                ),
                Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => @pair[1],
                    )
                ),
            ]
        )
    }

    proto sub create-pattern(@exception-nest, $sig) { * }

    multi sub create-pattern(@exception-nest, [1]) {
        die "need implement";
    }

    multi sub create-pattern(@exception-nest, [2]) {

        my $outer = shift @exception-nest;

        Rust::StructPattern.new(
            path-in-expression            => create-path-in-expression($outer),
            maybe-struct-pattern-elements => create-struct-pattern-elements(:$what-varname)
        )
    }

    multi sub create-pattern(@exception-nest, [2,1]) {
        my $outer = shift @exception-nest;

        Rust::TupleStructPattern.new(
            path-in-expression => create-path-in-expression($outer),
            maybe-tuple-struct-items => [
                Rust::Pattern.new(
                    pattern-no-top-alts => [
                        create-pattern(@exception-nest,[1]),
                    ]
                )
            ]
        )
    }

    multi sub create-pattern(@exception-nest, [2,2]) {

        my $outer = shift @exception-nest;

        Rust::TupleStructPattern.new(
            path-in-expression => create-path-in-expression($outer),
            maybe-tuple-struct-items => [
                Rust::Pattern.new(
                    pattern-no-top-alts => [
                        create-pattern(@exception-nest,[2]),
                    ]
                )
            ]
        )
    }

    multi sub create-pattern(@exception-nest, [2,2,1]) {
        my $outer = shift @exception-nest;

        Rust::TupleStructPattern.new(
            path-in-expression => create-path-in-expression($outer),
            maybe-tuple-struct-items => [
                Rust::Pattern.new(
                    pattern-no-top-alts => [
                        create-pattern(@exception-nest,[2,1]),
                    ]
                )
            ]
        )
    }

    multi sub create-pattern(@exception-nest, [2,2,2]) {
        my $outer = shift @exception-nest;

        Rust::TupleStructPattern.new(
            path-in-expression => create-path-in-expression($outer),
            maybe-tuple-struct-items => [
                Rust::Pattern.new(
                    pattern-no-top-alts => [
                        create-pattern(@exception-nest,[2,2]),
                    ]
                )
            ]
        )
    }

    multi sub create-pattern(@exception-nest, [1,1]) {

        my List $p = (@exception-nest[0], @exception-nest[1]);

        Rust::StructPattern.new(
            path-in-expression            => create-path-in-expression($p),
            maybe-struct-pattern-elements => create-struct-pattern-elements(:$what-varname)
        )
    }

    my $sig = @exception-nest>>.elems;

    Rust::Pattern.new(
        pattern-no-top-alts => [
            create-pattern(@exception-nest, $sig)
        ]
    )
}

our sub create-exception-unpacking-match-arm(:$rust-type, :$what-varname, :$block) {

    #this should handle *most*
    my %exception-map = %(
        'invalidargument'      => [ ( 'StdException', 'LogicError'        ),  ( 'LogicError', 'InvalidArgument'        ) ],
        'domainerror'          => [ ( 'StdException', 'LogicError'        ),  ( 'LogicError', 'DomainError'            ) ],
        'lengtherror'          => [ ( 'StdException', 'LogicError'        ),  ( 'LogicError', 'LengthError'            ) ],
        'outofrange'           => [ ( 'StdException', 'LogicError'        ),  ( 'LogicError', 'OutOfRange'             ) ],
        'futureerror'          => [ ( 'StdException', 'LogicError'        ),  ( 'LogicError', 'FutureError'            ) ],
        'logicerror'           => [ ( 'StdException', 'LogicError'        ),  ( 'LogicError', 'Default'                ) ],
        'badoptionalaccess'    => [ ( 'StdException', 'BadOptionalAccess' ),  ( 'BadOptionalAccess'                    ) ],
        'rangeerror'           => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'RangeError'           ) ],
        'overflowerror'        => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'OverflowError'        ) ],
        'underflowerror'       => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'UnderflowError'       ) ],
        'regexerror'           => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'RegexError'           ) ],
        'iosbasefailure'       => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'SystemError'          ),   ( 'SystemError', 'IosBaseFailure'  ) ],
        'filesystemerror'      => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'SystemError'          ),   ( 'SystemError', 'FilesystemError' ) ],
        'systemerror'          => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'SystemError'          ),   ( 'SystemError', 'Default'         ) ],
        'txexception'          => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'TxException'          ) ],
        'nonexistentlocaltime' => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'NonexistentLocalTime' ) ],
        'ambiguouslocaltime'   => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'AmbiguousLocalTime'   ) ],
        'formaterror'          => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'FormatError'          ) ],
        'runtimeerror'         => [ ( 'StdException', 'RuntimeError'      ),  ( 'RuntimeError', 'Default'              ) ],
        'badtypeid'            => [ ( 'StdException', 'BadTypeid'         ),  ( 'BadTypeid'                            ) ],
        'badanycast'           => [ ( 'StdException', 'BadCast'           ),  ( 'BadCast', 'BadAnyCast'                ) ],
        'badcast'              => [ ( 'StdException', 'BadCast'           ),  ( 'BadCast', 'Default'                   ) ],
        'badweakptr'           => [ ( 'StdException', 'BadWeakPtr'        ),  ( 'BadWeakPtr'                           ) ],
        'badfunctioncall'      => [ ( 'StdException', 'BadFunctionCall'   ),  ( 'BadFunctionCall'                      ) ],
        'badarraynewlength'    => [ ( 'StdException', 'BadAlloc'          ),  ( 'BadAlloc', 'BadArrayNewLength'        ) ],
        'badalloc'             => [ ( 'StdException', 'BadAlloc'          ),  ( 'BadAlloc', 'Default'                  ) ],
        'badexception'         => [ ( 'StdException', 'BadException'      ),  ( 'BadException'                         ) ],
        'badvariantaccess'     => [ ( 'StdException', 'BadVariantAccess'  ),  ( 'BadVariantAccess'                     ) ],
        'exception'            => [ ( 'StdException', 'Default'           ) ],
    );

    my $exception-key = $rust-type.gist.lc.subst(:g, "_", "");
    my @exception-nest = %exception-map{$exception-key}.List;

    Rust::MatchArmsOuterItem.new(
        maybe-comment => Nil,
        match-arm => Rust::MatchArm.new(
            outer-attributes      => [],
            pattern               => exception-unpacking-match-pattern(:@exception-nest,:$what-varname),
            maybe-match-arm-guard => Nil,
        ),
        expression => $block,
    )
}
