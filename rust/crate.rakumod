Crate :
   UTF8BOM?
   SHEBANG?
   InnerAttribute*
   Item*

UTF8BOM : \uFEFF
SHEBANG : #! ~\n+†

ConfigurationPredicate :
      ConfigurationOption
   | ConfigurationAll
   | ConfigurationAny
   | ConfigurationNot

ConfigurationOption :
   IDENTIFIER (= (STRING_LITERAL | RAW_STRING_LITERAL))?

ConfigurationAll
   all ( ConfigurationPredicateList? )

ConfigurationAny
   any ( ConfigurationPredicateList? )

ConfigurationNot
   not ( ConfigurationPredicate )

ConfigurationPredicateList
   ConfigurationPredicate (, ConfigurationPredicate)* ,?


CfgAttrAttribute :
   cfg ( ConfigurationPredicate )

CfgAttrAttribute :
   cfg_attr ( ConfigurationPredicate , CfgAttrs? )

CfgAttrs :
   Attr (, Attr)* ,?

Item:
   OuterAttribute*
      VisItem
   | MacroItem

VisItem:
   Visibility?
   (
         Module
      | ExternCrate
      | UseDeclaration
      | Function
      | TypeAlias
      | Struct
      | Enumeration
      | Union
      | ConstantItem
      | StaticItem
      | Trait
      | Implementation
      | ExternBlock
   )

MacroItem:
      MacroInvocationSemi
   | MacroRulesDefinition

Module :
      unsafe? mod IDENTIFIER ;
   | unsafe? mod IDENTIFIER {
        InnerAttribute*
        Item*
      }

ExternCrate :
   extern crate CrateRef AsClause? ;

CrateRef :
   IDENTIFIER | self

AsClause :
   as ( IDENTIFIER | _ )
