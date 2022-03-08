
MacroInvocation :
   SimplePath ! DelimTokenTree

DelimTokenTree :
      ( TokenTree* )
   | [ TokenTree* ]
   | { TokenTree* }

TokenTree :
   Tokenexcept delimiters | DelimTokenTree

MacroInvocationSemi :
      SimplePath ! ( TokenTree* ) ;
   | SimplePath ! [ TokenTree* ] ;
   | SimplePath ! { TokenTree* }

MacroRulesDefinition :
   macro_rules ! IDENTIFIER MacroRulesDef

MacroRulesDef :
      ( MacroRules ) ;
   | [ MacroRules ] ;
   | { MacroRules }

MacroRules :
   MacroRule ( ; MacroRule )* ;?

MacroRule :
   MacroMatcher => MacroTranscriber

MacroMatcher :
      ( MacroMatch* )
   | [ MacroMatch* ]
   | { MacroMatch* }

MacroMatch :
      Tokenexcept $ and delimiters
   | MacroMatcher
   | $ IDENTIFIER : MacroFragSpec
   | $ ( MacroMatch+ ) MacroRepSep? MacroRepOp

MacroFragSpec :
      block | expr | ident | item | lifetime | literal
   | meta | pat | pat_param | path | stmt | tt | ty | vis

MacroRepSep :
   Tokenexcept delimiters and repetition operators

MacroRepOp :
   * | + | ?

MacroTranscriber :
   DelimTokenTree
