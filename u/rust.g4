//   Copyright [2013] [John B. Clements <clements@racket-lang.org>]
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

// splitting issues: &&, <<, >>, >>=, ||
// be more consistent in use of *_list, *_seq, and *s.
// NB: associativity may be wrong all over the place.
// re-check trailing comma legal locations

// UNICODE: okay, I just got lost in Unicode Standard Annex #31,
// "Unicode Identifier and Pattern Syntax".
// I get the sense that Rust intends to abide by Unicode standards
// for identifiers; what I've done in this file approximates this,
// I believe.

// handling of macros is not yet a match for the parser, in part
// because the parser does strange things; when there's a macro
// in statement position, it parses it as a statement even if
// it's an expression.
grammar Rust;


@lexer::members {
      static int dotChar = 46;

      // is this character followed by an identifier or
      // a dot? this is used in parsing numbers, to distinguish
      // floating-point numbers from ranges and method calls.
      public boolean followed_by_ident_or_dot() {
        CharStream cs = getInputStream();
        int nextChar = cs.LA(1);
        // KNOWN POTENTIAL ISSUE : this fn needs to be
        // aligned with the list appearing in xidstart....
        return (java.lang.Character.isUnicodeIdentifierStart(nextChar)
                || nextChar == dotChar);
      }

      // are we at the beginning of the file? This is needed in
      // order to parse shebangs.
      public boolean at_beginning_of_file() {
        return (getInputStream().index() == 0);
      }

    }

/// <grammar>

// you can either treat a program as a sequence of token-trees--this is
// the "s-expression" approach to parsing--or as a prog.

// a sequence of token trees
tts : tt* ;

// module contents
prog : module_contents ;
module_contents : inner_attr* extern_mod_view_item* view_item* mod_item*;

// MODULE ITEMS :
extern_mod_view_item : attrs_and_vis EXTERN MOD ident (lib_selectors)? SEMI ;
view_item : attrs_and_vis USE view_paths SEMI ;
mod_item
  : attrs_and_vis mod_decl
  | attrs_and_vis foreign_mod
  | attrs_and_vis type_decl
  | attrs_and_vis struct_decl
  | attrs_and_vis enum_decl
  | attrs_and_vis trait_decl
  | attrs_and_vis const_item
  | attrs_and_vis impl
  | outer_attrs impl_trait_for_type
  | attrs_and_vis (UNSAFE)? item_fn_decl
  | attrs_and_vis EXTERN (LIT_STR)? item_fn_decl
  | macro_item
  ;

mod_decl
  : MOD ident SEMI
  | MOD ident LBRACE module_contents RBRACE
  ;

foreign_mod
  : EXTERN (LIT_STR)? MOD ident LBRACE inner_attr* foreign_item* RBRACE
  | EXTERN (LIT_STR)? LBRACE inner_attr* foreign_item* RBRACE ;
foreign_item
  : outer_attrs STATIC ident COLON ty SEMI
  | outer_attrs visibility (UNSAFE)? FN ident (LT (generic_decls)? GT)? LPAREN (args)? RPAREN ret_ty SEMI
  ;

type_decl : TYPE ident (LT (generic_decls)? GT)? EQ ty SEMI ;

struct_decl
  : STRUCT ident (LT (generic_decls)? GT)? LBRACE (struct_fields (COMMA)?)? RBRACE
  | STRUCT ident (LT (generic_decls)? GT)? LPAREN (tys)? RPAREN SEMI
  | STRUCT ident (LT (generic_decls)? GT)? SEMI
  ;
struct_fields : struct_field COMMA struct_fields | struct_field ;
struct_field
  : attrs_and_vis mutability ident COLON ty
  | outer_attrs DROP block
  ;

enum_decl
  : ENUM ident (LT (generic_decls)? GT)? LBRACE (enum_variant_decls (COMMA)?)? RBRACE
  ;
enum_variant_decls : enum_variant_decl COMMA enum_variant_decls | enum_variant_decl ;
enum_variant_decl
  : attrs_and_vis ident LBRACE (struct_fields (COMMA)?)? RBRACE
  | attrs_and_vis ident LPAREN (tys)? RPAREN
  | attrs_and_vis ident EQ expr
  | attrs_and_vis ident
  ;

trait_decl: TRAIT ident (LT (generic_decls)? GT)? (COLON traits)? LBRACE trait_method* RBRACE ;
trait_method
  : attrs_and_vis (UNSAFE)? FN ident (LT (generic_decls)? GT)? LPAREN (self_ty_and_maybenamed_args)? RPAREN ret_ty SEMI
  | attrs_and_vis (UNSAFE)? FN ident (LT (generic_decls)? GT)? LPAREN (self_ty_and_maybenamed_args)? RPAREN ret_ty fun_body
  ;

impl : IMPL (LT (generic_decls)? GT)? ty impl_body ;
impl_trait_for_type : IMPL (LT (generic_decls)? GT)? trait FOR ty impl_body ;
impl_body : SEMI
  | LBRACE impl_method* RBRACE ;
impl_method : attrs_and_vis (UNSAFE)? FN ident (LT (generic_decls)? GT)? LPAREN (self_ty_and_args)? RPAREN ret_ty fun_body  ;

item_fn_decl : FN ident (LT (generic_decls)? GT)? LPAREN (args)? RPAREN ret_ty fun_body ;
fun_body : LBRACE inner_attr* view_item* block_element* (block_last_element)? RBRACE ;
block : LBRACE view_item* block_element* (block_last_element)? RBRACE ;
block_element : expr_RL (SEMI)+
  | stmt_not_just_expr (SEMI)*
  ;
block_last_element : expr_RL | macro_parens | expr_stmt ;
ret_ty : RARROW NOT
  | RARROW ty
  | /* nothing */
  ;

macro_item
  : ident NOT (ident)? parendelim
  | ident NOT (ident)? bracedelim
  ;

attrs_and_vis : outer_attrs visibility ;
visibility : PUB | PRIV | /*nothing*/ ;
// overly loose on "const", but soon it will disappear completely?
mutability : MUT | CONST | /*nothing*/ ;
lib_selectors : LPAREN (meta_items)? RPAREN ;
outer_attrs : /* nothing */ | outer_attr outer_attrs ;
outer_attr : POUND LBRACKET meta_item RBRACKET
  | OUTER_DOC_COMMENT ;
inner_attr : POUND LBRACKET meta_item RBRACKET SEMI
  | INNER_DOC_COMMENT ;
meta_item : ident
  | ident EQ lit
  | ident LPAREN (meta_items)? RPAREN ;
meta_items : meta_item
  | meta_item COMMA meta_items ;



args : arg | arg COMMA args ;
arg : (arg_mode)? mutability pat COLON ty ;
arg_mode : AND AND | PLUS | obsoletemode ;
// obsolete ++ mode used in librustc/middle/region.rs
obsoletemode : PLUS PLUS ;

self_ty_and_args
  : self_ty (COMMA args)?
  | args
  ;
self_ty_and_maybenamed_args
  : self_ty (COMMA maybenamed_args)?
  | maybenamed_args
  ;
self_ty
  : AND (lifetime)? mutability SELF
  | AT mutability SELF
  | TILDE mutability SELF
  | SELF
  ;

maybetyped_args : maybetyped_arg | maybetyped_arg COMMA maybetyped_args ;
maybetyped_arg : (arg_mode)? mutability pat (COLON ty)? ;
maybenamed_args : maybenamed_arg | maybenamed_arg COMMA maybenamed_args ;
maybenamed_arg : arg | ty ;


// not treating '_' specially... I don't think I have to.
pat : AT pat
  | TILDE pat
  | AND pat
  | LPAREN RPAREN
  | LPAREN pats RPAREN
  | LBRACKET (vec_pats)? RBRACKET
    // definitely ambiguity here with ident patterns
  | expr_RB (DOTDOT expr_RB)?
  | REF mutability ident (AT pat)?
  | COPYTOK ident (AT pat)?
  | path AT pat
  | path_with_colon_tps
  | path_with_colon_tps LBRACE pat_fields RBRACE
  | path_with_colon_tps LPAREN STAR RPAREN
  | path_with_colon_tps LPAREN (pats)? RPAREN
  ;
pats : pat (COMMA)? | pat COMMA pats ;
pats_or : pat | pat OR pats_or ;
vec_pats : pat
  | DOTDOT ident
  | pat COMMA vec_pats
  | DOTDOT ident COMMA vec_pats_no_slice ;
vec_pats_no_slice : pat | pat COMMA vec_pats_no_slice ;
const_item : STATIC ident COLON ty EQ expr SEMI ;

view_paths : view_path | view_path COMMA view_paths ;
view_path : (MOD)? ident EQ non_global_path
  | (MOD)? non_global_path MOD_SEP LBRACE RBRACE
  | (MOD)? non_global_path MOD_SEP LBRACE idents (COMMA)? RBRACE
  | (MOD)? non_global_path MOD_SEP STAR
  | (MOD)? non_global_path
  ;

pat_fields
  : IDENT (COLON pat)?
  | IDENT (COLON pat)? COMMA pat_fields
  | UNDERSCORE
  ;


traits : trait | trait PLUS traits ;
trait : path (LT (generics)? GT)? ;
tys : ty | ty COMMA tys ;
ty : LPAREN RPAREN
  | LPAREN ty RPAREN
  | LPAREN ty COMMA RPAREN
  | LPAREN tys RPAREN
  | AT box_or_uniq_pointee
  | TILDE box_or_uniq_pointee
  | STAR mutability ty
  | path (LT (generics)? GT)?
  | LBRACKET (obsoleteconst)? ty COMMA DOTDOT expr RBRACKET
  | LBRACKET (obsoleteconst)? ty RBRACKET
  | AND borrowed_pointee
  | EXTERN (LIT_STR)? (UNSAFE)? ty_fn
  | ty_closure
  | path (LT (generics)? GT)?
  ;
box_or_uniq_pointee
  : (lifetime)? ty_closure
  | mutability ty ;
borrowed_pointee
  : (lifetime)? ty_closure
  | (lifetime)? mutability ty ;
ty_closure
  : (UNSAFE)? (ONCE)? ty_fn
  ;
ty_fn : FN (LT (lifetimes)? GT)? LPAREN (maybenamed_args)? RPAREN ret_ty ;

// obsolete:
obsoleteconst : CONST ;



// because of the bifurcated treatment of statements and semicolon requirements,
// there's no "stmt" production; instead, upstream uses are treated independently.

// a statement that is not parsed by the expr_RL rule
stmt_not_just_expr
  : let_stmt
    // this one requires parens. I think this may be accidental,
    // because mod_item includes both kinds of macro invocation... and
    // this one can fall through to that one.
  | macro_parens
  | mod_item
  | expr_stmt
  ;
let_stmt : LET mutability local_var_decl (COMMA local_var_decl)* SEMI ;
local_var_decl : pat (COLON ty)? (EQ expr)? ;



// from a parser standpoint, it would be simpler just
// to allow lifetimes and type params to be intermixed.
generic_decls
  : lifetime
  | lifetime COMMA generic_decls
  | ty_params ;
ty_params : ty_param | ty_param COMMA ty_params ;
ty_param : ident | ident COLON | ident COLON boundseq ;
boundseq : bound | bound PLUS boundseq ;
bound : STATIC_LIFETIME | ty | obsoletekind ;
// take these out?
obsoletekind : COPYTOK | CONST ;


generics : lifetime
  | lifetime COMMA generics
  | tys ;

lifetimes_in_braces : LT (lifetimes)? GT ;
lifetimes : lifetime | lifetime COMMA lifetimes ;

idents : ident | ident COMMA idents ;

path : MOD_SEP? non_global_path ;
non_global_path : ident (MOD_SEP ident)* ;

// EXPRS

exprs : expr | expr COMMA exprs ;
expr : expr_1 EQ expr
  | expr_1 BINOPEQ expr
  | expr_1 DARROW expr
  | expr_1
  ;
expr_1 : expr_1 OR expr_2
  | expr_2 ;
expr_2 : expr_2 AND expr_3
  | expr_3 ;
expr_3 : expr_3 EQEQ expr_4
  | expr_3 NE expr_4
  | expr_4 ;
expr_4 : expr_4 LT expr_5
  | expr_4 LE expr_5
  | expr_4 GE expr_5
  | expr_4 GT expr_5
  | expr_5
  ;
// there is no precedence 5 ...
expr_5 : expr_6;
expr_6 : expr_6 OR OR expr_7
  | expr_7 ;
expr_7 : expr_7 CARET expr_8
  | expr_8 ;
expr_8 : expr_8 AND expr_9
  | expr_9 ;
expr_9 : expr_9 LT LT expr_10
  | expr_9 GT GT expr_10
  | expr_10 ;
expr_10 : expr_10 PLUS expr_11
  | expr_10 MINUS expr_11
  | expr_11 ;
expr_11 : expr_11 AS ty
  | expr_12 ;
expr_12 : expr_12 STAR expr_prefix
  | expr_12 DIV expr_prefix
  | expr_12 REM expr_prefix
  | expr_prefix ;
expr_prefix : NOT expr_prefix
  | MINUS expr_prefix
  | STAR expr_prefix
  | AND (lifetime)? mutability expr_prefix
  | AT mutability expr_prefix
  | TILDE expr_prefix
  | expr_dot_or_call
  ;
// refactoring to eliminate left-recursion would make this less readable...
expr_dot_or_call
  : expr_dot_or_call DOT ident (MOD_SEP LT (generics)? GT)? (LPAREN (exprs)? RPAREN)?
  | expr_dot_or_call LPAREN (exprs)? RPAREN
  | expr_dot_or_call LBRACKET expr RBRACKET
  | expr_bottom
  ;
expr_bottom
// this covers (), (e), and tuples, including our goofy one-tuple:
  : LPAREN (exprs (COMMA)?)? RPAREN
  | expr_lambda
  | expr_stmt
  | expr_vector
  | LOG LPAREN expr COMMA expr RPAREN
  | LOOP (ident)?
  | RETURN expr
  | RETURN
  | BREAK (ident)?
  | COPYTOK expr
    // this will overlap with the whole-stmt macro-invocation rule...
    // I don't think I can bear to
  | macro
  | path_with_colon_tps LBRACE field_inits default_field_inits RBRACE
  | path_with_colon_tps
  | lit
  ;

// once again, with stmt_on_lhs restriction . the token
// fooRL is just like foo but doesn't allow an expr_statement
// as its beginning.

// in this mode, we're concerned about
// statements like if true {3} else {4} |a|a, which we
// want to parse as a statement followed by a closure expression,
// rather than as (if... | a) | a.

expr_RL : expr_1RL EQ expr
  | expr_1RL BINOPEQ expr
  | expr_1RL DARROW expr
  | expr_1RL
  ;
expr_1RL : expr_1RL OR expr_2
  | expr_2RL ;
expr_2RL : expr_2RL AND expr_3
  | expr_3RL ;
expr_3RL : expr_3RL EQEQ expr_4
  | expr_3RL NE expr_4
  | expr_4RL ;
expr_4RL : expr_4RL LT expr_5
  | expr_4RL LE expr_5
  | expr_4RL GE expr_5
  | expr_4RL GT expr_5
  | expr_5RL
  ;
// there is no precedence 5 ...
expr_5RL : expr_6RL;
expr_6RL : expr_6RL OR OR expr_7
  | expr_7RL ;
expr_7RL : expr_7RL CARET expr_8
  | expr_8RL ;
expr_8RL : expr_8RL AND expr_9
  | expr_9RL ;
expr_9RL : expr_9RL LT LT expr_10
  | expr_9RL GT GT expr_10
  | expr_10RL ;
expr_10RL : expr_10RL PLUS expr_11
  | expr_10RL MINUS expr_11
  | expr_11RL ;
expr_11RL : expr_11RL AS ty
  | expr_12RL ;
expr_12RL : expr_12RL STAR expr_prefix
  | expr_12RL DIV expr_prefix
  | expr_12RL REM expr_prefix
  | expr_prefixRL ;
expr_prefixRL : NOT expr_prefix
  | MINUS expr_prefix
  | STAR expr_prefix
  | AND (lifetime)? mutability expr_prefix
  | AT mutability expr_prefix
  | TILDE expr_prefix
  | expr_dot_or_callRL
  ;
expr_dot_or_callRL
    // strange exception here: we allow .f() after stmt_exprs
  : expr_dot_or_call DOT ident (MOD_SEP LT (generics)? GT)? (LPAREN (exprs)? RPAREN)?
  | expr_dot_or_callRL LPAREN (exprs)? RPAREN
  | expr_dot_or_callRL LBRACKET expr RBRACKET
  | expr_bottomRL
  ;
expr_bottomRL
  : LPAREN (exprs (COMMA)?)? RPAREN
  | expr_lambda
  // no expr_stmt here
  | expr_vector
  | LOG LPAREN expr COMMA expr RPAREN
  | LOOP (ident)?
  | RETURN expr
  | RETURN
  | BREAK (ident)?
  | COPYTOK expr
    // this is an ambiguity, right?
  | macro
  | path_with_colon_tps LBRACE field_inits default_field_inits RBRACE
  | path_with_colon_tps
  | lit
  ;

// expr_RB
// these exprs are restricted; they may not contain the "or" operator.
// this is used to artificially lower the precedence of | in patterns.

expr_RB : expr_2 EQ expr_RB
  | expr_2 BINOPEQ expr_RB
  | expr_2 DARROW expr_RB
    // skipping over OR :
  | expr_2 
  ;

// expr_RBB
// these exprs are restricted; they may not contain "or" or the
// double "oror" operator. This is used to prevent parsing of
// lambda terms following uses of "do" or "for" from being treated
// as "or" operators instead.

expr_RBB
    // skipping over OR:
  : expr_2RBB EQ expr_RBB
  | expr_2RBB BINOPEQ expr_RBB
  | expr_2RBB DARROW expr_RBB
  | expr_2RBB
  ;
expr_2RBB : expr_2RBB AND expr_3RBB
  | expr_3RBB ;
expr_3RBB : expr_3RBB EQEQ expr_4RBB
  | expr_3RBB NE expr_4RBB
  | expr_4RBB ;
expr_4RBB : expr_4RBB LT expr_5RBB
  | expr_4RBB LE expr_5RBB
  | expr_4RBB GE expr_5RBB
  | expr_4RBB GT expr_5RBB
  | expr_5RBB
  ;
// there is no precedence 5 ...
// skipping over OR OR :
expr_5RBB : expr_7;


// things that can be either statements (without semicolons) or expressions
// these can't appear in certain positions, e.g. 'if true {3} else {4} + 19'
// blocks need special treatment because they don't require commas when used
// as the RHS of match clauses.
expr_stmt
  : expr_stmt_block
  | expr_stmt_not_block
  ;
expr_stmt_block : (UNSAFE)? block;
expr_stmt_not_block
  : expr_if
  | expr_match
  | expr_while
  | expr_loop
  | expr_for
  | expr_do
  ;

field_inits : field_init | field_init COMMA field_inits ;
default_field_inits : COMMA DOTDOT expr | (COMMA)? ;
field_init : mutability ident COLON expr ;
expr_vector : LBRACKET RBRACKET
  | LBRACKET expr (COMMA DOTDOT expr)? RBRACKET
  | LBRACKET expr COMMA exprs (COMMA)? RBRACKET ;
expr_if : IF expr block (ELSE block_or_if)? ;
block_or_if : block | expr_if ;
expr_for : FOR expr_RBB (OR (maybetyped_args)? OR)? block;
expr_do : DO expr_RBB (OR (maybetyped_args)? OR)? block;
expr_while : WHILE expr block ;
expr_loop
  : LOOP (UNSAFE)? block
  | LOOP ident COLON block
  ;
expr_match : MATCH expr LBRACE (match_clauses)? RBRACE ;
match_clauses : match_final_clause | match_clause match_clauses ;
match_final_clause
  : pats_or (IF expr)? FAT_ARROW (expr_RL | expr_stmt_not_block | expr_stmt_block ) (COMMA)? ;
match_clause
  : pats_or (IF expr)? FAT_ARROW (expr_RL COMMA | expr_stmt_not_block COMMA | expr_stmt_block (COMMA)? ) ;

expr_lambda : OR (maybetyped_args)? OR ret_ty expr ;

// SELF and STATIC may be used as identifiers
// not sure about underscore. should it even be a token?
ident : IDENT | SELF | STATIC | UNDERSCORE ;
lifetime : STATIC_LIFETIME | LIFETIME ;

macro
  : macro_parens
  | macro_braces
  ;
macro_parens : ident NOT parendelim ;
macro_braces : ident NOT bracedelim ;

path_with_tps : path (LT (generics)? GT)? ;
path_with_colon_tps : path (MOD_SEP LT (generics)? GT )? ;

lit
  : TRUE
  | FALSE
  | LIT_INT
  | LIT_FLOAT
  | LIT_STR
  | LPAREN RPAREN
  ;

// TOKEN TREES:
tt : non_delimiter | delimited ;
delimited
  : parendelim
  | bracketdelim
  | bracedelim;
parendelim : LPAREN tt* RPAREN ;
bracketdelim : LBRACKET tt* RBRACKET ;
bracedelim : LBRACE tt* RBRACE ;
// these two productions are provided for documentation:
//token : delimiter | non_delimiter ;
//delimiter : LPAREN | RPAREN | LBRACKET | RBRACKET | LBRACE | RBRACE ;
// GGRRRAAA! I can't break this definition up into multiple ones, or
// ANTLR starts hanging. I've kind of had it with ANTLR.
non_delimiter
  : AS
  | BREAK
  | CONST
  | COPYTOK
  | DO
  | DROP
  | ELSE
  | ENUM
  | EXTERN
  | FALSE
  | FN
  | FOR
  | IF
  | IMPL
  | LET
  | LOG
  | LOOP
  | MATCH
  | MOD
  | MUT
  | ONCE
  | PRIV
  | PUB
  | PURE
  | REF
  | RETURN
  | STATIC
  | STRUCT
  | SELF
    // I don't think super needs to be a keyword.
    //  | SUPER
  | TRUE
  | TRAIT
  | TYPE
  | UNSAFE
  | USE
  | WHILE
  // Expression-operator symbols.
  // adding AND and PLUS and MINUS (etc) to make the grammar tractable:
  |  AND
  |  PLUS
  |  MINUS
  |  DIV
  |  REM
  |  CARET
  |  OR
  |  EQ
  |  LT
  |  LE
  |  EQEQ
  |  NE
  |  GE
  |  GT
  |  NOT
  |  TILDE
  |  STAR
  |  BINOPEQ
  // Structural symbols 
  |  AT
  |  DOT
  |  DOTDOT
  |  COMMA 
  |  SEMI
  |  COLON
  |  MOD_SEP
  |  RARROW
  |  LARROW
  |  DARROW
  |  FAT_ARROW
  |  POUND
  |  DOLLAR
//  ;
//
//
//booty :
  // Literals
  |  LIT_INT
  // It's not necessary to distinguish these for parsing:
  //|  LIT_UINT
  //|  LIT_INT_UNSUFFIXED
  |  LIT_FLOAT
  //|  LIT_FLOAT_UNSUFFIXED
  |  LIT_STR
//  ;
//
//ident_or_lifetime :
  // Name components
  |  IDENT
  |  UNDERSCORE
  |  STATIC_LIFETIME
  |  LIFETIME
//  ;
//
//doc_comment :
  // |  INTERPOLATED
  |  OUTER_DOC_COMMENT
  |  INNER_DOC_COMMENT
  ;


/// </grammar>

// putting keywords in to simplify things:
AS : 'as' ;
BREAK : 'break' ;
CONST : 'const' ;
COPYTOK : 'copy' ;
DO : 'do' ;
DROP : 'drop' ;
ELSE : 'else' ;
ENUM : 'enum' ;
EXTERN : 'extern' ;
FALSE : 'false' ;
FN : 'fn' ;
FOR : 'for' ;
IF : 'if' ;
IMPL : 'impl'   ;
LET : 'let' ;
LOG : '__log' ;
LOOP : 'loop' ;
MATCH : 'match' ;
MOD : 'mod' ;
MUT : 'mut' ;
ONCE : 'once' ;
PRIV : 'priv' ;
PUB : 'pub' ;
PURE : 'pure' ;
REF : 'ref' ;
RETURN : 'return' ;
SELF : 'self' ;
STATIC : 'static' ;
STRUCT : 'struct' ;
// I don't think super should be a keyword...
// SUPER : 'super' ;
TRUE : 'true' ;
TRAIT : 'trait' ;
TYPE : 'type' ;
UNSAFE : 'unsafe' ;
USE : 'use' ;
WHILE : 'while' ;

PLUS   : '+' ;
AND    : '&' ;
MINUS  : '-' ;
DIV    : '/' ;
REM    : '%' ;
CARET  : '^' ;
OR     : '|' ;
EQ     : '=' ;
LE     : '<=' ;
LT     : '<';
EQEQ : '==' ;
NE   : '!=' ;
GE   : '>=' ;
GT   : '>' ;
NOT   : '!' ;
TILDE : '~' ;
STAR : '*' ;
BINOPEQ : '/=' | '%=' | '^=' | '|=' | '-=' |'*=' | '&=' | '+=' | '<<=' | '>>=' ;
/* Structural symbols */
AT        : '@' ;
DOT       : '.' ;
DOTDOT    : '..' ;
COMMA     : ',' ;
SEMI      : ';' ; 
COLON     : ':' ;
MOD_SEP   : '::' ;
RARROW    : '->' ;
LARROW    : '<-' ;
DARROW    : '<->' ;
FAT_ARROW : '=>' ;
LPAREN    : '(' ;
RPAREN    : ')' ;
LBRACKET  : '[' ;
RBRACKET  : ']' ;
LBRACE    : '{' ;
RBRACE    : '}' ;
POUND     : '#' ;
DOLLAR    : '$' ;

LIT_INT
  : LIT_CHAR
  | '0x' HEXDIGIT+ INTLIT_TY?
  | '0b' BINDIGIT+ INTLIT_TY?
  | DECDIGIT DECDIGIT_CONT* INTLIT_TY?
  ;

LIT_FLOAT
  : DECDIGIT DECDIGIT_CONT* '.' {!followed_by_ident_or_dot()}?
    // nb: digit following '.' can't be underscore.
  | DECDIGIT DECDIGIT_CONT* '.' DECDIGIT DECDIGIT_CONT* LITFLOAT_EXP? LITFLOAT_TY?
  | DECDIGIT DECDIGIT_CONT* LITFLOAT_EXP LITFLOAT_TY?
  | DECDIGIT DECDIGIT_CONT* LITFLOAT_TY
  ;

LIT_STR : '\"' STRCHAR* '\"' ;
IDENT : IDSTART IDCONT* ;
UNDERSCORE : '_' ;


STATIC_LIFETIME : '\'static' ;
LIFETIME
  : '\'' IDENT
  | '\'' SELF
  ;
// the not-only-slashes restrictions is a real PITA:
// must have at least one non-slash char
OUTER_DOC_COMMENT : '///' '/' * NON_SLASH_OR_WS ~[\n]*
  | '///' '/' * [ \r\t] ~[ \r\t] ~[\n]*
  | '///' [ \t]*
    // again, we have to do a funny dance to fence out
    // only-stars.
    // CAN'T ABSTRACT OVER BLOCK_CHARS; learned this
    // the hard way ... :(
  | '/**' (~[*] | ('*'+ ~[*/]))* ~[*] (~[*] | ('*'+ ~[*/]))* '*'+ '/' ;
INNER_DOC_COMMENT : '//!' ~[\n]*
  | '/*!' (~[*] | ('*'+ ~[*/]))* '*'+ '/' ;

// HELPER DEFINITIONS:

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
OTHER_LINE_COMMENT : '//' ~[\n] * -> skip ;
OTHER_BLOCK_COMMENT : '/*' (~[*] | ('*'+ ~[*/]))* '*'+ '/' -> skip ;
SHEBANG_LINE : {at_beginning_of_file()}? '#!' ~[\n]* '\n' -> skip ;

BINDIGIT : [0-1_] ;
DECDIGIT : [0-9] ;
DECDIGIT_CONT : [0-9_] ;
HEXDIGIT : [0-9a-fA-F_] ;
INTLIT_TY : ('u'|'i') ('8'|'16'|'32'|'64')? ;
LITFLOAT_EXP : [eE] [+-]? DECDIGIT_CONT+ ;
LITFLOAT_TY : 'f' ('32'|'64')? ;

ESCAPEDCHAR : 'n' | 'r' | 't' | '\\' | '\'' | '\"'
  | 'x' HEXDIGIT HEXDIGIT | 'u' HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT
  | 'U' HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT
            ;

LIT_CHAR :  '\'\\' ESCAPEDCHAR '\'' | '\'' . '\'' ;

STRCHAR : ~[\\"] | '\\' STRESCAPE ;
STRESCAPE : '\n' | ESCAPEDCHAR ;

IDSTART : [_a-zA-Z]  | XIDSTART ;
IDCONT : [_a-zA-Z0-9] | XIDCONT ;

NON_SLASH_OR_WS : ~[ \t\r\n/] ;

XIDCONT :
              '\u0030' .. '\u0039'
            | '\u0041' .. '\u005a'
            | '\u005f'
            | '\u0061' .. '\u007a'
            | '\u00aa'
            | '\u00b5'
            | '\u00b7'
            | '\u00ba'
            | '\u00c0' .. '\u00d6'
            | '\u00d8' .. '\u00f6'
            | '\u00f8' .. '\u01ba'
            | '\u01bb'
            | '\u01bc' .. '\u01bf'
            | '\u01c0' .. '\u01c3'
            | '\u01c4' .. '\u0293'
            | '\u0294'
            | '\u0295' .. '\u02af'
            | '\u02b0' .. '\u02c1'
            | '\u02c6' .. '\u02d1'
            | '\u02e0' .. '\u02e4'
            | '\u02ec'
            | '\u02ee'
            | '\u0300' .. '\u036f'
            | '\u0370' .. '\u0373'
            | '\u0374'
            | '\u0376' .. '\u0377'
            | '\u037b' .. '\u037d'
            | '\u0386'
            | '\u0387'
            | '\u0388' .. '\u038a'
            | '\u038c'
            | '\u038e' .. '\u03a1'
            | '\u03a3' .. '\u03f5'
            | '\u03f7' .. '\u0481'
            | '\u0483' .. '\u0487'
            | '\u048a' .. '\u0527'
            | '\u0531' .. '\u0556'
            | '\u0559'
            | '\u0561' .. '\u0587'
            | '\u0591' .. '\u05bd'
            | '\u05bf'
            | '\u05c1' .. '\u05c2'
            | '\u05c4' .. '\u05c5'
            | '\u05c7'
            | '\u05d0' .. '\u05ea'
            | '\u05f0' .. '\u05f2'
            | '\u0610' .. '\u061a'
            | '\u0620' .. '\u063f'
            | '\u0640'
            | '\u0641' .. '\u064a'
            | '\u064b' .. '\u065f'
            | '\u0660' .. '\u0669'
            | '\u066e' .. '\u066f'
            | '\u0670'
            | '\u0671' .. '\u06d3'
            | '\u06d5'
            | '\u06d6' .. '\u06dc'
            | '\u06df' .. '\u06e4'
            | '\u06e5' .. '\u06e6'
            | '\u06e7' .. '\u06e8'
            | '\u06ea' .. '\u06ed'
            | '\u06ee' .. '\u06ef'
            | '\u06f0' .. '\u06f9'
            | '\u06fa' .. '\u06fc'
            | '\u06ff'
            | '\u0710'
            | '\u0711'
            | '\u0712' .. '\u072f'
            | '\u0730' .. '\u074a'
            | '\u074d' .. '\u07a5'
            | '\u07a6' .. '\u07b0'
            | '\u07b1'
            | '\u07c0' .. '\u07c9'
            | '\u07ca' .. '\u07ea'
            | '\u07eb' .. '\u07f3'
            | '\u07f4' .. '\u07f5'
            | '\u07fa'
            | '\u0800' .. '\u0815'
            | '\u0816' .. '\u0819'
            | '\u081a'
            | '\u081b' .. '\u0823'
            | '\u0824'
            | '\u0825' .. '\u0827'
            | '\u0828'
            | '\u0829' .. '\u082d'
            | '\u0840' .. '\u0858'
            | '\u0859' .. '\u085b'
            | '\u0900' .. '\u0902'
            | '\u0903'
            | '\u0904' .. '\u0939'
            | '\u093a'
            | '\u093b'
            | '\u093c'
            | '\u093d'
            | '\u093e' .. '\u0940'
            | '\u0941' .. '\u0948'
            | '\u0949' .. '\u094c'
            | '\u094d'
            | '\u094e' .. '\u094f'
            | '\u0950'
            | '\u0951' .. '\u0957'
            | '\u0958' .. '\u0961'
            | '\u0962' .. '\u0963'
            | '\u0966' .. '\u096f'
            | '\u0971'
            | '\u0972' .. '\u0977'
            | '\u0979' .. '\u097f'
            | '\u0981'
            | '\u0982' .. '\u0983'
            | '\u0985' .. '\u098c'
            | '\u098f' .. '\u0990'
            | '\u0993' .. '\u09a8'
            | '\u09aa' .. '\u09b0'
            | '\u09b2'
            | '\u09b6' .. '\u09b9'
            | '\u09bc'
            | '\u09bd'
            | '\u09be' .. '\u09c0'
            | '\u09c1' .. '\u09c4'
            | '\u09c7' .. '\u09c8'
            | '\u09cb' .. '\u09cc'
            | '\u09cd'
            | '\u09ce'
            | '\u09d7'
            | '\u09dc' .. '\u09dd'
            | '\u09df' .. '\u09e1'
            | '\u09e2' .. '\u09e3'
            | '\u09e6' .. '\u09ef'
            | '\u09f0' .. '\u09f1'
            | '\u0a01' .. '\u0a02'
            | '\u0a03'
            | '\u0a05' .. '\u0a0a'
            | '\u0a0f' .. '\u0a10'
            | '\u0a13' .. '\u0a28'
            | '\u0a2a' .. '\u0a30'
            | '\u0a32' .. '\u0a33'
            | '\u0a35' .. '\u0a36'
            | '\u0a38' .. '\u0a39'
            | '\u0a3c'
            | '\u0a3e' .. '\u0a40'
            | '\u0a41' .. '\u0a42'
            | '\u0a47' .. '\u0a48'
            | '\u0a4b' .. '\u0a4d'
            | '\u0a51'
            | '\u0a59' .. '\u0a5c'
            | '\u0a5e'
            | '\u0a66' .. '\u0a6f'
            | '\u0a70' .. '\u0a71'
            | '\u0a72' .. '\u0a74'
            | '\u0a75'
            | '\u0a81' .. '\u0a82'
            | '\u0a83'
            | '\u0a85' .. '\u0a8d'
            | '\u0a8f' .. '\u0a91'
            | '\u0a93' .. '\u0aa8'
            | '\u0aaa' .. '\u0ab0'
            | '\u0ab2' .. '\u0ab3'
            | '\u0ab5' .. '\u0ab9'
            | '\u0abc'
            | '\u0abd'
            | '\u0abe' .. '\u0ac0'
            | '\u0ac1' .. '\u0ac5'
            | '\u0ac7' .. '\u0ac8'
            | '\u0ac9'
            | '\u0acb' .. '\u0acc'
            | '\u0acd'
            | '\u0ad0'
            | '\u0ae0' .. '\u0ae1'
            | '\u0ae2' .. '\u0ae3'
            | '\u0ae6' .. '\u0aef'
            | '\u0b01'
            | '\u0b02' .. '\u0b03'
            | '\u0b05' .. '\u0b0c'
            | '\u0b0f' .. '\u0b10'
            | '\u0b13' .. '\u0b28'
            | '\u0b2a' .. '\u0b30'
            | '\u0b32' .. '\u0b33'
            | '\u0b35' .. '\u0b39'
            | '\u0b3c'
            | '\u0b3d'
            | '\u0b3e'
            | '\u0b3f'
            | '\u0b40'
            | '\u0b41' .. '\u0b44'
            | '\u0b47' .. '\u0b48'
            | '\u0b4b' .. '\u0b4c'
            | '\u0b4d'
            | '\u0b56'
            | '\u0b57'
            | '\u0b5c' .. '\u0b5d'
            | '\u0b5f' .. '\u0b61'
            | '\u0b62' .. '\u0b63'
            | '\u0b66' .. '\u0b6f'
            | '\u0b71'
            | '\u0b82'
            | '\u0b83'
            | '\u0b85' .. '\u0b8a'
            | '\u0b8e' .. '\u0b90'
            | '\u0b92' .. '\u0b95'
            | '\u0b99' .. '\u0b9a'
            | '\u0b9c'
            | '\u0b9e' .. '\u0b9f'
            | '\u0ba3' .. '\u0ba4'
            | '\u0ba8' .. '\u0baa'
            | '\u0bae' .. '\u0bb9'
            | '\u0bbe' .. '\u0bbf'
            | '\u0bc0'
            | '\u0bc1' .. '\u0bc2'
            | '\u0bc6' .. '\u0bc8'
            | '\u0bca' .. '\u0bcc'
            | '\u0bcd'
            | '\u0bd0'
            | '\u0bd7'
            | '\u0be6' .. '\u0bef'
            | '\u0c01' .. '\u0c03'
            | '\u0c05' .. '\u0c0c'
            | '\u0c0e' .. '\u0c10'
            | '\u0c12' .. '\u0c28'
            | '\u0c2a' .. '\u0c33'
            | '\u0c35' .. '\u0c39'
            | '\u0c3d'
            | '\u0c3e' .. '\u0c40'
            | '\u0c41' .. '\u0c44'
            | '\u0c46' .. '\u0c48'
            | '\u0c4a' .. '\u0c4d'
            | '\u0c55' .. '\u0c56'
            | '\u0c58' .. '\u0c59'
            | '\u0c60' .. '\u0c61'
            | '\u0c62' .. '\u0c63'
            | '\u0c66' .. '\u0c6f'
            | '\u0c82' .. '\u0c83'
            | '\u0c85' .. '\u0c8c'
            | '\u0c8e' .. '\u0c90'
            | '\u0c92' .. '\u0ca8'
            | '\u0caa' .. '\u0cb3'
            | '\u0cb5' .. '\u0cb9'
            | '\u0cbc'
            | '\u0cbd'
            | '\u0cbe'
            | '\u0cbf'
            | '\u0cc0' .. '\u0cc4'
            | '\u0cc6'
            | '\u0cc7' .. '\u0cc8'
            | '\u0cca' .. '\u0ccb'
            | '\u0ccc' .. '\u0ccd'
            | '\u0cd5' .. '\u0cd6'
            | '\u0cde'
            | '\u0ce0' .. '\u0ce1'
            | '\u0ce2' .. '\u0ce3'
            | '\u0ce6' .. '\u0cef'
            | '\u0cf1' .. '\u0cf2'
            | '\u0d02' .. '\u0d03'
            | '\u0d05' .. '\u0d0c'
            | '\u0d0e' .. '\u0d10'
            | '\u0d12' .. '\u0d3a'
            | '\u0d3d'
            | '\u0d3e' .. '\u0d40'
            | '\u0d41' .. '\u0d44'
            | '\u0d46' .. '\u0d48'
            | '\u0d4a' .. '\u0d4c'
            | '\u0d4d'
            | '\u0d4e'
            | '\u0d57'
            | '\u0d60' .. '\u0d61'
            | '\u0d62' .. '\u0d63'
            | '\u0d66' .. '\u0d6f'
            | '\u0d7a' .. '\u0d7f'
            | '\u0d82' .. '\u0d83'
            | '\u0d85' .. '\u0d96'
            | '\u0d9a' .. '\u0db1'
            | '\u0db3' .. '\u0dbb'
            | '\u0dbd'
            | '\u0dc0' .. '\u0dc6'
            | '\u0dca'
            | '\u0dcf' .. '\u0dd1'
            | '\u0dd2' .. '\u0dd4'
            | '\u0dd6'
            | '\u0dd8' .. '\u0ddf'
            | '\u0df2' .. '\u0df3'
            | '\u0e01' .. '\u0e30'
            | '\u0e31'
            | '\u0e32' .. '\u0e33'
            | '\u0e34' .. '\u0e3a'
            | '\u0e40' .. '\u0e45'
            | '\u0e46'
            | '\u0e47' .. '\u0e4e'
            | '\u0e50' .. '\u0e59'
            | '\u0e81' .. '\u0e82'
            | '\u0e84'
            | '\u0e87' .. '\u0e88'
            | '\u0e8a'
            | '\u0e8d'
            | '\u0e94' .. '\u0e97'
            | '\u0e99' .. '\u0e9f'
            | '\u0ea1' .. '\u0ea3'
            | '\u0ea5'
            | '\u0ea7'
            | '\u0eaa' .. '\u0eab'
            | '\u0ead' .. '\u0eb0'
            | '\u0eb1'
            | '\u0eb2' .. '\u0eb3'
            | '\u0eb4' .. '\u0eb9'
            | '\u0ebb' .. '\u0ebc'
            | '\u0ebd'
            | '\u0ec0' .. '\u0ec4'
            | '\u0ec6'
            | '\u0ec8' .. '\u0ecd'
            | '\u0ed0' .. '\u0ed9'
            | '\u0edc' .. '\u0edd'
            | '\u0f00'
            | '\u0f18' .. '\u0f19'
            | '\u0f20' .. '\u0f29'
            | '\u0f35'
            | '\u0f37'
            | '\u0f39'
            | '\u0f3e' .. '\u0f3f'
            | '\u0f40' .. '\u0f47'
            | '\u0f49' .. '\u0f6c'
            | '\u0f71' .. '\u0f7e'
            | '\u0f7f'
            | '\u0f80' .. '\u0f84'
            | '\u0f86' .. '\u0f87'
            | '\u0f88' .. '\u0f8c'
            | '\u0f8d' .. '\u0f97'
            | '\u0f99' .. '\u0fbc'
            | '\u0fc6'
            | '\u1000' .. '\u102a'
            | '\u102b' .. '\u102c'
            | '\u102d' .. '\u1030'
            | '\u1031'
            | '\u1032' .. '\u1037'
            | '\u1038'
            | '\u1039' .. '\u103a'
            | '\u103b' .. '\u103c'
            | '\u103d' .. '\u103e'
            | '\u103f'
            | '\u1040' .. '\u1049'
            | '\u1050' .. '\u1055'
            | '\u1056' .. '\u1057'
            | '\u1058' .. '\u1059'
            | '\u105a' .. '\u105d'
            | '\u105e' .. '\u1060'
            | '\u1061'
            | '\u1062' .. '\u1064'
            | '\u1065' .. '\u1066'
            | '\u1067' .. '\u106d'
            | '\u106e' .. '\u1070'
            | '\u1071' .. '\u1074'
            | '\u1075' .. '\u1081'
            | '\u1082'
            | '\u1083' .. '\u1084'
            | '\u1085' .. '\u1086'
            | '\u1087' .. '\u108c'
            | '\u108d'
            | '\u108e'
            | '\u108f'
            | '\u1090' .. '\u1099'
            | '\u109a' .. '\u109c'
            | '\u109d'
            | '\u10a0' .. '\u10c5'
            | '\u10d0' .. '\u10fa'
            | '\u10fc'
            | '\u1100' .. '\u1248'
            | '\u124a' .. '\u124d'
            | '\u1250' .. '\u1256'
            | '\u1258'
            | '\u125a' .. '\u125d'
            | '\u1260' .. '\u1288'
            | '\u128a' .. '\u128d'
            | '\u1290' .. '\u12b0'
            | '\u12b2' .. '\u12b5'
            | '\u12b8' .. '\u12be'
            | '\u12c0'
            | '\u12c2' .. '\u12c5'
            | '\u12c8' .. '\u12d6'
            | '\u12d8' .. '\u1310'
            | '\u1312' .. '\u1315'
            | '\u1318' .. '\u135a'
            | '\u135d' .. '\u135f'
            | '\u1369' .. '\u1371'
            | '\u1380' .. '\u138f'
            | '\u13a0' .. '\u13f4'
            | '\u1401' .. '\u166c'
            | '\u166f' .. '\u167f'
            | '\u1681' .. '\u169a'
            | '\u16a0' .. '\u16ea'
            | '\u16ee' .. '\u16f0'
            | '\u1700' .. '\u170c'
            | '\u170e' .. '\u1711'
            | '\u1712' .. '\u1714'
            | '\u1720' .. '\u1731'
            | '\u1732' .. '\u1734'
            | '\u1740' .. '\u1751'
            | '\u1752' .. '\u1753'
            | '\u1760' .. '\u176c'
            | '\u176e' .. '\u1770'
            | '\u1772' .. '\u1773'
            | '\u1780' .. '\u17b3'
            | '\u17b6'
            | '\u17b7' .. '\u17bd'
            | '\u17be' .. '\u17c5'
            | '\u17c6'
            | '\u17c7' .. '\u17c8'
            | '\u17c9' .. '\u17d3'
            | '\u17d7'
            | '\u17dc'
            | '\u17dd'
            | '\u17e0' .. '\u17e9'
            | '\u180b' .. '\u180d'
            | '\u1810' .. '\u1819'
            | '\u1820' .. '\u1842'
            | '\u1843'
            | '\u1844' .. '\u1877'
            | '\u1880' .. '\u18a8'
            | '\u18a9'
            | '\u18aa'
            | '\u18b0' .. '\u18f5'
            | '\u1900' .. '\u191c'
            | '\u1920' .. '\u1922'
            | '\u1923' .. '\u1926'
            | '\u1927' .. '\u1928'
            | '\u1929' .. '\u192b'
            | '\u1930' .. '\u1931'
            | '\u1932'
            | '\u1933' .. '\u1938'
            | '\u1939' .. '\u193b'
            | '\u1946' .. '\u194f'
            | '\u1950' .. '\u196d'
            | '\u1970' .. '\u1974'
            | '\u1980' .. '\u19ab'
            | '\u19b0' .. '\u19c0'
            | '\u19c1' .. '\u19c7'
            | '\u19c8' .. '\u19c9'
            | '\u19d0' .. '\u19d9'
            | '\u19da'
            | '\u1a00' .. '\u1a16'
            | '\u1a17' .. '\u1a18'
            | '\u1a19' .. '\u1a1b'
            | '\u1a20' .. '\u1a54'
            | '\u1a55'
            | '\u1a56'
            | '\u1a57'
            | '\u1a58' .. '\u1a5e'
            | '\u1a60'
            | '\u1a61'
            | '\u1a62'
            | '\u1a63' .. '\u1a64'
            | '\u1a65' .. '\u1a6c'
            | '\u1a6d' .. '\u1a72'
            | '\u1a73' .. '\u1a7c'
            | '\u1a7f'
            | '\u1a80' .. '\u1a89'
            | '\u1a90' .. '\u1a99'
            | '\u1aa7'
            | '\u1b00' .. '\u1b03'
            | '\u1b04'
            | '\u1b05' .. '\u1b33'
            | '\u1b34'
            | '\u1b35'
            | '\u1b36' .. '\u1b3a'
            | '\u1b3b'
            | '\u1b3c'
            | '\u1b3d' .. '\u1b41'
            | '\u1b42'
            | '\u1b43' .. '\u1b44'
            | '\u1b45' .. '\u1b4b'
            | '\u1b50' .. '\u1b59'
            | '\u1b6b' .. '\u1b73'
            | '\u1b80' .. '\u1b81'
            | '\u1b82'
            | '\u1b83' .. '\u1ba0'
            | '\u1ba1'
            | '\u1ba2' .. '\u1ba5'
            | '\u1ba6' .. '\u1ba7'
            | '\u1ba8' .. '\u1ba9'
            | '\u1baa'
            | '\u1bae' .. '\u1baf'
            | '\u1bb0' .. '\u1bb9'
            | '\u1bc0' .. '\u1be5'
            | '\u1be6'
            | '\u1be7'
            | '\u1be8' .. '\u1be9'
            | '\u1bea' .. '\u1bec'
            | '\u1bed'
            | '\u1bee'
            | '\u1bef' .. '\u1bf1'
            | '\u1bf2' .. '\u1bf3'
            | '\u1c00' .. '\u1c23'
            | '\u1c24' .. '\u1c2b'
            | '\u1c2c' .. '\u1c33'
            | '\u1c34' .. '\u1c35'
            | '\u1c36' .. '\u1c37'
            | '\u1c40' .. '\u1c49'
            | '\u1c4d' .. '\u1c4f'
            | '\u1c50' .. '\u1c59'
            | '\u1c5a' .. '\u1c77'
            | '\u1c78' .. '\u1c7d'
            | '\u1cd0' .. '\u1cd2'
            | '\u1cd4' .. '\u1ce0'
            | '\u1ce1'
            | '\u1ce2' .. '\u1ce8'
            | '\u1ce9' .. '\u1cec'
            | '\u1ced'
            | '\u1cee' .. '\u1cf1'
            | '\u1cf2'
            | '\u1d00' .. '\u1d2b'
            | '\u1d2c' .. '\u1d61'
            | '\u1d62' .. '\u1d77'
            | '\u1d78'
            | '\u1d79' .. '\u1d9a'
            | '\u1d9b' .. '\u1dbf'
            | '\u1dc0' .. '\u1de6'
            | '\u1dfc' .. '\u1dff'
            | '\u1e00' .. '\u1f15'
            | '\u1f18' .. '\u1f1d'
            | '\u1f20' .. '\u1f45'
            | '\u1f48' .. '\u1f4d'
            | '\u1f50' .. '\u1f57'
            | '\u1f59'
            | '\u1f5b'
            | '\u1f5d'
            | '\u1f5f' .. '\u1f7d'
            | '\u1f80' .. '\u1fb4'
            | '\u1fb6' .. '\u1fbc'
            | '\u1fbe'
            | '\u1fc2' .. '\u1fc4'
            | '\u1fc6' .. '\u1fcc'
            | '\u1fd0' .. '\u1fd3'
            | '\u1fd6' .. '\u1fdb'
            | '\u1fe0' .. '\u1fec'
            | '\u1ff2' .. '\u1ff4'
            | '\u1ff6' .. '\u1ffc'
            | '\u203f' .. '\u2040'
            | '\u2054'
            | '\u2071'
            | '\u207f'
            | '\u2090' .. '\u209c'
            | '\u20d0' .. '\u20dc'
            | '\u20e1'
            | '\u20e5' .. '\u20f0'
            | '\u2102'
            | '\u2107'
            | '\u210a' .. '\u2113'
            | '\u2115'
            | '\u2118'
            | '\u2119' .. '\u211d'
            | '\u2124'
            | '\u2126'
            | '\u2128'
            | '\u212a' .. '\u212d'
            | '\u212e'
            | '\u212f' .. '\u2134'
            | '\u2135' .. '\u2138'
            | '\u2139'
            | '\u213c' .. '\u213f'
            | '\u2145' .. '\u2149'
            | '\u214e'
            | '\u2160' .. '\u2182'
            | '\u2183' .. '\u2184'
            | '\u2185' .. '\u2188'
            | '\u2c00' .. '\u2c2e'
            | '\u2c30' .. '\u2c5e'
            | '\u2c60' .. '\u2c7c'
            | '\u2c7d'
            | '\u2c7e' .. '\u2ce4'
            | '\u2ceb' .. '\u2cee'
            | '\u2cef' .. '\u2cf1'
            | '\u2d00' .. '\u2d25'
            | '\u2d30' .. '\u2d65'
            | '\u2d6f'
            | '\u2d7f'
            | '\u2d80' .. '\u2d96'
            | '\u2da0' .. '\u2da6'
            | '\u2da8' .. '\u2dae'
            | '\u2db0' .. '\u2db6'
            | '\u2db8' .. '\u2dbe'
            | '\u2dc0' .. '\u2dc6'
            | '\u2dc8' .. '\u2dce'
            | '\u2dd0' .. '\u2dd6'
            | '\u2dd8' .. '\u2dde'
            | '\u2de0' .. '\u2dff'
            | '\u3005'
            | '\u3006'
            | '\u3007'
            | '\u3021' .. '\u3029'
            | '\u302a' .. '\u302f'
            | '\u3031' .. '\u3035'
            | '\u3038' .. '\u303a'
            | '\u303b'
            | '\u303c'
            | '\u3041' .. '\u3096'
            | '\u3099' .. '\u309a'
            | '\u309d' .. '\u309e'
            | '\u309f'
            | '\u30a1' .. '\u30fa'
            | '\u30fc' .. '\u30fe'
            | '\u30ff'
            | '\u3105' .. '\u312d'
            | '\u3131' .. '\u318e'
            | '\u31a0' .. '\u31ba'
            | '\u31f0' .. '\u31ff'
            | '\u3400' .. '\u4db5'
            | '\u4e00' .. '\u9fcb'
            | '\ua000' .. '\ua014'
            | '\ua015'
            | '\ua016' .. '\ua48c'
            | '\ua4d0' .. '\ua4f7'
            | '\ua4f8' .. '\ua4fd'
            | '\ua500' .. '\ua60b'
            | '\ua60c'
            | '\ua610' .. '\ua61f'
            | '\ua620' .. '\ua629'
            | '\ua62a' .. '\ua62b'
            | '\ua640' .. '\ua66d'
            | '\ua66e'
            | '\ua66f'
            | '\ua67c' .. '\ua67d'
            | '\ua67f'
            | '\ua680' .. '\ua697'
            | '\ua6a0' .. '\ua6e5'
            | '\ua6e6' .. '\ua6ef'
            | '\ua6f0' .. '\ua6f1'
            | '\ua717' .. '\ua71f'
            | '\ua722' .. '\ua76f'
            | '\ua770'
            | '\ua771' .. '\ua787'
            | '\ua788'
            | '\ua78b' .. '\ua78e'
            | '\ua790' .. '\ua791'
            | '\ua7a0' .. '\ua7a9'
            | '\ua7fa'
            | '\ua7fb' .. '\ua801'
            | '\ua802'
            | '\ua803' .. '\ua805'
            | '\ua806'
            | '\ua807' .. '\ua80a'
            | '\ua80b'
            | '\ua80c' .. '\ua822'
            | '\ua823' .. '\ua824'
            | '\ua825' .. '\ua826'
            | '\ua827'
            | '\ua840' .. '\ua873'
            | '\ua880' .. '\ua881'
            | '\ua882' .. '\ua8b3'
            | '\ua8b4' .. '\ua8c3'
            | '\ua8c4'
            | '\ua8d0' .. '\ua8d9'
            | '\ua8e0' .. '\ua8f1'
            | '\ua8f2' .. '\ua8f7'
            | '\ua8fb'
            | '\ua900' .. '\ua909'
            | '\ua90a' .. '\ua925'
            | '\ua926' .. '\ua92d'
            | '\ua930' .. '\ua946'
            | '\ua947' .. '\ua951'
            | '\ua952' .. '\ua953'
            | '\ua960' .. '\ua97c'
            | '\ua980' .. '\ua982'
            | '\ua983'
            | '\ua984' .. '\ua9b2'
            | '\ua9b3'
            | '\ua9b4' .. '\ua9b5'
            | '\ua9b6' .. '\ua9b9'
            | '\ua9ba' .. '\ua9bb'
            | '\ua9bc'
            | '\ua9bd' .. '\ua9c0'
            | '\ua9cf'
            | '\ua9d0' .. '\ua9d9'
            | '\uaa00' .. '\uaa28'
            | '\uaa29' .. '\uaa2e'
            | '\uaa2f' .. '\uaa30'
            | '\uaa31' .. '\uaa32'
            | '\uaa33' .. '\uaa34'
            | '\uaa35' .. '\uaa36'
            | '\uaa40' .. '\uaa42'
            | '\uaa43'
            | '\uaa44' .. '\uaa4b'
            | '\uaa4c'
            | '\uaa4d'
            | '\uaa50' .. '\uaa59'
            | '\uaa60' .. '\uaa6f'
            | '\uaa70'
            | '\uaa71' .. '\uaa76'
            | '\uaa7a'
            | '\uaa7b'
            | '\uaa80' .. '\uaaaf'
            | '\uaab0'
            | '\uaab1'
            | '\uaab2' .. '\uaab4'
            | '\uaab5' .. '\uaab6'
            | '\uaab7' .. '\uaab8'
            | '\uaab9' .. '\uaabd'
            | '\uaabe' .. '\uaabf'
            | '\uaac0'
            | '\uaac1'
            | '\uaac2'
            | '\uaadb' .. '\uaadc'
            | '\uaadd'
            | '\uab01' .. '\uab06'
            | '\uab09' .. '\uab0e'
            | '\uab11' .. '\uab16'
            | '\uab20' .. '\uab26'
            | '\uab28' .. '\uab2e'
            | '\uabc0' .. '\uabe2'
            | '\uabe3' .. '\uabe4'
            | '\uabe5'
            | '\uabe6' .. '\uabe7'
            | '\uabe8'
            | '\uabe9' .. '\uabea'
            | '\uabec'
            | '\uabed'
            | '\uabf0' .. '\uabf9'
            | '\uac00' .. '\ud7a3'
            | '\ud7b0' .. '\ud7c6'
            | '\ud7cb' .. '\ud7fb'
            | '\uf900' .. '\ufa2d'
            | '\ufa30' .. '\ufa6d'
            | '\ufa70' .. '\ufad9'
            | '\ufb00' .. '\ufb06'
            | '\ufb13' .. '\ufb17'
            | '\ufb1d'
            | '\ufb1e'
            | '\ufb1f' .. '\ufb28'
            | '\ufb2a' .. '\ufb36'
            | '\ufb38' .. '\ufb3c'
            | '\ufb3e'
            | '\ufb40' .. '\ufb41'
            | '\ufb43' .. '\ufb44'
            | '\ufb46' .. '\ufbb1'
            | '\ufbd3' .. '\ufc5d'
            | '\ufc64' .. '\ufd3d'
            | '\ufd50' .. '\ufd8f'
            | '\ufd92' .. '\ufdc7'
            | '\ufdf0' .. '\ufdf9'
            | '\ufe00' .. '\ufe0f'
            | '\ufe20' .. '\ufe26'
            | '\ufe33' .. '\ufe34'
            | '\ufe4d' .. '\ufe4f'
            | '\ufe71'
            | '\ufe73'
            | '\ufe77'
            | '\ufe79'
            | '\ufe7b'
            | '\ufe7d'
            | '\ufe7f' .. '\ufefc'
            | '\uff10' .. '\uff19'
            | '\uff21' .. '\uff3a'
            | '\uff3f'
            | '\uff41' .. '\uff5a'
            | '\uff66' .. '\uff6f'
            | '\uff70'
            | '\uff71' .. '\uff9d'
            | '\uff9e' .. '\uff9f'
            | '\uffa0' .. '\uffbe'
            | '\uffc2' .. '\uffc7'
            | '\uffca' .. '\uffcf'
            | '\uffd2' .. '\uffd7'
            | '\uffda' .. '\uffdc'
            | '\U00010000' .. '\U0001000b'
            | '\U0001000d' .. '\U00010026'
            | '\U00010028' .. '\U0001003a'
            | '\U0001003c' .. '\U0001003d'
            | '\U0001003f' .. '\U0001004d'
            | '\U00010050' .. '\U0001005d'
            | '\U00010080' .. '\U000100fa'
            | '\U00010140' .. '\U00010174'
            | '\U000101fd'
            | '\U00010280' .. '\U0001029c'
            | '\U000102a0' .. '\U000102d0'
            | '\U00010300' .. '\U0001031e'
            | '\U00010330' .. '\U00010340'
            | '\U00010341'
            | '\U00010342' .. '\U00010349'
            | '\U0001034a'
            | '\U00010380' .. '\U0001039d'
            | '\U000103a0' .. '\U000103c3'
            | '\U000103c8' .. '\U000103cf'
            | '\U000103d1' .. '\U000103d5'
            | '\U00010400' .. '\U0001044f'
            | '\U00010450' .. '\U0001049d'
            | '\U000104a0' .. '\U000104a9'
            | '\U00010800' .. '\U00010805'
            | '\U00010808'
            | '\U0001080a' .. '\U00010835'
            | '\U00010837' .. '\U00010838'
            | '\U0001083c'
            | '\U0001083f' .. '\U00010855'
            | '\U00010900' .. '\U00010915'
            | '\U00010920' .. '\U00010939'
            | '\U00010a00'
            | '\U00010a01' .. '\U00010a03'
            | '\U00010a05' .. '\U00010a06'
            | '\U00010a0c' .. '\U00010a0f'
            | '\U00010a10' .. '\U00010a13'
            | '\U00010a15' .. '\U00010a17'
            | '\U00010a19' .. '\U00010a33'
            | '\U00010a38' .. '\U00010a3a'
            | '\U00010a3f'
            | '\U00010a60' .. '\U00010a7c'
            | '\U00010b00' .. '\U00010b35'
            | '\U00010b40' .. '\U00010b55'
            | '\U00010b60' .. '\U00010b72'
            | '\U00010c00' .. '\U00010c48'
            | '\U00011000'
            | '\U00011001'
            | '\U00011002'
            | '\U00011003' .. '\U00011037'
            | '\U00011038' .. '\U00011046'
            | '\U00011066' .. '\U0001106f'
            | '\U00011080' .. '\U00011081'
            | '\U00011082'
            | '\U00011083' .. '\U000110af'
            | '\U000110b0' .. '\U000110b2'
            | '\U000110b3' .. '\U000110b6'
            | '\U000110b7' .. '\U000110b8'
            | '\U000110b9' .. '\U000110ba'
            | '\U00012000' .. '\U0001236e'
            | '\U00012400' .. '\U00012462'
            | '\U00013000' .. '\U0001342e'
            | '\U00016800' .. '\U00016a38'
            | '\U0001b000' .. '\U0001b001'
            | '\U0001d165' .. '\U0001d166'
            | '\U0001d167' .. '\U0001d169'
            | '\U0001d16d' .. '\U0001d172'
            | '\U0001d17b' .. '\U0001d182'
            | '\U0001d185' .. '\U0001d18b'
            | '\U0001d1aa' .. '\U0001d1ad'
            | '\U0001d242' .. '\U0001d244'
            | '\U0001d400' .. '\U0001d454'
            | '\U0001d456' .. '\U0001d49c'
            | '\U0001d49e' .. '\U0001d49f'
            | '\U0001d4a2'
            | '\U0001d4a5' .. '\U0001d4a6'
            | '\U0001d4a9' .. '\U0001d4ac'
            | '\U0001d4ae' .. '\U0001d4b9'
            | '\U0001d4bb'
            | '\U0001d4bd' .. '\U0001d4c3'
            | '\U0001d4c5' .. '\U0001d505'
            | '\U0001d507' .. '\U0001d50a'
            | '\U0001d50d' .. '\U0001d514'
            | '\U0001d516' .. '\U0001d51c'
            | '\U0001d51e' .. '\U0001d539'
            | '\U0001d53b' .. '\U0001d53e'
            | '\U0001d540' .. '\U0001d544'
            | '\U0001d546'
            | '\U0001d54a' .. '\U0001d550'
            | '\U0001d552' .. '\U0001d6a5'
            | '\U0001d6a8' .. '\U0001d6c0'
            | '\U0001d6c2' .. '\U0001d6da'
            | '\U0001d6dc' .. '\U0001d6fa'
            | '\U0001d6fc' .. '\U0001d714'
            | '\U0001d716' .. '\U0001d734'
            | '\U0001d736' .. '\U0001d74e'
            | '\U0001d750' .. '\U0001d76e'
            | '\U0001d770' .. '\U0001d788'
            | '\U0001d78a' .. '\U0001d7a8'
            | '\U0001d7aa' .. '\U0001d7c2'
            | '\U0001d7c4' .. '\U0001d7cb'
            | '\U0001d7ce' .. '\U0001d7ff'
            | '\U00020000' .. '\U0002a6d6'
            | '\U0002a700' .. '\U0002b734'
            | '\U0002b740' .. '\U0002b81d'
            | '\U0002f800' .. '\U0002fa1d'
            | '\U000e0100' .. '\U000e01ef'
            ;

XIDSTART :
              '\u0041' .. '\u005a'
            | '\u0061' .. '\u007a'
            | '\u00aa'
            | '\u00b5'
            | '\u00ba'
            | '\u00c0' .. '\u00d6'
            | '\u00d8' .. '\u00f6'
            | '\u00f8' .. '\u01ba'
            | '\u01bb'
            | '\u01bc' .. '\u01bf'
            | '\u01c0' .. '\u01c3'
            | '\u01c4' .. '\u0293'
            | '\u0294'
            | '\u0295' .. '\u02af'
            | '\u02b0' .. '\u02c1'
            | '\u02c6' .. '\u02d1'
            | '\u02e0' .. '\u02e4'
            | '\u02ec'
            | '\u02ee'
            | '\u0370' .. '\u0373'
            | '\u0374'
            | '\u0376' .. '\u0377'
            | '\u037b' .. '\u037d'
            | '\u0386'
            | '\u0388' .. '\u038a'
            | '\u038c'
            | '\u038e' .. '\u03a1'
            | '\u03a3' .. '\u03f5'
            | '\u03f7' .. '\u0481'
            | '\u048a' .. '\u0527'
            | '\u0531' .. '\u0556'
            | '\u0559'
            | '\u0561' .. '\u0587'
            | '\u05d0' .. '\u05ea'
            | '\u05f0' .. '\u05f2'
            | '\u0620' .. '\u063f'
            | '\u0640'
            | '\u0641' .. '\u064a'
            | '\u066e' .. '\u066f'
            | '\u0671' .. '\u06d3'
            | '\u06d5'
            | '\u06e5' .. '\u06e6'
            | '\u06ee' .. '\u06ef'
            | '\u06fa' .. '\u06fc'
            | '\u06ff'
            | '\u0710'
            | '\u0712' .. '\u072f'
            | '\u074d' .. '\u07a5'
            | '\u07b1'
            | '\u07ca' .. '\u07ea'
            | '\u07f4' .. '\u07f5'
            | '\u07fa'
            | '\u0800' .. '\u0815'
            | '\u081a'
            | '\u0824'
            | '\u0828'
            | '\u0840' .. '\u0858'
            | '\u0904' .. '\u0939'
            | '\u093d'
            | '\u0950'
            | '\u0958' .. '\u0961'
            | '\u0971'
            | '\u0972' .. '\u0977'
            | '\u0979' .. '\u097f'
            | '\u0985' .. '\u098c'
            | '\u098f' .. '\u0990'
            | '\u0993' .. '\u09a8'
            | '\u09aa' .. '\u09b0'
            | '\u09b2'
            | '\u09b6' .. '\u09b9'
            | '\u09bd'
            | '\u09ce'
            | '\u09dc' .. '\u09dd'
            | '\u09df' .. '\u09e1'
            | '\u09f0' .. '\u09f1'
            | '\u0a05' .. '\u0a0a'
            | '\u0a0f' .. '\u0a10'
            | '\u0a13' .. '\u0a28'
            | '\u0a2a' .. '\u0a30'
            | '\u0a32' .. '\u0a33'
            | '\u0a35' .. '\u0a36'
            | '\u0a38' .. '\u0a39'
            | '\u0a59' .. '\u0a5c'
            | '\u0a5e'
            | '\u0a72' .. '\u0a74'
            | '\u0a85' .. '\u0a8d'
            | '\u0a8f' .. '\u0a91'
            | '\u0a93' .. '\u0aa8'
            | '\u0aaa' .. '\u0ab0'
            | '\u0ab2' .. '\u0ab3'
            | '\u0ab5' .. '\u0ab9'
            | '\u0abd'
            | '\u0ad0'
            | '\u0ae0' .. '\u0ae1'
            | '\u0b05' .. '\u0b0c'
            | '\u0b0f' .. '\u0b10'
            | '\u0b13' .. '\u0b28'
            | '\u0b2a' .. '\u0b30'
            | '\u0b32' .. '\u0b33'
            | '\u0b35' .. '\u0b39'
            | '\u0b3d'
            | '\u0b5c' .. '\u0b5d'
            | '\u0b5f' .. '\u0b61'
            | '\u0b71'
            | '\u0b83'
            | '\u0b85' .. '\u0b8a'
            | '\u0b8e' .. '\u0b90'
            | '\u0b92' .. '\u0b95'
            | '\u0b99' .. '\u0b9a'
            | '\u0b9c'
            | '\u0b9e' .. '\u0b9f'
            | '\u0ba3' .. '\u0ba4'
            | '\u0ba8' .. '\u0baa'
            | '\u0bae' .. '\u0bb9'
            | '\u0bd0'
            | '\u0c05' .. '\u0c0c'
            | '\u0c0e' .. '\u0c10'
            | '\u0c12' .. '\u0c28'
            | '\u0c2a' .. '\u0c33'
            | '\u0c35' .. '\u0c39'
            | '\u0c3d'
            | '\u0c58' .. '\u0c59'
            | '\u0c60' .. '\u0c61'
            | '\u0c85' .. '\u0c8c'
            | '\u0c8e' .. '\u0c90'
            | '\u0c92' .. '\u0ca8'
            | '\u0caa' .. '\u0cb3'
            | '\u0cb5' .. '\u0cb9'
            | '\u0cbd'
            | '\u0cde'
            | '\u0ce0' .. '\u0ce1'
            | '\u0cf1' .. '\u0cf2'
            | '\u0d05' .. '\u0d0c'
            | '\u0d0e' .. '\u0d10'
            | '\u0d12' .. '\u0d3a'
            | '\u0d3d'
            | '\u0d4e'
            | '\u0d60' .. '\u0d61'
            | '\u0d7a' .. '\u0d7f'
            | '\u0d85' .. '\u0d96'
            | '\u0d9a' .. '\u0db1'
            | '\u0db3' .. '\u0dbb'
            | '\u0dbd'
            | '\u0dc0' .. '\u0dc6'
            | '\u0e01' .. '\u0e30'
            | '\u0e32'
            | '\u0e40' .. '\u0e45'
            | '\u0e46'
            | '\u0e81' .. '\u0e82'
            | '\u0e84'
            | '\u0e87' .. '\u0e88'
            | '\u0e8a'
            | '\u0e8d'
            | '\u0e94' .. '\u0e97'
            | '\u0e99' .. '\u0e9f'
            | '\u0ea1' .. '\u0ea3'
            | '\u0ea5'
            | '\u0ea7'
            | '\u0eaa' .. '\u0eab'
            | '\u0ead' .. '\u0eb0'
            | '\u0eb2'
            | '\u0ebd'
            | '\u0ec0' .. '\u0ec4'
            | '\u0ec6'
            | '\u0edc' .. '\u0edd'
            | '\u0f00'
            | '\u0f40' .. '\u0f47'
            | '\u0f49' .. '\u0f6c'
            | '\u0f88' .. '\u0f8c'
            | '\u1000' .. '\u102a'
            | '\u103f'
            | '\u1050' .. '\u1055'
            | '\u105a' .. '\u105d'
            | '\u1061'
            | '\u1065' .. '\u1066'
            | '\u106e' .. '\u1070'
            | '\u1075' .. '\u1081'
            | '\u108e'
            | '\u10a0' .. '\u10c5'
            | '\u10d0' .. '\u10fa'
            | '\u10fc'
            | '\u1100' .. '\u1248'
            | '\u124a' .. '\u124d'
            | '\u1250' .. '\u1256'
            | '\u1258'
            | '\u125a' .. '\u125d'
            | '\u1260' .. '\u1288'
            | '\u128a' .. '\u128d'
            | '\u1290' .. '\u12b0'
            | '\u12b2' .. '\u12b5'
            | '\u12b8' .. '\u12be'
            | '\u12c0'
            | '\u12c2' .. '\u12c5'
            | '\u12c8' .. '\u12d6'
            | '\u12d8' .. '\u1310'
            | '\u1312' .. '\u1315'
            | '\u1318' .. '\u135a'
            | '\u1380' .. '\u138f'
            | '\u13a0' .. '\u13f4'
            | '\u1401' .. '\u166c'
            | '\u166f' .. '\u167f'
            | '\u1681' .. '\u169a'
            | '\u16a0' .. '\u16ea'
            | '\u16ee' .. '\u16f0'
            | '\u1700' .. '\u170c'
            | '\u170e' .. '\u1711'
            | '\u1720' .. '\u1731'
            | '\u1740' .. '\u1751'
            | '\u1760' .. '\u176c'
            | '\u176e' .. '\u1770'
            | '\u1780' .. '\u17b3'
            | '\u17d7'
            | '\u17dc'
            | '\u1820' .. '\u1842'
            | '\u1843'
            | '\u1844' .. '\u1877'
            | '\u1880' .. '\u18a8'
            | '\u18aa'
            | '\u18b0' .. '\u18f5'
            | '\u1900' .. '\u191c'
            | '\u1950' .. '\u196d'
            | '\u1970' .. '\u1974'
            | '\u1980' .. '\u19ab'
            | '\u19c1' .. '\u19c7'
            | '\u1a00' .. '\u1a16'
            | '\u1a20' .. '\u1a54'
            | '\u1aa7'
            | '\u1b05' .. '\u1b33'
            | '\u1b45' .. '\u1b4b'
            | '\u1b83' .. '\u1ba0'
            | '\u1bae' .. '\u1baf'
            | '\u1bc0' .. '\u1be5'
            | '\u1c00' .. '\u1c23'
            | '\u1c4d' .. '\u1c4f'
            | '\u1c5a' .. '\u1c77'
            | '\u1c78' .. '\u1c7d'
            | '\u1ce9' .. '\u1cec'
            | '\u1cee' .. '\u1cf1'
            | '\u1d00' .. '\u1d2b'
            | '\u1d2c' .. '\u1d61'
            | '\u1d62' .. '\u1d77'
            | '\u1d78'
            | '\u1d79' .. '\u1d9a'
            | '\u1d9b' .. '\u1dbf'
            | '\u1e00' .. '\u1f15'
            | '\u1f18' .. '\u1f1d'
            | '\u1f20' .. '\u1f45'
            | '\u1f48' .. '\u1f4d'
            | '\u1f50' .. '\u1f57'
            | '\u1f59'
            | '\u1f5b'
            | '\u1f5d'
            | '\u1f5f' .. '\u1f7d'
            | '\u1f80' .. '\u1fb4'
            | '\u1fb6' .. '\u1fbc'
            | '\u1fbe'
            | '\u1fc2' .. '\u1fc4'
            | '\u1fc6' .. '\u1fcc'
            | '\u1fd0' .. '\u1fd3'
            | '\u1fd6' .. '\u1fdb'
            | '\u1fe0' .. '\u1fec'
            | '\u1ff2' .. '\u1ff4'
            | '\u1ff6' .. '\u1ffc'
            | '\u2071'
            | '\u207f'
            | '\u2090' .. '\u209c'
            | '\u2102'
            | '\u2107'
            | '\u210a' .. '\u2113'
            | '\u2115'
            | '\u2118'
            | '\u2119' .. '\u211d'
            | '\u2124'
            | '\u2126'
            | '\u2128'
            | '\u212a' .. '\u212d'
            | '\u212e'
            | '\u212f' .. '\u2134'
            | '\u2135' .. '\u2138'
            | '\u2139'
            | '\u213c' .. '\u213f'
            | '\u2145' .. '\u2149'
            | '\u214e'
            | '\u2160' .. '\u2182'
            | '\u2183' .. '\u2184'
            | '\u2185' .. '\u2188'
            | '\u2c00' .. '\u2c2e'
            | '\u2c30' .. '\u2c5e'
            | '\u2c60' .. '\u2c7c'
            | '\u2c7d'
            | '\u2c7e' .. '\u2ce4'
            | '\u2ceb' .. '\u2cee'
            | '\u2d00' .. '\u2d25'
            | '\u2d30' .. '\u2d65'
            | '\u2d6f'
            | '\u2d80' .. '\u2d96'
            | '\u2da0' .. '\u2da6'
            | '\u2da8' .. '\u2dae'
            | '\u2db0' .. '\u2db6'
            | '\u2db8' .. '\u2dbe'
            | '\u2dc0' .. '\u2dc6'
            | '\u2dc8' .. '\u2dce'
            | '\u2dd0' .. '\u2dd6'
            | '\u2dd8' .. '\u2dde'
            | '\u3005'
            | '\u3006'
            | '\u3007'
            | '\u3021' .. '\u3029'
            | '\u3031' .. '\u3035'
            | '\u3038' .. '\u303a'
            | '\u303b'
            | '\u303c'
            | '\u3041' .. '\u3096'
            | '\u309d' .. '\u309e'
            | '\u309f'
            | '\u30a1' .. '\u30fa'
            | '\u30fc' .. '\u30fe'
            | '\u30ff'
            | '\u3105' .. '\u312d'
            | '\u3131' .. '\u318e'
            | '\u31a0' .. '\u31ba'
            | '\u31f0' .. '\u31ff'
            | '\u3400' .. '\u4db5'
            | '\u4e00' .. '\u9fcb'
            | '\ua000' .. '\ua014'
            | '\ua015'
            | '\ua016' .. '\ua48c'
            | '\ua4d0' .. '\ua4f7'
            | '\ua4f8' .. '\ua4fd'
            | '\ua500' .. '\ua60b'
            | '\ua60c'
            | '\ua610' .. '\ua61f'
            | '\ua62a' .. '\ua62b'
            | '\ua640' .. '\ua66d'
            | '\ua66e'
            | '\ua67f'
            | '\ua680' .. '\ua697'
            | '\ua6a0' .. '\ua6e5'
            | '\ua6e6' .. '\ua6ef'
            | '\ua717' .. '\ua71f'
            | '\ua722' .. '\ua76f'
            | '\ua770'
            | '\ua771' .. '\ua787'
            | '\ua788'
            | '\ua78b' .. '\ua78e'
            | '\ua790' .. '\ua791'
            | '\ua7a0' .. '\ua7a9'
            | '\ua7fa'
            | '\ua7fb' .. '\ua801'
            | '\ua803' .. '\ua805'
            | '\ua807' .. '\ua80a'
            | '\ua80c' .. '\ua822'
            | '\ua840' .. '\ua873'
            | '\ua882' .. '\ua8b3'
            | '\ua8f2' .. '\ua8f7'
            | '\ua8fb'
            | '\ua90a' .. '\ua925'
            | '\ua930' .. '\ua946'
            | '\ua960' .. '\ua97c'
            | '\ua984' .. '\ua9b2'
            | '\ua9cf'
            | '\uaa00' .. '\uaa28'
            | '\uaa40' .. '\uaa42'
            | '\uaa44' .. '\uaa4b'
            | '\uaa60' .. '\uaa6f'
            | '\uaa70'
            | '\uaa71' .. '\uaa76'
            | '\uaa7a'
            | '\uaa80' .. '\uaaaf'
            | '\uaab1'
            | '\uaab5' .. '\uaab6'
            | '\uaab9' .. '\uaabd'
            | '\uaac0'
            | '\uaac2'
            | '\uaadb' .. '\uaadc'
            | '\uaadd'
            | '\uab01' .. '\uab06'
            | '\uab09' .. '\uab0e'
            | '\uab11' .. '\uab16'
            | '\uab20' .. '\uab26'
            | '\uab28' .. '\uab2e'
            | '\uabc0' .. '\uabe2'
            | '\uac00' .. '\ud7a3'
            | '\ud7b0' .. '\ud7c6'
            | '\ud7cb' .. '\ud7fb'
            | '\uf900' .. '\ufa2d'
            | '\ufa30' .. '\ufa6d'
            | '\ufa70' .. '\ufad9'
            | '\ufb00' .. '\ufb06'
            | '\ufb13' .. '\ufb17'
            | '\ufb1d'
            | '\ufb1f' .. '\ufb28'
            | '\ufb2a' .. '\ufb36'
            | '\ufb38' .. '\ufb3c'
            | '\ufb3e'
            | '\ufb40' .. '\ufb41'
            | '\ufb43' .. '\ufb44'
            | '\ufb46' .. '\ufbb1'
            | '\ufbd3' .. '\ufc5d'
            | '\ufc64' .. '\ufd3d'
            | '\ufd50' .. '\ufd8f'
            | '\ufd92' .. '\ufdc7'
            | '\ufdf0' .. '\ufdf9'
            | '\ufe71'
            | '\ufe73'
            | '\ufe77'
            | '\ufe79'
            | '\ufe7b'
            | '\ufe7d'
            | '\ufe7f' .. '\ufefc'
            | '\uff21' .. '\uff3a'
            | '\uff41' .. '\uff5a'
            | '\uff66' .. '\uff6f'
            | '\uff70'
            | '\uff71' .. '\uff9d'
            | '\uffa0' .. '\uffbe'
            | '\uffc2' .. '\uffc7'
            | '\uffca' .. '\uffcf'
            | '\uffd2' .. '\uffd7'
            | '\uffda' .. '\uffdc'
            | '\U00010000' .. '\U0001000b'
            | '\U0001000d' .. '\U00010026'
            | '\U00010028' .. '\U0001003a'
            | '\U0001003c' .. '\U0001003d'
            | '\U0001003f' .. '\U0001004d'
            | '\U00010050' .. '\U0001005d'
            | '\U00010080' .. '\U000100fa'
            | '\U00010140' .. '\U00010174'
            | '\U00010280' .. '\U0001029c'
            | '\U000102a0' .. '\U000102d0'
            | '\U00010300' .. '\U0001031e'
            | '\U00010330' .. '\U00010340'
            | '\U00010341'
            | '\U00010342' .. '\U00010349'
            | '\U0001034a'
            | '\U00010380' .. '\U0001039d'
            | '\U000103a0' .. '\U000103c3'
            | '\U000103c8' .. '\U000103cf'
            | '\U000103d1' .. '\U000103d5'
            | '\U00010400' .. '\U0001044f'
            | '\U00010450' .. '\U0001049d'
            | '\U00010800' .. '\U00010805'
            | '\U00010808'
            | '\U0001080a' .. '\U00010835'
            | '\U00010837' .. '\U00010838'
            | '\U0001083c'
            | '\U0001083f' .. '\U00010855'
            | '\U00010900' .. '\U00010915'
            | '\U00010920' .. '\U00010939'
            | '\U00010a00'
            | '\U00010a10' .. '\U00010a13'
            | '\U00010a15' .. '\U00010a17'
            | '\U00010a19' .. '\U00010a33'
            | '\U00010a60' .. '\U00010a7c'
            | '\U00010b00' .. '\U00010b35'
            | '\U00010b40' .. '\U00010b55'
            | '\U00010b60' .. '\U00010b72'
            | '\U00010c00' .. '\U00010c48'
            | '\U00011003' .. '\U00011037'
            | '\U00011083' .. '\U000110af'
            | '\U00012000' .. '\U0001236e'
            | '\U00012400' .. '\U00012462'
            | '\U00013000' .. '\U0001342e'
            | '\U00016800' .. '\U00016a38'
            | '\U0001b000' .. '\U0001b001'
            | '\U0001d400' .. '\U0001d454'
            | '\U0001d456' .. '\U0001d49c'
            | '\U0001d49e' .. '\U0001d49f'
            | '\U0001d4a2'
            | '\U0001d4a5' .. '\U0001d4a6'
            | '\U0001d4a9' .. '\U0001d4ac'
            | '\U0001d4ae' .. '\U0001d4b9'
            | '\U0001d4bb'
            | '\U0001d4bd' .. '\U0001d4c3'
            | '\U0001d4c5' .. '\U0001d505'
            | '\U0001d507' .. '\U0001d50a'
            | '\U0001d50d' .. '\U0001d514'
            | '\U0001d516' .. '\U0001d51c'
            | '\U0001d51e' .. '\U0001d539'
            | '\U0001d53b' .. '\U0001d53e'
            | '\U0001d540' .. '\U0001d544'
            | '\U0001d546'
            | '\U0001d54a' .. '\U0001d550'
            | '\U0001d552' .. '\U0001d6a5'
            | '\U0001d6a8' .. '\U0001d6c0'
            | '\U0001d6c2' .. '\U0001d6da'
            | '\U0001d6dc' .. '\U0001d6fa'
            | '\U0001d6fc' .. '\U0001d714'
            | '\U0001d716' .. '\U0001d734'
            | '\U0001d736' .. '\U0001d74e'
            | '\U0001d750' .. '\U0001d76e'
            | '\U0001d770' .. '\U0001d788'
            | '\U0001d78a' .. '\U0001d7a8'
            | '\U0001d7aa' .. '\U0001d7c2'
            | '\U0001d7c4' .. '\U0001d7cb'
            | '\U00020000' .. '\U0002a6d6'
            | '\U0002a700' .. '\U0002b734'
            | '\U0002b740' .. '\U0002b81d'
            | '\U0002f800' .. '\U0002fa1d'
          ;

