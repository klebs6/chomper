use Grammar::Tracer;

our role CPP14Keyword {
    token Alignas          { 'alignas'          } 
    token Alignof          { 'alignof'          } 
    token Asm              { 'asm'              } 
    token Auto             { 'auto'             } 
    token Bool_            { 'bool'             } 
    token Break            { 'break'            } 
    token Case             { 'case'             } 
    token Catch            { 'catch'            } 
    token Char_            { 'char'             } 
    token Char16           { 'char16_t'         } 
    token Char32           { 'char32_t'         } 
    token Class_           { 'class'            } 
    token Const            { 'const'            } 
    token Constexpr        { 'constexpr'        } 
    token Const_cast       { 'const_cast'       } 
    token Continue         { 'continue'         } 
    token Decltype         { 'decltype'         } 
    token Default          { 'default'          } 
    token Delete           { 'delete'           } 
    token Do               { 'do'               } 
    token Double           { 'double'           } 
    token Dynamic_cast     { 'dynamic_cast'     } 
    token Else             { 'else'             } 
    token Enum             { 'enum'             } 
    token Explicit         { 'explicit'         } 
    token Export           { 'export'           } 
    token Extern           { 'extern'           } 
    token False_           { 'false'            } 
    token Final            { 'final'            } 
    token Float            { 'float'            } 
    token For              { 'for'              } 
    token Friend           { 'friend'           } 
    token Goto             { 'goto'             } 
    token If               { 'if'               } 
    token Inline           { 'inline'           } 
    token Int_             { 'int'              } 
    token Long             { 'long'             } 
    token Mutable          { 'mutable'          } 
    token Namespace        { 'namespace'        } 
    token New              { 'new'              } 
    token Noexcept         { 'noexcept'         } 
    token Nullptr          { 'nullptr'          } 
    token Operator         { 'operator'         } 
    token Override         { 'override'         } 
    token Private          { 'private'          } 
    token Protected        { 'protected'        } 
    token Public           { 'public'           } 
    token Register         { 'register'         } 
    token Reinterpret_cast { 'reinterpret_cast' } 
    token Return           { 'return'           } 
    token Short            { 'short'            } 
    token Signed           { 'signed'           } 
    token Sizeof           { 'sizeof'           } 
    token Static           { 'static'           } 
    token Static_assert    { 'static_assert'    } 
    token Static_cast      { 'static_cast'      } 
    token Struct           { 'struct'           } 
    token Switch           { 'switch'           } 
    token Template         { 'template'         } 
    token This             { 'this'             } 
    token Thread_local     { 'thread_local'     } 
    token Throw            { 'throw'            } 
    token True_            { 'true'             } 
    token Try              { 'try'              } 
    token Typedef          { 'typedef'          } 
    token Typeid_          { 'typeid'           } 
    token Typename_        { 'typename'         } 
    token Union            { 'union'            } 
    token Unsigned         { 'unsigned'         } 
    token Using            { 'using'            } 
    token Virtual          { 'virtual'          } 
    token Void             { 'void'             } 
    token Volatile         { 'volatile'         } 
    token Wchar            { 'wchar_t'          } 
    token While            { 'while'            } 
    token LeftParen        { '('                } 
    token RightParen       { ')'                } 
    token LeftBracket      { '['                } 
    token RightBracket     { ']'                } 
    token LeftBrace        { '{'                } 
    token RightBrace       { '}'                } 
    token Plus             { '+'                } 
    token Minus            { '-'                } 
    token Star             { '*'                } 
    token Div              { '/'                } 
    token Mod              { '%'                } 
    token Caret            { '^'                } 
    token And              { '&' <!before '&'>  } 
    token Or               { '|'                } 
    token Tilde            { '~'                } 
    token Assign           { '='                } 
    token Less             { '<'                } 
    token Greater          { '>'                } 
    token PlusAssign       { '+='               } 
    token MinusAssign      { '-='               } 
    token StarAssign       { '*='               } 
    token DivAssign        { '/='               } 
    token ModAssign        { '%='               } 
    token XorAssign        { '^='               } 
    token AndAssign        { '&='               } 
    token OrAssign         { '|='               } 
    token LeftShiftAssign  { '<<='              } 
    token RightShiftAssign { '>>='              } 
    token Equal            { '=='               } 
    token NotEqual         { '!='               } 
    token LessEqual        { '<='               } 
    token GreaterEqual     { '>='               } 
    token PlusPlus         { '++'               } 
    token MinusMinus       { '--'               } 
    token Comma            { ','                } 
    token ArrowStar        { '->*'              } 
    token Arrow            { '->'               } 
    token Question         { '?'                } 
    token Colon            { ':'                } 
    token Doublecolon      { '::'               } 
    token Semi             { ';'                } 
    token Dot              { '.'                } 
    token DotStar          { '.*'               } 
    token Ellipsis         { '...'              } 

    proto token Not { * }
    token Not:sym<!>       { <sym> }
    token Not:sym<not>     { <sym> }

    proto token AndAnd { * }
    token AndAnd:sym<&&>   { <sym> }
    token AndAnd:sym<and>  { <sym> }

    proto token OrOr { * }
    token OrOr:sym<||>     { <sym> }
    token OrOr:sym<or>     { <sym> }
}

our role CPP14Lexer does CPP14Keyword {

    token IntegerLiteral {
        ||  <DecimalLiteral> <Integersuffix>?
        ||  <OctalLiteral> <Integersuffix>?
        ||  <HexadecimalLiteral> <Integersuffix>?
        ||  <BinaryLiteral> <Integersuffix>?
    }

    token CharacterLiteral {
        ||  [   ||  'u'
                ||  'U'
                ||  'L'
            ]?
            '\''
            <Cchar>+
            '\''
    }

    token FloatingLiteral {
        ||  <Fractionalconstant> <Exponentpart>?  <Floatingsuffix>?
        ||  <Digitsequence> <Exponentpart> <Floatingsuffix>?
    }

    token StringLiteral {
        <Encodingprefix>?
        [   
            ||  <Rawstring>
            ||  '"' <Schar>* '"'
        ]
    }

    token BooleanLiteral {
        ||  <False_>
        ||  <True_>
    }

    token PointerLiteral {
        ||  <Nullptr>
    }

    token UserDefinedLiteral {
        ||  <UserDefinedIntegerLiteral>
        ||  <UserDefinedFloatingLiteral>
        ||  <UserDefinedStringLiteral>
        ||  <UserDefinedCharacterLiteral>
    }

    token MultiLineMacro {
        ||  '#'
            [   ||  <-[ \n ]>*?
                    '\\'
                    '\r'?
                    '\n'
            ]
            <-[ \n ]>+
    }

    token Directive {
        '#' <-[ \n ]>*
    }

    token Hexquad {
        <HEXADECIMALDIGIT> ** 4
    }

    token Universalcharactername {
        || '\\u' <Hexquad>
        || '\\U' <Hexquad> <Hexquad>
    }

    token IdentifierStart {
        || <NONDIGIT>
        || <Universalcharactername>
    }

    token IdentifierContinue {
        || <DIGIT>
        || <NONDIGIT>
        || <Universalcharactername>
    }

    token Identifier {
        <IdentifierStart>
        <IdentifierContinue>*
    }

    token NONDIGIT {
        <[ a .. z A .. Z _]>
    }

    token DIGIT {
        <[ 0 .. 9 ]>
    }

    token DecimalLiteral {
        <NONZERODIGIT> [ '\''?  <DIGIT>]*
    }

    token OctalLiteral {
        '0' [ '\''?  <OCTALDIGIT>]*
    }

    token HexadecimalLiteral {
        [ '0x' || '0X' ] <HEXADECIMALDIGIT> [ '\''?  <HEXADECIMALDIGIT> ]*
    }

    token BinaryLiteral {
        [ '0b' || '0B' ] <BINARYDIGIT> [ '\''?  <BINARYDIGIT> ]*
    }

    token NONZERODIGIT {
        <[ 1 .. 9 ]>
    }

    token OCTALDIGIT {
        <[ 0 .. 7 ]>
    }

    token HEXADECIMALDIGIT {
        <[ 0 .. 9 ]>
    }

    token BINARYDIGIT {
        <[ 0 1 ]>
    }

    token Integersuffix {
        ||  <Unsignedsuffix> <Longsuffix>?
        ||  <Unsignedsuffix> <Longlongsuffix>?
        ||  <Longsuffix>     <Unsignedsuffix>?
        ||  <Longlongsuffix> <Unsignedsuffix>?
    }

    token Unsignedsuffix {
        <[ u U ]>
    }

    token Longsuffix {
        <[ l L ]>
    }

    token Longlongsuffix {
        ||  'll'
        ||  'LL'
    }

    token Cchar {
        ||  <-[ \' \\ \r \n ]>
        ||  <Escapesequence>
        ||  <Universalcharactername>
    }

    token Escapesequence {
        ||  <Simpleescapesequence>
        ||  <Octalescapesequence>
        ||  <Hexadecimalescapesequence>
    }

    token Simpleescapesequence {
        ||  '\\\''
        ||  '\\"'
        ||  '\\?'
        ||  '\\\\'
        ||  '\\a'
        ||  '\\b'
        ||  '\\f'
        ||  '\\n'
        ||  '\\r'
        ||  [   ||  '\\'
                    [   ||  '\r'
                            '\n'?
                        ||  '\n'
                    ]
            ]
        ||  '\\t'
        ||  '\\v'
    }

    token Octalescapesequence {
        ||  '\\' <OCTALDIGIT>
        ||  '\\' <OCTALDIGIT> <OCTALDIGIT>
        ||  '\\' <OCTALDIGIT> <OCTALDIGIT> <OCTALDIGIT>
    }

    token Hexadecimalescapesequence {
        '\\x' <HEXADECIMALDIGIT>+
    }

    token Fractionalconstant {
        ||  <Digitsequence>?  '.' <Digitsequence>
        ||  <Digitsequence> '.'
    }

    token Exponentpart {
        ||  'e' <SIGN>?  <Digitsequence>
        ||  'E' <SIGN>?  <Digitsequence>
    }

    token SIGN {
        <[ + - ]>
    }

    token Digitsequence {
        <DIGIT> [  '\''?  <DIGIT>]*
    }

    token Floatingsuffix {
        <[ f l F L ]>
    }

    token Encodingprefix {
        ||  'u8'
        ||  'u'
        ||  'U'
        ||  'L'
    }

    token Schar {
        ||  <-[ " \\ \r \n ]>
        ||  <Escapesequence>
        ||  <Universalcharactername>
    }

    token Rawstring {
        ||  'R"'
            [   ||  [   ||  '\\'
                            <[ " ( ) ]>
                    ]
                ||  <-[ \r \n   ( ]>
            ]
            '('
            <-[ ) ]>*?
            ')'
            [   ||  [   ||  '\\'
                            <[ " ( ) ]>
                    ]
                ||  <-[ \r \n   " ]>
            ]
            '"'
    }

    token UserDefinedIntegerLiteral {
        ||  <DecimalLiteral> <Udsuffix>
        ||  <OctalLiteral> <Udsuffix>
        ||  <HexadecimalLiteral> <Udsuffix>
        ||  <BinaryLiteral> <Udsuffix>
    }

    token UserDefinedFloatingLiteral {
        ||  <Fractionalconstant> <Exponentpart>?  <Udsuffix>
        ||  <Digitsequence> <Exponentpart> <Udsuffix>
    }

    token UserDefinedStringLiteral {
        ||  <StringLiteral> <Udsuffix>
    }

    token UserDefinedCharacterLiteral {
        ||  <CharacterLiteral> <Udsuffix>
    }

    token Udsuffix {
        <Identifier>
    }

    token Whitespace {
        <[   \t ]>+
    }

    token Newline {
        [   
            ||  '\r' '\n'?
            ||  '\n'
        ]
    }

    token BlockComment {
        '/*' .*?  '*/'
    }

    token LineComment {
        '//' <-[ \r \n ]>*
    }
}

our role CPP14Parser does CPP14Lexer {

    rule TOP {
        <.ws> 
        <statementSeq>
    }

    token translationUnit {
        <declarationseq>?  $
    }

    token primaryExpression {
        ||  <literal>+
        ||  <This>
        ||  <LeftParen> <expression> <RightParen>
        ||  <idExpression>
        ||  <lambdaExpression>
    }

    #-------------------------------
    proto regex idExpression { * }
    regex idExpression:sym<qualified>   { <qualifiedId> }
    regex idExpression:sym<unqualified> { <unqualifiedId> }

    #-------------------------------
    proto regex unqualifiedId { * }
    regex unqualifiedId:sym<ident>               { <Identifier> }
    regex unqualifiedId:sym<op-func-id>          { <operatorFunctionId> }
    regex unqualifiedId:sym<conversion-func-id>  { <conversionFunctionId> }
    regex unqualifiedId:sym<literal-operator-id> { <literalOperatorId> }
    regex unqualifiedId:sym<tilde>               { <Tilde> [   <className> ||  <decltypeSpecifier> ] }
    regex unqualifiedId:sym<template-id>         { <templateId> }

    #-------------------------------
    regex qualifiedId {
        <nestedNameSpecifier> 
        <Template>?  
        <unqualifiedId>
    }

    regex nestedNameSpecifierPrefix {
        [   
            |  <theTypeName>
            |  <namespaceName>
            |  <decltypeSpecifier>
        ]?
        <Doublecolon>
    }

    regex nestedNameSpecifierSuffix {
        [   
            |  <Identifier>
            |  <Template>? <simpleTemplateId>
        ]
        <Doublecolon>
    }

    regex nestedNameSpecifier {
        <nestedNameSpecifierPrefix> 
        <nestedNameSpecifierSuffix>*
    }

    rule lambdaExpression {
        <lambdaIntroducer> <lambdaDeclarator>?  <compoundStatement>
    }

    rule lambdaIntroducer {
        <LeftBracket> <lambdaCapture>?  <RightBracket>
    }

    rule lambdaCapture {
        ||  <captureList>
        ||  <captureDefault> [ <Comma> <captureList> ]?
    }

    rule captureDefault {
        ||  <And>
        ||  <Assign>
    }

    rule captureList {
        <capture> [ <Comma> <capture> ]* <Ellipsis>?
    }

    rule capture {
        ||  <simpleCapture>
        ||  <initcapture>
    }

    rule simpleCapture {
        ||  <And>?  <Identifier>
        ||  <This>
    }

    rule initcapture {
        <And>?  <Identifier> <initializer>
    }

    rule lambdaDeclarator {
        <LeftParen>
        <parameterDeclarationClause>?
        <RightParen>
        <Mutable>?
        <exceptionSpecification>?
        <attributeSpecifierSeq>?
        <trailingReturnType>?
    }

    #-------------------------------------
    rule postfixExpression {  
        <postfixExpressionBody> <postfixExpressionTail>*
    }

    proto rule postfixExpressionTail { * }

    rule postfixExpressionTail:sym<bracket> {
        <LeftBracket> 
        [  <expression> ||  <bracedInitList> ] 
        <RightBracket>
    }

    rule postfixExpressionTail:sym<parens> { 
        <LeftParen> 
        <expressionList>?  
        <RightParen>
    }

    rule postfixExpressionTail:sym<indirection> { 
        [ <Dot> ||  <Arrow> ]
        [   
            ||  <Template>?  <idExpression> 
            ||  <pseudoDestructorName> 
        ]
    }

    rule postfixExpressionTail:sym<pp-mm> { 
        [ <PlusPlus> ||  <MinusMinus> ]
    }

    #-------------------------------------
    proto rule postfixExpressionBody { * }

    rule postfixExpressionBody:sym<primary> { 
        <primaryExpression>
    }

    rule postfixExpressionBody:sym<post-list> { 

        [
            ||  <simpleTypeSpecifier> 
            ||  <typeNameSpecifier>
        ]

        [   
            ||  <LeftParen> <expressionList>?  <RightParen> 
            ||  <bracedInitList>
        ]
    }

    rule postfixExpressionBody:sym<cast> { 
        [ 
            || <Dynamic_cast> 
            || <Static_cast> 
            || <Reinterpret_cast> 
            ||  <Const_cast>
        ]
        <Less> 
        <theTypeId> 
        <Greater> 
        <LeftParen> 
        <expression> 
        <RightParen>
    }

    rule postfixExpressionBody:sym<typeid> {
        <typeIdOfTheTypeId> 
        <LeftParen> 
        [ <expression> ||  <theTypeId>] 
        <RightParen>
    }

    #-------------------------------------
    rule typeIdOfTheTypeId {
        <Typeid_>
    }

    rule expressionList {
        <initializerList>
    }

    rule pseudoDestructorName {
        ||  <nestedNameSpecifier>?
            [   ||  <theTypeName>
                    <Doublecolon>
            ]?
            <Tilde>
            <theTypeName>
        ||  <nestedNameSpecifier>
            <Template>
            <simpleTemplateId>
            <Doublecolon>
            <Tilde>
            <theTypeName>
        ||  <Tilde>
            <decltypeSpecifier>
    }

    rule unaryExpression {
        ||  <postfixExpression>
        ||  [   ||  <PlusPlus>
                ||  <MinusMinus>
                ||  <unaryOperator>
                ||  <Sizeof>
            ]
            <unaryExpression>
        ||  <Sizeof>
            [   ||  <LeftParen>
                    <theTypeId>
                    <RightParen>
                ||  <Ellipsis>
                    <LeftParen>
                    <Identifier>
                    <RightParen>
            ]
        ||  <Alignof> <LeftParen> <theTypeId> <RightParen>
        ||  <noExceptExpression>
        ||  <newExpression>
        ||  <deleteExpression>
    }

    #--------------------------------------
    proto rule unaryOperator { * } 
    rule unaryOperator:sym<Or>    { <Or>    } 
    rule unaryOperator:sym<Star>  { <Star>  } 
    rule unaryOperator:sym<And>   { <And>   } 
    rule unaryOperator:sym<Plus>  { <Plus>  } 
    rule unaryOperator:sym<Tilde> { <Tilde> } 
    rule unaryOperator:sym<Minus> { <Minus> } 
    rule unaryOperator:sym<Not>   { <Not>   } 

    #--------------------------------------
    rule newExpression {
        ||  <Doublecolon>?
            <New>
            <newPlacement>?
            [   ||  <newTypeId>
                ||  [   ||  <LeftParen>
                            <theTypeId>
                            <RightParen>
                    ]
            ]
            <newInitializer>?
    }

    rule newPlacement {
        <LeftParen>
        <expressionList>
        <RightParen>
    }

    rule newTypeId {
        <typeSpecifierSeq> <newDeclarator>?
    }

    rule newDeclarator {
        ||  <pointerOperator> <newDeclarator>?
        ||  <noPointerNewDeclarator>
    }

    rule noPointerNewDeclarator {
        ||  <LeftBracket>
            <expression>
            <RightBracket>
            <attributeSpecifierSeq>?
        ||  <noPointerNewDeclarator>
            <LeftBracket>
            <constantExpression>
            <RightBracket>
            <attributeSpecifierSeq>?
    }

    rule newInitializer {
        ||  <LeftParen> <expressionList>?  <RightParen>
        ||  <bracedInitList>
    }

    rule deleteExpression {
        ||  <Doublecolon>?
            <Delete>
            [   ||  <LeftBracket>
                    <RightBracket>
            ]?
            <castExpression>
    }

    rule noExceptExpression {
        <Noexcept>
        <LeftParen>
        <expression>
        <RightParen>
    }

    rule castExpression {
        ||  <unaryExpression>
        ||  <LeftParen> <theTypeId> <RightParen> <castExpression>
    }

    rule pointerMemberExpression {
        ||  <castExpression>
            [   ||  [   ||  <DotStar>
                        ||  <ArrowStar>
                    ]
                    <castExpression>
            ]*
    }

    rule multiplicativeExpression {
        ||  <pointerMemberExpression>
            [   ||  [   ||  <Star>
                        ||  <Div>
                        ||  <Mod>
                    ]
                    <pointerMemberExpression>
            ]*
    }

    rule additiveExpression {
        ||  <multiplicativeExpression>
            [   ||  [   ||  <Plus>
                        ||  <Minus>
                    ]
                    <multiplicativeExpression>
            ]*
    }

    rule shiftExpression {
        ||  <additiveExpression>
            [   ||  <shiftOperator>
                    <additiveExpression>
            ]*
    }

    #-----------------------
    proto rule shiftOperator { * }
    rule shiftOperator:sym<right> { <Greater> <Greater> }
    rule shiftOperator:sym<left>  { <Less> <Less> }

    #-----------------------
    regex relationalExpression {
        <shiftExpression>
        [  
            [   
                ||  <Less>
                ||  <Greater>
                ||  <LessEqual>
                ||  <GreaterEqual>
            ]
            <shiftExpression>
        ]*
    }

    rule equalityExpression {
        <relationalExpression>
        [   
            [ <Equal> ||  <NotEqual> ] <relationalExpression>
        ]*
    }

    rule andExpression {
        <equalityExpression> [ <And> <equalityExpression> ]*
    }

    rule exclusiveOrExpression {
        <andExpression> [  <Caret> <andExpression> ]*
    }

    rule inclusiveOrExpression {
        <exclusiveOrExpression> [ <Or> <exclusiveOrExpression> ]*
    }

    rule logicalAndExpression {
        <inclusiveOrExpression> [  <AndAnd> <inclusiveOrExpression>]*
    }

    rule logicalOrExpression {
        <logicalAndExpression> [ <OrOr> <logicalAndExpression> ]*
    }

    rule conditionalExpression {
        <logicalOrExpression>
        [ 
            <Question> 
            <expression> 
            <Colon> 
            <assignmentExpression> 
        ]?
    }

    proto rule assignmentExpression { * }

    rule assignmentExpression:sym<basic> {  
        <logicalOrExpression> <assignmentOperator> <initializerClause>
    }

    rule assignmentExpression:sym<conditional> {  
        <conditionalExpression>
    }

    rule assignmentExpression:sym<throw> {  
        <throwExpression>
    }

    proto token assignmentOperator { * }
    token assignmentOperator:sym<assign>        { <Assign>           } 
    token assignmentOperator:sym<star-assign>   { <StarAssign>       } 
    token assignmentOperator:sym<div-assign>    { <DivAssign>        } 
    token assignmentOperator:sym<mod-assign>    { <ModAssign>        } 
    token assignmentOperator:sym<plus-assign>   { <PlusAssign>       } 
    token assignmentOperator:sym<minus-assign>  { <MinusAssign>      } 
    token assignmentOperator:sym<rshift-assign> { <RightShiftAssign> } 
    token assignmentOperator:sym<lshift-assign> { <LeftShiftAssign>  } 
    token assignmentOperator:sym<and-assign>    { <AndAssign>        } 
    token assignmentOperator:sym<xor-assign>    { <XorAssign>        } 
    token assignmentOperator:sym<or-assign>     { <OrAssign>         } 

    rule expression {
        <assignmentExpression>+ %% <Comma>
    }

    rule constantExpression { <conditionalExpression> }

    proto rule comment { * }

    regex comment:sym<line> {
        [<LineComment> <.ws>?]+
    }

    rule comment:sym<block> {
        <BlockComment>
    }

    #-----------------------------
    proto token statement { * }

    token statement:sym<attributed> { 
        <comment>?
        <attributeSpecifierSeq>?
        <attributedStatementBody>
    }

    token statement:sym<labeled>     { <comment>? <labeledStatement> }
    token statement:sym<declaration> { <comment>? <declarationStatement> }

    proto rule attributedStatementBody { * }
    rule attributedStatementBody:sym<expression> { <expressionStatement> }
    rule attributedStatementBody:sym<compound>   { <compoundStatement> }
    rule attributedStatementBody:sym<selection>  { <selectionStatement> }
    rule attributedStatementBody:sym<iteration>  { <iterationStatement> }
    rule attributedStatementBody:sym<jump>       { <jumpStatement> }
    rule attributedStatementBody:sym<try>        { <tryBlock> }

    rule labeledStatementLabel {
        <attributeSpecifierSeq>?
        [   
            ||  <Identifier>
            ||  <Case> <constantExpression>
            ||  <Default>
        ]
        <Colon>
    }

    rule labeledStatement {
        <labeledStatementLabel>
        <statement>
    }

    rule declarationStatement { <blockDeclaration> }

    #-----------------------------
    rule expressionStatement {
        <expression>?  <Semi>
    }

    rule compoundStatement {
        <LeftBrace> <statementSeq>?  <RightBrace>
    }

    regex statementSeq {
        <statement> [<.ws> <statement>]*
    }

    #-----------------------------
    proto rule selectionStatement { * }

    rule selectionStatement:sym<if> {  
        <If>
        <LeftParen>
        <condition>
        <RightParen>
        <statement>
        [ <Else> <statement> ]?
    }

    rule selectionStatement:sym<switch> {  
        <Switch> <LeftParen> <condition> <RightParen> <statement>
    }

    #-----------------------------
    rule condition {
        ||  <expression>
        ||  <attributeSpecifierSeq>?
            <declSpecifierSeq> 
            <declarator>
            [   
                ||  <Assign> <initializerClause>
                ||  <bracedInitList>
            ]
    }

    #-----------------------------
    proto rule iterationStatement { * }

    rule iterationStatement:sym<while> {
        <While>
        <LeftParen>
        <condition>
        <RightParen>
        <statement>
    }

    rule iterationStatement:sym<do> {
        <Do>
        <statement>
        <While>
        <LeftParen>
        <expression>
        <RightParen>
        <Semi>
    }

    rule iterationStatement:sym<for> {
        <For>
        <LeftParen>
        <forInitStatement>
        <condition>?
        <Semi>
        <expression>?
        <RightParen>
        <statement>
    }

    rule iterationStatement:sym<for-range> {
        <For>
        <LeftParen>
        <forRangeDeclaration>
        <Colon>
        <forRangeInitializer>
        <RightParen>
        <statement>
    }

    #-----------------------------
    proto rule forInitStatement { * }
    rule forInitStatement:sym<expressionStatement> { <expressionStatement> }
    rule forInitStatement:sym<simpleDeclaration> { <simpleDeclaration> }

    rule forRangeDeclaration {
        <attributeSpecifierSeq>?
        <declSpecifierSeq>
        <declarator>
    }

    proto rule forRangeInitializer { * }
    rule forRangeInitializer:sym<expression> { <expression> }
    rule forRangeInitializer:sym<bracedInitList> { <bracedInitList> }

    #-------------------------------
    proto rule jumpStatement { * }
    rule jumpStatement:sym<break>    { <Break>                                        <Semi> } 
    rule jumpStatement:sym<continue> { <Continue>                                     <Semi> } 
    rule jumpStatement:sym<return>   { <Return> [ <expression> || <bracedInitList> ]? <Semi> } 
    rule jumpStatement:sym<goto>     { <Goto> <Identifier>                            <Semi> } 

    rule declarationseq { <declaration>+ }

    #-------------------------------
    proto rule declaration { * }
    rule declaration:sym<blockDeclaration>       { <blockDeclaration>         } 
    rule declaration:sym<functionDefinition>     { <functionDefinition>       } 
    rule declaration:sym<templateDeclaration>    { <templateDeclaration>      } 
    rule declaration:sym<explicitInstantiation>  { <explicitInstantiation>    } 
    rule declaration:sym<explicitSpecialization> { <explicitSpecialization>   } 
    rule declaration:sym<linkageSpecification>   { <linkageSpecification>     } 
    rule declaration:sym<namespaceDefinition>    { <namespaceDefinition>      } 
    rule declaration:sym<emptyDeclaration>       { <emptyDeclaration>         } 
    rule declaration:sym<attributeDeclaration>   { <attributeDeclaration>     } 

    proto rule blockDeclaration { * }
    rule blockDeclaration:sym<simple>            { <simpleDeclaration>        } 
    rule blockDeclaration:sym<asm>               { <asmDefinition>            } 
    rule blockDeclaration:sym<namespace-alias>   { <namespaceAliasDefinition> } 
    rule blockDeclaration:sym<using-decl>        { <usingDeclaration>         } 
    rule blockDeclaration:sym<using-directive>   { <usingDirective>           } 
    rule blockDeclaration:sym<static-assert>     { <staticAssertDeclaration>  } 
    rule blockDeclaration:sym<alias>             { <aliasDeclaration>         } 
    rule blockDeclaration:sym<opaque-enum-decl>  { <opaqueEnumDeclaration>    } 

    rule aliasDeclaration {
        <Using>
        <Identifier>
        <attributeSpecifierSeq>?
        <Assign>
        <theTypeId>
        <Semi>
    }

    #---------------------------
    proto rule simpleDeclaration { * }
    rule simpleDeclaration:sym<basic>     { <declSpecifierSeq>?  <initDeclaratorList>?  <Semi> }
    rule simpleDeclaration:sym<init-list> { <attributeSpecifierSeq> <declSpecifierSeq>?  <initDeclaratorList> <Semi> }

    rule staticAssertDeclaration {
        <Static_assert>
        <LeftParen>
        <constantExpression>
        <Comma>
        <StringLiteral>
        <RightParen>
        <Semi>
    }

    rule emptyDeclaration {
        ||  <Semi>
    }

    rule attributeDeclaration {
        ||  <attributeSpecifierSeq>
            <Semi>
    }

    rule declSpecifier {
        [
            ||  <storageClassSpecifier>
            ||  <typeSpecifier> 
            ||  <functionSpecifier>
            ||  <Friend>
            ||  <Typedef>
            ||  <Constexpr>
        ]
    }

    rule declSpecifierSeq {
        <declSpecifier>+?  <attributeSpecifierSeq>?  
    }
    #---------------------------
    proto rule storageClassSpecifier { * }
    rule storageClassSpecifier:sym<Register>     { <Register>     } 
    rule storageClassSpecifier:sym<Static>       { <Static>       } 
    rule storageClassSpecifier:sym<Thread_local> { <Thread_local> } 
    rule storageClassSpecifier:sym<Extern>       { <Extern>       } 
    rule storageClassSpecifier:sym<Mutable>      { <Mutable>      } 
    #---------------------------
    proto rule functionSpecifier { * }
    rule functionSpecifier:sym<inline>   { <Inline> }
    rule functionSpecifier:sym<virtual>  { <Virtual> }
    rule functionSpecifier:sym<explicit> { <Explicit> }
    rule typedefName {
        ||  <Identifier>
    }
    #---------------------------
    proto rule typeSpecifier { * }
    rule typeSpecifier:sym<trailingTypeSpecifier> { <trailingTypeSpecifier> }
    rule typeSpecifier:sym<classSpecifier>        { <classSpecifier>        }
    rule typeSpecifier:sym<enumSpecifier>         { <enumSpecifier>         }

    #---------------------------
    proto rule trailingTypeSpecifier { * }
    rule trailingTypeSpecifier:sym<cv-qualifier> { <cvQualifier> <simpleTypeSpecifier> }
    rule trailingTypeSpecifier:sym<simple>       { <simpleTypeSpecifier>     } 
    rule trailingTypeSpecifier:sym<elaborated>   { <elaboratedTypeSpecifier> } 
    rule trailingTypeSpecifier:sym<typename>     { <typeNameSpecifier>       } 

    #---------------------------
    rule typeSpecifierSeq {
        <typeSpecifier>+ <attributeSpecifierSeq>?
    }

    rule trailingTypeSpecifierSeq {
        <trailingTypeSpecifier>+ <attributeSpecifierSeq>?
    }

    proto rule simpleTypeLengthModifier { * }
    rule simpleTypeLengthModifier:sym<Short> { <Short> }
    rule simpleTypeLengthModifier:sym<Long>  { <Long>  }

    proto rule simpleTypeSignednessModifier         { * }
    rule simpleTypeSignednessModifier:sym<Unsigned> { <Unsigned> }
    rule simpleTypeSignednessModifier:sym<Signed>   { <Signed> }

    token full-type-name {
        <nestedNameSpecifier>? <theTypeName>
    }

    token scoped-template-id {
        <nestedNameSpecifier> <Template> <simpleTemplateId>
    }

    token simple-int-type-specifier {
        <simpleTypeSignednessModifier>?  <simpleTypeLengthModifier>* <Int_>
    }

    token simple-char-type-specifier {
        <simpleTypeSignednessModifier>?  <Char_>
    }

    token simple-char16-type-specifier {
        <simpleTypeSignednessModifier>?  <Char16>
    }

    token simple-char32-type-specifier {
        <simpleTypeSignednessModifier>?  <Char32>
    }

    token simple-wchar-type-specifier {
        <simpleTypeSignednessModifier>?  <Wchar>
    }

    token simple-double-type-specifier {
        <simpleTypeLengthModifier>?  <Double>
    }

    rule simpleTypeSpecifier {
        | <full-type-name>
        | <scoped-template-id>
        | <simpleTypeSignednessModifier>
        | <simpleTypeSignednessModifier>?  <simpleTypeLengthModifier>+
        | <simple-char-type-specifier>
        | <simple-char16-type-specifier>
        | <simple-char32-type-specifier>
        | <simple-wchar-type-specifier>
        | <Bool_>
        | <simple-int-type-specifier>
        | <Float>
        | <simple-double-type-specifier>
        | <Void>
        | <Auto>
        | <decltypeSpecifier>
    }

    #------------------------------
    proto rule theTypeName                   { * }
    rule theTypeName:sym<simple-template-id> { <simpleTemplateId> }
    rule theTypeName:sym<class>              { <className> }
    rule theTypeName:sym<enum>               { <enumName> }
    rule theTypeName:sym<typedef>            { <typedefName> }

    #------------------------------
    rule decltypeSpecifier {
        <Decltype>
        <LeftParen>
        [   
            ||  <expression>
            ||  <Auto>
        ]
        <RightParen>
    }

    rule elaboratedTypeSpecifier {
        ||  <classKey>
            [   ||  <attributeSpecifierSeq>?
                    <nestedNameSpecifier>?
                    <Identifier>
                ||  <simpleTemplateId>
                ||  <nestedNameSpecifier>
                    <Template>?
                    <simpleTemplateId>
            ]
        ||  <Enum>
            <nestedNameSpecifier>?
            <Identifier>
    }

    rule enumName {
        <Identifier>
    }

    rule enumSpecifier {
        ||  <enumHead>
            <LeftBrace>
            [   ||  <enumeratorList>
                    <Comma>?
            ]?
            <RightBrace>
    }

    rule enumHead {
        ||  <enumkey>
            <attributeSpecifierSeq>?
            [   ||  <nestedNameSpecifier>?
                    <Identifier>
            ]?
            <enumbase>?
    }

    rule opaqueEnumDeclaration {
        ||  <enumkey>
            <attributeSpecifierSeq>?
            <Identifier>
            <enumbase>?
            <Semi>
    }

    rule enumkey {
        ||  <Enum>
            [   ||  <Class_>
                ||  <Struct>
            ]?
    }

    rule enumbase {
        <Colon> <typeSpecifierSeq>
    }

    rule enumeratorList {
        ||  <enumeratorDefinition>
            [   ||  <Comma>
                    <enumeratorDefinition>
            ]*
    }

    rule enumeratorDefinition {
        ||  <enumerator>
            [   ||  <Assign>
                    <constantExpression>
            ]?
    }

    rule enumerator {
        ||  <Identifier>
    }

    rule namespaceName {
        ||  <originalNamespaceName>
        ||  <namespaceAlias>
    }

    rule originalNamespaceName {
        ||  <Identifier>
    }

    rule namespaceDefinition {
        ||  <Inline>?
            <Namespace>
            [   ||  <Identifier>
                ||  <originalNamespaceName>
            ]?
            <LeftBrace>
            <namespaceBody=declarationseq>?
            <RightBrace>
    }

    rule namespaceAlias {
        ||  <Identifier>
    }

    rule namespaceAliasDefinition {
        ||  <Namespace>
            <Identifier>
            <Assign>
            <qualifiednamespacespecifier>
            <Semi>
    }

    rule qualifiednamespacespecifier {
        ||  <nestedNameSpecifier>?
            <namespaceName>
    }

    rule usingDeclaration {
        ||  <Using>
            [   ||  [   ||  <Typename_>?
                            <nestedNameSpecifier>
                    ]
                ||  <Doublecolon>
            ]
            <unqualifiedId>
            <Semi>
    }

    rule usingDirective {
        ||  <attributeSpecifierSeq>?
            <Using>
            <Namespace>
            <nestedNameSpecifier>?
            <namespaceName>
            <Semi>
    }

    rule asmDefinition {
        ||  <Asm>
            <LeftParen>
            <StringLiteral>
            <RightParen>
            <Semi>
    }

    rule linkageSpecification {
        ||  <Extern>
            <StringLiteral>
            [   ||  <LeftBrace>
                    <declarationseq>?
                    <RightBrace>
                ||  <declaration>
            ]
    }

    rule attributeSpecifierSeq {
        <attributeSpecifier>+
    }

    rule attributeSpecifier {
        ||  <LeftBracket>
            <LeftBracket>
            <attributeList>?
            <RightBracket>
            <RightBracket>
        ||  <alignmentspecifier>
    }

    rule alignmentspecifier {
        ||  <Alignas>
            <LeftParen>
            [   ||  <theTypeId>
                ||  <constantExpression>
            ]
            <Ellipsis>?
            <RightParen>
    }
    rule attributeList {
        ||  <attribute>
            [   ||  <Comma>
                    <attribute>
            ]*
            <Ellipsis>?
    }
    rule attribute {
        ||  [   ||  <attributeNamespace>
                    <Doublecolon>
            ]?
            <Identifier>
            <attributeArgumentClause>?
    }
    rule attributeNamespace {
        ||  <Identifier>
    }
    rule attributeArgumentClause {
        <LeftParen> <balancedTokenSeq>?  <RightParen>
    }

    rule balancedTokenSeq {
        <balancedrule>+
    }

    rule balancedrule {
        ||  <LeftParen> <balancedTokenSeq> <RightParen>
        ||  <LeftBracket> <balancedTokenSeq> <RightBracket>
        ||  <LeftBrace> <balancedTokenSeq> <RightBrace>
    }

    rule initDeclaratorList {
        <initDeclarator> [ <Comma> <initDeclarator> ]*
    }

    rule initDeclarator {
        <declarator> <initializer>?
    }

    rule declarator {
        ||  <pointerDeclarator>
        ||  <noPointerDeclarator> <parametersAndQualifiers> <trailingReturnType>
    }

    rule pointerDeclarator {
        [ <pointerOperator> <Const>? ]* <noPointerDeclarator>
    }

    #------------------------------

    rule noPointerDeclaratorBase {
        | <declaratorid> <attributeSpecifierSeq>?
        | <LeftParen> <pointerDeclarator> <RightParen>
    }

    rule noPointerDeclarator {
        <noPointerDeclaratorBase>
        [   
            ||  <parametersAndQualifiers>
            ||  <LeftBracket> <constantExpression>?  <RightBracket> <attributeSpecifierSeq>?
        ]*
    }

    #------------------------------
    rule parametersAndQualifiers {
        ||  <LeftParen>
            <parameterDeclarationClause>?
            <RightParen>
            <cvqualifierseq>?
            <refqualifier>?
            <exceptionSpecification>?
            <attributeSpecifierSeq>?
    }
    rule trailingReturnType {
        ||  <Arrow>
            <trailingTypeSpecifierSeq>
            <abstractDeclarator>?
    }
    rule pointerOperator {
        ||  [   ||  <And>
                ||  <AndAnd>
            ]
            <attributeSpecifierSeq>?
        ||  <nestedNameSpecifier>?
            <Star>
            <attributeSpecifierSeq>?
            <cvqualifierseq>?
    }

    rule cvqualifierseq {
        <cvQualifier>+
    }

    proto rule cvQualifier { * }
    rule cvQualifier:sym<const>    { <Const> }
    rule cvQualifier:sym<volatile> { <Volatile> }

    rule refqualifier {
        ||  <And>
        ||  <AndAnd>
    }

    rule declaratorid {
        <Ellipsis>?  <idExpression>
    }

    rule theTypeId {
        <typeSpecifierSeq> <abstractDeclarator>?
    }

    rule abstractDeclarator {
        | <pointerAbstractDeclarator>
        | <noPointerAbstractDeclarator>? <parametersAndQualifiers> <trailingReturnType>
        | <abstractPackDeclarator>
    }

    #-------------------[x]
    rule pointerAbstractDeclarator {
        | <noPointerAbstractDeclarator>
        | <pointerOperator>+ <noPointerAbstractDeclarator>?
    }

    #-------------------[x]
    proto rule noPointerAbstractDeclaratorBase { * }

    rule noPointerAbstractDeclarator {
        <noPointerAbstractDeclaratorBase>
        [   
            ||  <parametersAndQualifiers>
            ||  <noPointerAbstractDeclarator> <noPointerAbstractDeclaratorBracketedBase>
        ]*
    }

    rule noPointerAbstractDeclaratorBase:sym<basic> {
        <parametersAndQualifiers>
    }

    rule noPointerAbstractDeclaratorBase:sym<bracketed> {
        <noPointerAbstractDeclaratorBracketedBase>
    }

    rule noPointerAbstractDeclaratorBase:sym<parenthesized> {
        <LeftParen> <pointerAbstractDeclarator> <RightParen>
    }

    rule noPointerAbstractDeclaratorBracketedBase {
        <LeftBracket> <constantExpression>?  <RightBracket> <attributeSpecifierSeq>?
    }

    rule abstractPackDeclarator {
        <pointerOperator>* 
        <noPointerAbstractPackDeclarator>
    }

    #-------------------[x]
    rule noPointerAbstractPackDeclaratorBasic {
        <parametersAndQualifiers>
    }

    rule noPointerAbstractPackDeclaratorBrackets {
        <LeftBracket> 
        <constantExpression>?  
        <RightBracket> 
        <attributeSpecifierSeq>?
    }

    rule noPointerAbstractPackDeclarator {
        <Ellipsis>
        [
            | <noPointerAbstractPackDeclaratorBasic>
            | <noPointerAbstractPackDeclaratorBrackets>
        ]*
    }

    rule parameterDeclarationClause {
        ||  <parameterDeclarationList>
            [   ||  <Comma>?
                    <Ellipsis>
            ]?
    }

    rule parameterDeclarationList {
        ||  <parameterDeclaration>
            [   ||  <Comma>
                    <parameterDeclaration>
            ]*
    }

    rule parameterDeclaration {
        ||  <attributeSpecifierSeq>?
            <declSpecifierSeq>
            [   ||  [   ||  <declarator>
                        ||  <abstractDeclarator>?
                    ]
                    [   ||  <Assign>
                            <initializerClause>
                    ]?
            ]
    }

    rule functionDefinition {
        <attributeSpecifierSeq>?
        <declSpecifierSeq>?
        <declarator>
        <virtualSpecifierSeq>?
        <functionBody>
    }

    rule functionBody {
        ||  <constructorInitializer>?  <compoundStatement>
        ||  <functionTryBlock>
        ||  <Assign> [ <Default> || <Delete> ] <Semi>
    }

    rule initializer {
        ||  <braceOrEqualInitializer>
        ||  <LeftParen> <expressionList> <RightParen>
    }

    rule braceOrEqualInitializer {
        ||  <Assign> <initializerClause>
        ||  <bracedInitList>
    }

    rule initializerClause {
        ||  <assignmentExpression>
        ||  <bracedInitList>
    }

    rule initializerList {
        <initializerClause>
        <Ellipsis>?
        [ <Comma> <initializerClause> <Ellipsis>? ]*
    }

    rule bracedInitList {
        <LeftBrace> [ <initializerList> <Comma>? ]?  <RightBrace>
    }

    rule className {
        ||  <Identifier>
        ||  <simpleTemplateId>
    }

    rule classSpecifier {
        <classHead>
        <LeftBrace>
        <memberSpecification>?
        <RightBrace>
    }

    rule classHead {
        ||  <classKey>
            <attributeSpecifierSeq>?
            [   ||  <classHeadName>
                    <classVirtSpecifier>?
            ]?
            <baseClause>?
        ||  <Union>
            <attributeSpecifierSeq>?
            [   ||  <classHeadName>
                    <classVirtSpecifier>?
            ]?
    }

    rule classHeadName {
        <nestedNameSpecifier>?  <className>
    }

    rule classVirtSpecifier {
        <Final>
    }

    rule classKey {
        ||  <Class_>
        ||  <Struct>
    }

    rule memberSpecification {
        [   
           ||  <memberdeclaration>
           ||  <accessSpecifier> <Colon>
        ]+
    }

    rule memberdeclaration {
        ||  <attributeSpecifierSeq>?  <declSpecifierSeq>?  <memberDeclaratorList>?  <Semi>
        ||  <functionDefinition>
        ||  <usingDeclaration>
        ||  <staticAssertDeclaration>
        ||  <templateDeclaration>
        ||  <aliasDeclaration>
        ||  <emptyDeclaration>
    }

    rule memberDeclaratorList {
        <memberDeclarator> [ <Comma> <memberDeclarator> ]*
    }

    rule memberDeclarator {
        ||  <declarator>
            [   ||  <virtualSpecifierSeq>?
                    <pureSpecifier>?
                ||  <braceOrEqualInitializer>?
            ]
        ||  <Identifier>?
            <attributeSpecifierSeq>?
            <Colon>
            <constantExpression>
    }

    rule virtualSpecifierSeq {
        <virtualSpecifier>+
    }

    rule virtualSpecifier {
        ||  <Override>
        ||  <Final>
    }

    rule pureSpecifier {
        ||  <Assign>
            <val=OctalLiteral>
            #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); }
    }

    rule baseClause {
        <Colon> <baseSpecifierList>
    }

    rule baseSpecifierList {
        <baseSpecifier> <Ellipsis>?  [ <Comma> <baseSpecifier> <Ellipsis>?  ]*
    }

    rule baseSpecifier {
        <attributeSpecifierSeq>?
        [   
          ||  <baseTypeSpecifier>
          ||  <Virtual> <accessSpecifier>? <baseTypeSpecifier>
          ||  <accessSpecifier> <Virtual>? <baseTypeSpecifier>
        ]
    }

    rule classOrDeclType {
        ||  <nestedNameSpecifier>?  <className>
        ||  <decltypeSpecifier>
    }

    rule baseTypeSpecifier {
        <classOrDeclType>
    }

    proto rule accessSpecifier { * }
    rule accessSpecifier:sym<private>   { <Private> }
    rule accessSpecifier:sym<protected> { <Protected> }
    rule accessSpecifier:sym<public>    { <Public> }

    rule conversionFunctionId {
        <Operator> <conversionTypeId>
    }

    rule conversionTypeId {
        <typeSpecifierSeq> <conversionDeclarator>?
    }

    rule conversionDeclarator {
        <pointerOperator> <conversionDeclarator>?
    }

    rule constructorInitializer {
        <Colon> <memInitializerList>
    }

    rule memInitializerList {
        ||  <memInitializer>
            <Ellipsis>?
            [   ||  <Comma>
                    <memInitializer>
                    <Ellipsis>?
            ]*
    }

    rule memInitializer {
        ||  <meminitializerid>
            [   ||  <LeftParen>
                    <expressionList>?
                    <RightParen>
                ||  <bracedInitList>
            ]
    }

    rule meminitializerid {
        ||  <classOrDeclType>
        ||  <Identifier>
    }

    rule operatorFunctionId {
        <Operator> <theOperator>
    }

    rule literalOperatorId {
        ||  <Operator>
            [   ||  <StringLiteral>
                    <Identifier>
                ||  <UserDefinedStringLiteral>
            ]
    }

    rule templateDeclaration {
        ||  <Template>
            <Less>
            <templateparameterList>
            <Greater>
            <declaration>
    }

    rule templateparameterList {
        ||  <templateParameter>
            [   ||  <Comma>
                    <templateParameter>
            ]*
    }

    rule templateParameter {
        ||  <typeParameter>
        ||  <parameterDeclaration>
    }

    rule typeParameter {
        ||  [   ||  [   ||  <Template>
                            <Less>
                            <templateparameterList>
                            <Greater>
                    ]?
                    <Class_>
                ||  <Typename_>
            ]
            [   ||  [   ||  <Ellipsis>?
                            <Identifier>?
                    ]
                ||  [   ||  <Identifier>?
                            <Assign>
                            <theTypeId>
                    ]
            ]
    }

    rule simpleTemplateId {
        <templateName>
        <Less>
        <templateArgumentList>?
        <Greater>
    }

    rule templateId {
        ||  <simpleTemplateId>
        ||  [   ||  <operatorFunctionId>
                ||  <literalOperatorId>
            ]
            <Less>
            <templateArgumentList>?
            <Greater>
    }

    token templateName {
        <Identifier>
    }

    rule templateArgumentList {
        <templateArgument> <Ellipsis>? [ <Comma> <templateArgument> <Ellipsis>? ]*
    }

    token templateArgument {
        | <theTypeId>
        | <constantExpression>
        | <idExpression>
    }

    rule typeNameSpecifier {
        <Typename_>
        <nestedNameSpecifier>
        [
            ||  <Identifier>
            ||  <Template>?  <simpleTemplateId>
        ]
    }

    rule explicitInstantiation {
        <Extern>?
        <Template>
        <declaration>
    }

    rule explicitSpecialization {
        <Template>
        <Less>
        <Greater>
        <declaration>
    }

    rule tryBlock {
        <Try>
        <compoundStatement>
        <handlerSeq>
    }

    rule functionTryBlock {
        <Try>
        <constructorInitializer>?
        <compoundStatement>
        <handlerSeq>
    }

    rule handlerSeq {
        <handler>+
    }

    rule handler {
        <Catch>
        <LeftParen>
        <exceptionDeclaration>
        <RightParen>
        <compoundStatement>
    }

    rule exceptionDeclaration {
        ||  <attributeSpecifierSeq>?
            <typeSpecifierSeq>
            [   
                ||  <declarator>
                ||  <abstractDeclarator>
            ]?
        ||  <Ellipsis>
    }

    rule throwExpression {
        <Throw> <assignmentExpression>?
    }

    token exceptionSpecification {
        || <dynamicExceptionSpecification>
        || <noeExceptSpecification>
    }

    rule dynamicExceptionSpecification {
        <Throw> <LeftParen> <typeIdList>?  <RightParen>
    }

    rule typeIdList {
         <theTypeId> <Ellipsis>?  [ <Comma> <theTypeId> <Ellipsis>? ]*
    }

    token noeExceptSpecification {
        ||  <Noexcept> <LeftParen> <constantExpression> <RightParen>
        ||  <Noexcept>
    }

    proto token theOperator { * }
    token theOperator:sym<New>              { <New> [ <LeftBracket> <RightBracket>]?    } 
    token theOperator:sym<Delete>           { <Delete> [ <LeftBracket> <RightBracket>]? } 
    token theOperator:sym<Plus>             { <Plus>                                    } 
    token theOperator:sym<Minus>            { <Minus>                                   } 
    token theOperator:sym<Star>             { <Star>                                    } 
    token theOperator:sym<Div>              { <Div>                                     } 
    token theOperator:sym<Mod>              { <Mod>                                     } 
    token theOperator:sym<Caret>            { <Caret>                                   } 
    token theOperator:sym<And>              { <And>    <!before <And>>                  } 
    token theOperator:sym<Or>               { <Or>                                      } 
    token theOperator:sym<Tilde>            { <Tilde>                                   } 
    token theOperator:sym<Not>              { <Not>                                     } 
    token theOperator:sym<Assign>           { <Assign>                                  } 
    token theOperator:sym<Greater>          { <Greater>                                 } 
    token theOperator:sym<Less>             { <Less>                                    } 
    token theOperator:sym<GreaterEqual>     { <GreaterEqual>                            } 
    token theOperator:sym<PlusAssign>       { <PlusAssign>                              } 
    token theOperator:sym<MinusAssign>      { <MinusAssign>                             } 
    token theOperator:sym<StarAssign>       { <StarAssign>                              } 
    token theOperator:sym<ModAssign>        { <ModAssign>                               } 
    token theOperator:sym<XorAssign>        { <XorAssign>                               } 
    token theOperator:sym<AndAssign>        { <AndAssign>                               } 
    token theOperator:sym<OrAssign>         { <OrAssign>                                } 
    token theOperator:sym<LessLess>         { <Less> <Less>                             } 
    token theOperator:sym<GreaterGreater>   { <Greater> <Greater>                       } 
    token theOperator:sym<RightShiftAssign> { <RightShiftAssign>                        } 
    token theOperator:sym<LeftShiftAssign>  { <LeftShiftAssign>                         } 
    token theOperator:sym<Equal>            { <Equal>                                   } 
    token theOperator:sym<NotEqual>         { <NotEqual>                                } 
    token theOperator:sym<LessEqual>        { <LessEqual>                               } 
    token theOperator:sym<AndAnd>           { <AndAnd>                                  } 
    token theOperator:sym<OrOr>             { <OrOr>                                    } 
    token theOperator:sym<PlusPlus>         { <PlusPlus>                                } 
    token theOperator:sym<MinusMinus>       { <MinusMinus>                              } 
    token theOperator:sym<Comma>            { <Comma>                                   } 
    token theOperator:sym<ArrowStar>        { <ArrowStar>                               } 
    token theOperator:sym<Arrow>            { <Arrow>                                   } 
    token theOperator:sym<Parens>           { <LeftParen> <RightParen>                  } 
    token theOperator:sym<Brak>             { <LeftBracket> <RightBracket>              } 

    proto token literal { * }
    token literal:sym<int>          { <IntegerLiteral> }
    token literal:sym<char>         { <CharacterLiteral> }
    token literal:sym<float>        { <FloatingLiteral> }
    token literal:sym<str>          { <StringLiteral> }
    token literal:sym<bool>         { <BooleanLiteral> }
    token literal:sym<ptr>          { <PointerLiteral> }
    token literal:sym<user-defined> { <UserDefinedLiteral> }
}
