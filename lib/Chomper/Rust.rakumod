my package EXPORT::DEFAULT {

    module Rust {

        use Chomper::Rust::GrustArrayExpression;
        use Chomper::Rust::GrustAscii;
        use Chomper::Rust::GrustAssocItems;
        use Chomper::Rust::GrustBlockComment;
        use Chomper::Rust::GrustBlockExpressions;
        use Chomper::Rust::GrustBooleanLiteral;
        use Chomper::Rust::GrustByteLiteral;
        use Chomper::Rust::GrustByteStringLiteral;
        use Chomper::Rust::GrustCfgAttr;
        use Chomper::Rust::GrustCharLiteral;
        use Chomper::Rust::GrustClosureExpressions;
        use Chomper::Rust::GrustComment;
        use Chomper::Rust::GrustConfiguration;
        use Chomper::Rust::GrustCrate;
        use Chomper::Rust::GrustDelimiters;
        use Chomper::Rust::GrustDocComment;
        use Chomper::Rust::GrustEnumerations;
        use Chomper::Rust::GrustExpressions;
        use Chomper::Rust::GrustExternalBlocks;
        use Chomper::Rust::GrustFloatLiteral;
        use Chomper::Rust::GrustFunctionPointerTypes;
        use Chomper::Rust::GrustFunctions;
        use Chomper::Rust::GrustGenericArgs;
        use Chomper::Rust::GrustGenericParameters;
        use Chomper::Rust::GrustIdentifiers;
        use Chomper::Rust::GrustIfExpressions;
        use Chomper::Rust::GrustImplTrait;
        use Chomper::Rust::GrustIntLiteral;
        use Chomper::Rust::GrustItem;
        use Chomper::Rust::GrustJumpExpressions;
        use Chomper::Rust::GrustLifetimes;
        use Chomper::Rust::GrustLineComment;
        use Chomper::Rust::GrustLiteral;
        use Chomper::Rust::GrustLiteralPattern;
        use Chomper::Rust::GrustLoopExpression;
        use Chomper::Rust::GrustMacros;
        use Chomper::Rust::GrustMatchExpressions;
        use Chomper::Rust::GrustMetaItem;
        use Chomper::Rust::GrustPathExpressions;
        use Chomper::Rust::GrustPaths;
        use Chomper::Rust::GrustPatternExpressions;
        use Chomper::Rust::GrustPunctuation;
        use Chomper::Rust::GrustRangePatterns;
        use Chomper::Rust::GrustReferencePatterns;
        use Chomper::Rust::GrustReservedKeywords;
        use Chomper::Rust::GrustStatements;
        use Chomper::Rust::GrustStrictKeywords;
        use Chomper::Rust::GrustStringLiteral;
        use Chomper::Rust::GrustStructExpressions;
        use Chomper::Rust::GrustStructPatterns;
        use Chomper::Rust::GrustStructs;
        use Chomper::Rust::GrustTokens;
        use Chomper::Rust::GrustTraitObjects;
        use Chomper::Rust::GrustTraits;
        use Chomper::Rust::GrustTupleExpression;
        use Chomper::Rust::GrustTupleStructPatterns;
        use Chomper::Rust::GrustTypeAlias;
        use Chomper::Rust::GrustTypePath;
        use Chomper::Rust::GrustTypes;
        use Chomper::Rust::GrustUnions;
        use Chomper::Rust::GrustUseDeclaration;
        use Chomper::Rust::GrustVisibility;
        use Chomper::Rust::GrustWeakKeywords;
        use Chomper::Rust::GrustWhereClause;
        use Chomper::Rust::GrustWhitespace;
        use Chomper::Rust::GrustXid;

        my %symbols = %(
            %(Chomper::Rust::GrustArrayExpression::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustAscii::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustAssocItems::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustBlockComment::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustBlockExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustBooleanLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustByteLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustByteStringLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustCfgAttr::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustCharLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustClosureExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustComment::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustConfiguration::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustCrate::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustDelimiters::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustDocComment::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustEnumerations::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustExternalBlocks::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustFloatLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustFunctionPointerTypes::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustFunctions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustGenericArgs::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustGenericParameters::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustIdentifiers::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustIfExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustImplTrait::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustIntLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustItem::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustJumpExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustLifetimes::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustLineComment::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustLiteralPattern::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustLoopExpression::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustMacros::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustMatchExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustMetaItem::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustPathExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustPaths::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustPatternExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustPunctuation::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustRangePatterns::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustReferencePatterns::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustReservedKeywords::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustStatements::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustStrictKeywords::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustStringLiteral::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustStructExpressions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustStructPatterns::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustStructs::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTokens::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTraitObjects::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTraits::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTupleExpression::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTupleStructPatterns::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTypeAlias::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTypePath::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustTypes::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustUnions::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustUseDeclaration::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustVisibility::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustWeakKeywords::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustWhereClause::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustWhitespace::EXPORT::DEFAULT::),
            %(Chomper::Rust::GrustXid::EXPORT::DEFAULT::),
        );

        for %symbols.keys -> $key {
            OUR::{$key} := %symbols{$key};
        }
    }
}
