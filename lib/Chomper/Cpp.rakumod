my package EXPORT::DEFAULT {

    module Cpp {

        use Chomper::Cpp::GcppAbstractDeclarator;
        use Chomper::Cpp::GcppAccess;
        use Chomper::Cpp::GcppAdditiveExpression;
        use Chomper::Cpp::GcppAlign;
        use Chomper::Cpp::GcppAndExpression;
        use Chomper::Cpp::GcppAsm;
        use Chomper::Cpp::GcppAssignment;
        use Chomper::Cpp::GcppAttr;
        use Chomper::Cpp::GcppAttributedStatement;
        use Chomper::Cpp::GcppBalanced;
        use Chomper::Cpp::GcppBase;
        use Chomper::Cpp::GcppBin;
        use Chomper::Cpp::GcppBool;
        use Chomper::Cpp::GcppCastExpression;
        use Chomper::Cpp::GcppChar;
        use Chomper::Cpp::GcppClass;
        use Chomper::Cpp::GcppClassOrDecltype;
        use Chomper::Cpp::GcppComment;
        use Chomper::Cpp::GcppCondition;
        use Chomper::Cpp::GcppConditionalExpression;
        use Chomper::Cpp::GcppConstructor;
        use Chomper::Cpp::GcppConversion;
        use Chomper::Cpp::GcppCv;
        use Chomper::Cpp::GcppDec;
        use Chomper::Cpp::GcppDeclSpecifier;
        use Chomper::Cpp::GcppDeclaration;
        use Chomper::Cpp::GcppDeclarator;
        use Chomper::Cpp::GcppDecltype;
        use Chomper::Cpp::GcppDeleteExpression;
        use Chomper::Cpp::GcppDigit;
        use Chomper::Cpp::GcppElaboratedTypeSpecifier;
        use Chomper::Cpp::GcppEncoding;
        use Chomper::Cpp::GcppEnum;
        use Chomper::Cpp::GcppEqExpression;
        use Chomper::Cpp::GcppEscape;
        use Chomper::Cpp::GcppException;
        use Chomper::Cpp::GcppExpression;
        use Chomper::Cpp::GcppFloat;
        use Chomper::Cpp::GcppForInit;
        use Chomper::Cpp::GcppForRange;
        use Chomper::Cpp::GcppFunction;
        use Chomper::Cpp::GcppHex;
        use Chomper::Cpp::GcppIdExpression;
        use Chomper::Cpp::GcppIdent;
        use Chomper::Cpp::GcppInstantiate;
        use Chomper::Cpp::GcppIntegerLiteral;
        use Chomper::Cpp::GcppIteration;
        use Chomper::Cpp::GcppJumpStatement;
        use Chomper::Cpp::GcppKeywords;
        use Chomper::Cpp::GcppLabeledStatement;
        use Chomper::Cpp::GcppLambda;
        use Chomper::Cpp::GcppLinkage;
        use Chomper::Cpp::GcppLiteral;
        use Chomper::Cpp::GcppLogicalExpression;
        use Chomper::Cpp::GcppMacro;
        use Chomper::Cpp::GcppMemInitializer;
        use Chomper::Cpp::GcppMember;
        use Chomper::Cpp::GcppMultiplicativeExpression;
        use Chomper::Cpp::GcppNamespace;
        use Chomper::Cpp::GcppNestedName;
        use Chomper::Cpp::GcppNew;
        use Chomper::Cpp::GcppNoPtr;
        use Chomper::Cpp::GcppNoexcept;
        use Chomper::Cpp::GcppOct;
        use Chomper::Cpp::GcppOperator;
        use Chomper::Cpp::GcppOperatorId;
        use Chomper::Cpp::GcppOrExpression;
        use Chomper::Cpp::GcppParam;
        use Chomper::Cpp::GcppPostfixExpression;
        use Chomper::Cpp::GcppPrimaryExpression;
        use Chomper::Cpp::GcppPseudoDtor;
        use Chomper::Cpp::GcppPtr;
        use Chomper::Cpp::GcppPtrDeclarator;
        use Chomper::Cpp::GcppPtrMember;
        use Chomper::Cpp::GcppPtrOperator;
        use Chomper::Cpp::GcppPunctuation;
        use Chomper::Cpp::GcppPure;
        use Chomper::Cpp::GcppRef;
        use Chomper::Cpp::GcppRelationalExpression;
        use Chomper::Cpp::GcppReturnStatement;
        use Chomper::Cpp::GcppRoles;
        use Chomper::Cpp::GcppSelection;
        use Chomper::Cpp::GcppShiftExpression;
        use Chomper::Cpp::GcppSimpleTypeSpecifier;
        use Chomper::Cpp::GcppSpecialize;
        use Chomper::Cpp::GcppStatement;
        use Chomper::Cpp::GcppStorageClass;
        use Chomper::Cpp::GcppStr;
        use Chomper::Cpp::GcppSuffix;
        use Chomper::Cpp::GcppTemplate;
        use Chomper::Cpp::GcppToken;
        use Chomper::Cpp::GcppTranslationUnit;
        use Chomper::Cpp::GcppTry;
        use Chomper::Cpp::GcppTypeId;
        use Chomper::Cpp::GcppTypeModifier;
        use Chomper::Cpp::GcppTypeName;
        use Chomper::Cpp::GcppTypeParam;
        use Chomper::Cpp::GcppTypeSpecifier;
        use Chomper::Cpp::GcppTypedef;
        use Chomper::Cpp::GcppUnaryExpression;
        use Chomper::Cpp::GcppUserDefinedLiteral;
        use Chomper::Cpp::GcppUsingDirective;
        use Chomper::Cpp::GcppVirtual;

        my %symbols = %(
            %(Chomper::Cpp::GcppAbstractDeclarator::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAccess::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAdditiveExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAlign::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAndExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAsm::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAssignment::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAttr::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppAttributedStatement::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppBalanced::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppBase::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppBin::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppBool::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppCastExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppChar::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppClass::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppClassOrDecltype::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppComment::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppCondition::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppConditionalExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppConstructor::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppConversion::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppCv::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDec::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDeclSpecifier::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDeclaration::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDeclarator::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDecltype::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDeleteExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppDigit::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppElaboratedTypeSpecifier::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppEncoding::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppEnum::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppEqExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppEscape::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppException::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppFloat::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppForInit::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppForRange::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppFunction::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppHex::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppIdExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppIdent::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppInstantiate::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppIntegerLiteral::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppIteration::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppJumpStatement::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppKeywords::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppLabeledStatement::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppLambda::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppLinkage::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppLiteral::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppLogicalExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppMacro::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppMemInitializer::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppMember::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppMultiplicativeExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppNamespace::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppNestedName::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppNew::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppNoPtr::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppNoexcept::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppOct::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppOperator::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppOperatorId::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppOrExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppParam::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPostfixExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPrimaryExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPseudoDtor::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPtr::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPtrDeclarator::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPtrMember::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPtrOperator::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPunctuation::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppPure::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppRef::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppRelationalExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppReturnStatement::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppRoles::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppSelection::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppShiftExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppSimpleTypeSpecifier::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppSpecialize::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppStatement::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppStorageClass::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppStr::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppSuffix::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTemplate::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppToken::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTranslationUnit::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTry::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTypeId::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTypeModifier::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTypeName::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTypeParam::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTypeSpecifier::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppTypedef::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppUnaryExpression::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppUserDefinedLiteral::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppUsingDirective::EXPORT::DEFAULT::),
            %(Chomper::Cpp::GcppVirtual::EXPORT::DEFAULT::),
        );

        for %symbols.keys -> $key {
            OUR::{$key} := %symbols{$key};
        }
    }
}
