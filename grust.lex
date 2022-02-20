 /*
   Quoting from the Bison manual:

   "Finally, the resolution of conflicts works by comparing the precedence
   of the rule being considered with that of the lookahead token. If the
   token's precedence is higher, the choice is to shift. If the rule's
   precedence is higher, the choice is to reduce. If they have equal
   precedence, the choice is made based on the associativity of that
   precedence level. The verbose output file made by ‘-v’ (see Invoking
   Bison) says how each conflict was resolved"
 */

// We expect no shift/reduce or reduce/reduce conflicts in this grammar;
// all potential ambiguities are scrutinized and eliminated manually.
%expect 0

// fake-precedence symbol to cause '|' bars in lambda context to parse
// at low precedence, permit things like |x| foo = bar, where '=' is
// otherwise lower-precedence than '|'. Also used for proc() to cause
// things like proc() a + b to parse as proc() { a + b }.
%precedence LAMBDA

%precedence SELF

// MUT should be lower precedence than IDENT so that in the pat rule,
// "& MUT pat" has higher precedence than "binding_mode ident [@ pat]"
%precedence MUT

// IDENT needs to be lower than '{' so that 'foo {' is shifted when
// trying to decide if we've got a struct-construction expr (esp. in
// contexts like 'if foo { .')
//
// IDENT also needs to be lower precedence than '<' so that '<' in
// 'foo:bar . <' is shifted (in a trait reference occurring in a
// bounds list), parsing as foo:(bar<baz>) rather than (foo:bar)<baz>.
%precedence IDENT
 // Put the weak keywords that can be used as idents here as well
%precedence CATCH
%precedence DEFAULT
%precedence UNION

// A couple fake-precedence symbols to use in rules associated with +
// and < in trailing type contexts. These come up when you have a type
// in the RHS of operator-AS, such as "foo as bar<baz>". The "<" there
// has to be shifted so the parser keeps trying to parse a type, even
// though it might well consider reducing the type "bar" and then
// going on to "<" as a subsequent binop. The "+" case is with
// trailing type-bounds ("foo as bar:A+B"), for the same reason.
%precedence SHIFTPLUS

%precedence MOD_SEP
%precedence RARROW ':'

// In where clauses, "for" should have greater precedence when used as
// a higher ranked constraint than when used as the beginning of a
// for_in_type (which is a ty)
%precedence FORTYPE
%precedence FOR

// Binops & unops, and their precedences
%precedence '?'
%precedence BOX
%nonassoc DOTDOT

// RETURN needs to be lower-precedence than tokens that start
// prefix_exprs
%precedence RETURN YIELD

%right '=' SHLEQ SHREQ MINUSEQ ANDEQ OREQ PLUSEQ STAREQ SLASHEQ CARETEQ PERCENTEQ
%right LARROW
%left OROR
%left ANDAND
%left EQEQ NE
%left '<' '>' LE GE
%left '|'
%left '^'
%left '&'
%left SHL SHR
%left '+' '-'
%precedence AS
%left '*' '/' '%'
%precedence '!'

%precedence '{' '[' '(' '.'

%precedence RANGE

%start crate

%%


maybe_ty_sums_and_or_bindings
: ty_sums
| ty_sums ','
| ty_sums ',' bindings { $$ = mk_node("TySumsAndBindings", 2, $1, $3); }
| bindings
| bindings ','
| %empty               { $$ = mk_none(); }
;

maybe_bindings
: ',' bindings { $$ = $2; }
| %empty       { $$ = mk_none(); }
;

////////////////////////////////////////////////////////////////////////
// Part 2: Patterns
////////////////////////////////////////////////////////////////////////

pat
: UNDERSCORE                                      { $$ = mk_atom("PatWild"); }
| '&' pat                                         { $$ = mk_node("PatRegion", 1, $2); }
| '&' MUT pat                                     { $$ = mk_node("PatRegion", 1, $3); }
| ANDAND pat                                      { $$ = mk_node("PatRegion", 1, mk_node("PatRegion", 1, $2)); }
| '(' ')'                                         { $$ = mk_atom("PatUnit"); }
| '(' pat_tup ')'                                 { $$ = mk_node("PatTup", 1, $2); }
| '[' pat_vec ']'                                 { $$ = mk_node("PatVec", 1, $2); }
| lit_or_path
| lit_or_path DOTDOTDOT lit_or_path               { $$ = mk_node("PatRange", 2, $1, $3); }
| path_expr '{' pat_struct '}'                    { $$ = mk_node("PatStruct", 2, $1, $3); }
| path_expr '(' ')'                               { $$ = mk_node("PatEnum", 2, $1, mk_none()); }
| path_expr '(' pat_tup ')'                       { $$ = mk_node("PatEnum", 2, $1, $3); }
| path_expr '!' maybe_ident delimited_token_trees { $$ = mk_node("PatMac", 3, $1, $3, $4); }
| binding_mode ident                              { $$ = mk_node("PatIdent", 2, $1, $2); }
|              ident '@' pat                      { $$ = mk_node("PatIdent", 3, mk_node("BindByValue", 1, mk_atom("MutImmutable")), $1, $3); }
| binding_mode ident '@' pat                      { $$ = mk_node("PatIdent", 3, $1, $2, $4); }
| BOX pat                                         { $$ = mk_node("PatUniq", 1, $2); }
| '<' ty_sum maybe_as_trait_ref '>' MOD_SEP ident { $$ = mk_node("PatQualifiedPath", 3, $2, $3, $6); }
| SHL ty_sum maybe_as_trait_ref '>' MOD_SEP ident maybe_as_trait_ref '>' MOD_SEP ident
{
  $$ = mk_node("PatQualifiedPath", 3, mk_node("PatQualifiedPath", 3, $2, $3, $6), $7, $10);
}
;

pats_or
: pat              { $$ = mk_node("Pats", 1, $1); }
| pats_or '|' pat  { $$ = ext_node($1, 1, $3); }
;

binding_mode
: REF         { $$ = mk_node("BindByRef", 1, mk_atom("MutImmutable")); }
| REF MUT     { $$ = mk_node("BindByRef", 1, mk_atom("MutMutable")); }
| MUT         { $$ = mk_node("BindByValue", 1, mk_atom("MutMutable")); }
;

lit_or_path
: path_expr    { $$ = mk_node("PatLit", 1, $1); }
| lit          { $$ = mk_node("PatLit", 1, $1); }
| '-' lit      { $$ = mk_node("PatLit", 1, $2); }
;

pat_field
:                  ident        { $$ = mk_node("PatField", 1, $1); }
|     binding_mode ident        { $$ = mk_node("PatField", 2, $1, $2); }
| BOX              ident        { $$ = mk_node("PatField", 2, mk_atom("box"), $2); }
| BOX binding_mode ident        { $$ = mk_node("PatField", 3, mk_atom("box"), $2, $3); }
|              ident ':' pat    { $$ = mk_node("PatField", 2, $1, $3); }
| binding_mode ident ':' pat    { $$ = mk_node("PatField", 3, $1, $2, $4); }
|        LIT_INTEGER ':' pat    { $$ = mk_node("PatField", 2, mk_atom(yytext), $3); }
;

pat_fields
: pat_field                  { $$ = mk_node("PatFields", 1, $1); }
| pat_fields ',' pat_field   { $$ = ext_node($1, 1, $3); }
;

pat_struct
: pat_fields                 { $$ = mk_node("PatStruct", 2, $1, mk_atom("false")); }
| pat_fields ','             { $$ = mk_node("PatStruct", 2, $1, mk_atom("false")); }
| pat_fields ',' DOTDOT      { $$ = mk_node("PatStruct", 2, $1, mk_atom("true")); }
| DOTDOT                     { $$ = mk_node("PatStruct", 1, mk_atom("true")); }
| %empty                     { $$ = mk_node("PatStruct", 1, mk_none()); }
;

pat_tup
: pat_tup_elts                                  { $$ = mk_node("PatTup", 2, $1, mk_none()); }
| pat_tup_elts                             ','  { $$ = mk_node("PatTup", 2, $1, mk_none()); }
| pat_tup_elts     DOTDOT                       { $$ = mk_node("PatTup", 2, $1, mk_none()); }
| pat_tup_elts ',' DOTDOT                       { $$ = mk_node("PatTup", 2, $1, mk_none()); }
| pat_tup_elts     DOTDOT ',' pat_tup_elts      { $$ = mk_node("PatTup", 2, $1, $4); }
| pat_tup_elts     DOTDOT ',' pat_tup_elts ','  { $$ = mk_node("PatTup", 2, $1, $4); }
| pat_tup_elts ',' DOTDOT ',' pat_tup_elts      { $$ = mk_node("PatTup", 2, $1, $5); }
| pat_tup_elts ',' DOTDOT ',' pat_tup_elts ','  { $$ = mk_node("PatTup", 2, $1, $5); }
|                  DOTDOT ',' pat_tup_elts      { $$ = mk_node("PatTup", 2, mk_none(), $3); }
|                  DOTDOT ',' pat_tup_elts ','  { $$ = mk_node("PatTup", 2, mk_none(), $3); }
|                  DOTDOT                       { $$ = mk_node("PatTup", 2, mk_none(), mk_none()); }
;

pat_tup_elts
: pat                    { $$ = mk_node("PatTupElts", 1, $1); }
| pat_tup_elts ',' pat   { $$ = ext_node($1, 1, $3); }
;

pat_vec
: pat_vec_elts                                  { $$ = mk_node("PatVec", 2, $1, mk_none()); }
| pat_vec_elts                             ','  { $$ = mk_node("PatVec", 2, $1, mk_none()); }
| pat_vec_elts     DOTDOT                       { $$ = mk_node("PatVec", 2, $1, mk_none()); }
| pat_vec_elts ',' DOTDOT                       { $$ = mk_node("PatVec", 2, $1, mk_none()); }
| pat_vec_elts     DOTDOT ',' pat_vec_elts      { $$ = mk_node("PatVec", 2, $1, $4); }
| pat_vec_elts     DOTDOT ',' pat_vec_elts ','  { $$ = mk_node("PatVec", 2, $1, $4); }
| pat_vec_elts ',' DOTDOT ',' pat_vec_elts      { $$ = mk_node("PatVec", 2, $1, $5); }
| pat_vec_elts ',' DOTDOT ',' pat_vec_elts ','  { $$ = mk_node("PatVec", 2, $1, $5); }
|                  DOTDOT ',' pat_vec_elts      { $$ = mk_node("PatVec", 2, mk_none(), $3); }
|                  DOTDOT ',' pat_vec_elts ','  { $$ = mk_node("PatVec", 2, mk_none(), $3); }
|                  DOTDOT                       { $$ = mk_node("PatVec", 2, mk_none(), mk_none()); }
| %empty                                        { $$ = mk_node("PatVec", 2, mk_none(), mk_none()); }
;

pat_vec_elts
: pat                    { $$ = mk_node("PatVecElts", 1, $1); }
| pat_vec_elts ',' pat   { $$ = ext_node($1, 1, $3); }
;

////////////////////////////////////////////////////////////////////////
// Part 3: Types
////////////////////////////////////////////////////////////////////////

ty
: ty_prim
| ty_closure
| '<' ty_sum maybe_as_trait_ref '>' MOD_SEP ident                                      { $$ = mk_node("TyQualifiedPath", 3, $2, $3, $6); }
| SHL ty_sum maybe_as_trait_ref '>' MOD_SEP ident maybe_as_trait_ref '>' MOD_SEP ident { $$ = mk_node("TyQualifiedPath", 3, mk_node("TyQualifiedPath", 3, $2, $3, $6), $7, $10); }
| '(' ty_sums ')'                                                                      { $$ = mk_node("TyTup", 1, $2); }
| '(' ty_sums ',' ')'                                                                  { $$ = mk_node("TyTup", 1, $2); }
| '(' ')'                                                                              { $$ = mk_atom("TyNil"); }
;

ty_prim
: %prec IDENT path_generic_args_without_colons                                               { $$ = mk_node("TyPath", 2, mk_node("global", 1, mk_atom("false")), $1); }
| %prec IDENT MOD_SEP path_generic_args_without_colons                                       { $$ = mk_node("TyPath", 2, mk_node("global", 1, mk_atom("true")), $2); }
| %prec IDENT SELF MOD_SEP path_generic_args_without_colons                                  { $$ = mk_node("TyPath", 2, mk_node("self", 1, mk_atom("true")), $3); }
| %prec IDENT path_generic_args_without_colons '!' maybe_ident delimited_token_trees         { $$ = mk_node("TyMacro", 3, $1, $3, $4); }
| %prec IDENT MOD_SEP path_generic_args_without_colons '!' maybe_ident delimited_token_trees { $$ = mk_node("TyMacro", 3, $2, $4, $5); }
| BOX ty                                                                                     { $$ = mk_node("TyBox", 1, $2); }
| '*' maybe_mut_or_const ty                                                                  { $$ = mk_node("TyPtr", 2, $2, $3); }
| '&' ty                                                                                     { $$ = mk_node("TyRptr", 2, mk_atom("MutImmutable"), $2); }
| '&' MUT ty                                                                                 { $$ = mk_node("TyRptr", 2, mk_atom("MutMutable"), $3); }
| ANDAND ty                                                                                  { $$ = mk_node("TyRptr", 1, mk_node("TyRptr", 2, mk_atom("MutImmutable"), $2)); }
| ANDAND MUT ty                                                                              { $$ = mk_node("TyRptr", 1, mk_node("TyRptr", 2, mk_atom("MutMutable"), $3)); }
| '&' lifetime maybe_mut ty                                                                  { $$ = mk_node("TyRptr", 3, $2, $3, $4); }
| ANDAND lifetime maybe_mut ty                                                               { $$ = mk_node("TyRptr", 1, mk_node("TyRptr", 3, $2, $3, $4)); }
| '[' ty ']'                                                                                 { $$ = mk_node("TyVec", 1, $2); }
| '[' ty ',' DOTDOT expr ']'                                                                 { $$ = mk_node("TyFixedLengthVec", 2, $2, $5); }
| '[' ty ';' expr ']'                                                                        { $$ = mk_node("TyFixedLengthVec", 2, $2, $4); }
| TYPEOF '(' expr ')'                                                                        { $$ = mk_node("TyTypeof", 1, $3); }
| UNDERSCORE                                                                                 { $$ = mk_atom("TyInfer"); }
| ty_bare_fn
| for_in_type
;

ty_bare_fn
:                         FN ty_fn_decl { $$ = $2; }
| UNSAFE                  FN ty_fn_decl { $$ = $3; }
|        EXTERN maybe_abi FN ty_fn_decl { $$ = $4; }
| UNSAFE EXTERN maybe_abi FN ty_fn_decl { $$ = $5; }
;

ty_fn_decl
: generic_params fn_anon_params ret_ty { $$ = mk_node("TyFnDecl", 3, $1, $2, $3); }
;

ty_closure
: UNSAFE '|' anon_params '|' maybe_bounds ret_ty { $$ = mk_node("TyClosure", 3, $3, $5, $6); }
|        '|' anon_params '|' maybe_bounds ret_ty { $$ = mk_node("TyClosure", 3, $2, $4, $5); }
| UNSAFE OROR maybe_bounds ret_ty                { $$ = mk_node("TyClosure", 2, $3, $4); }
|        OROR maybe_bounds ret_ty                { $$ = mk_node("TyClosure", 2, $2, $3); }
;

for_in_type
: FOR '<' maybe_lifetimes '>' for_in_type_suffix { $$ = mk_node("ForInType", 2, $3, $5); }
;

for_in_type_suffix
: ty_bare_fn
| trait_ref
| ty_closure
;

maybe_mut
: MUT              { $$ = mk_atom("MutMutable"); }
| %prec MUT %empty { $$ = mk_atom("MutImmutable"); }
;

maybe_mut_or_const
: MUT    { $$ = mk_atom("MutMutable"); }
| CONST  { $$ = mk_atom("MutImmutable"); }
| %empty { $$ = mk_atom("MutImmutable"); }
;

ty_qualified_path_and_generic_values
: ty_qualified_path maybe_bindings
{
  $$ = mk_node("GenericValues", 3, mk_none(), mk_node("TySums", 1, mk_node("TySum", 1, $1)), $2);
}
| ty_qualified_path ',' ty_sums maybe_bindings
{
  $$ = mk_node("GenericValues", 3, mk_none(), mk_node("TySums", 2, $1, $3), $4);
}
;

ty_qualified_path
: ty_sum AS trait_ref '>' MOD_SEP ident                     { $$ = mk_node("TyQualifiedPath", 3, $1, $3, $6); }
| ty_sum AS trait_ref '>' MOD_SEP ident '+' ty_param_bounds { $$ = mk_node("TyQualifiedPath", 3, $1, $3, $6); }
;

maybe_ty_sums
: ty_sums
| ty_sums ','
| %empty { $$ = mk_none(); }
;

ty_sums
: ty_sum             { $$ = mk_node("TySums", 1, $1); }
| ty_sums ',' ty_sum { $$ = ext_node($1, 1, $3); }
;

ty_sum
: ty_sum_elt            { $$ = mk_node("TySum", 1, $1); }
| ty_sum '+' ty_sum_elt { $$ = ext_node($1, 1, $3); }
;

ty_sum_elt
: ty
| lifetime
;

ty_prim_sum
: ty_prim_sum_elt                 { $$ = mk_node("TySum", 1, $1); }
| ty_prim_sum '+' ty_prim_sum_elt { $$ = ext_node($1, 1, $3); }
;

ty_prim_sum_elt
: ty_prim
| lifetime
;

maybe_ty_param_bounds
: ':' ty_param_bounds { $$ = $2; }
| %empty              { $$ = mk_none(); }
;

ty_param_bounds
: boundseq
| %empty { $$ = mk_none(); }
;

boundseq
: polybound
| boundseq '+' polybound { $$ = ext_node($1, 1, $3); }
;

polybound
: FOR '<' maybe_lifetimes '>' bound { $$ = mk_node("PolyBound", 2, $3, $5); }
| bound
| '?' FOR '<' maybe_lifetimes '>' bound { $$ = mk_node("PolyBound", 2, $4, $6); }
| '?' bound { $$ = $2; }
;

bindings
: binding              { $$ = mk_node("Bindings", 1, $1); }
| bindings ',' binding { $$ = ext_node($1, 1, $3); }
;

binding
: ident '=' ty { mk_node("Binding", 2, $1, $3); }
;

ty_param
: ident maybe_ty_param_bounds maybe_ty_default           { $$ = mk_node("TyParam", 3, $1, $2, $3); }
| ident '?' ident maybe_ty_param_bounds maybe_ty_default { $$ = mk_node("TyParam", 4, $1, $3, $4, $5); }
;

maybe_bounds
: %prec SHIFTPLUS
  ':' bounds             { $$ = $2; }
| %prec SHIFTPLUS %empty { $$ = mk_none(); }
;

bounds
: bound            { $$ = mk_node("bounds", 1, $1); }
| bounds '+' bound { $$ = ext_node($1, 1, $3); }
;

bound
: lifetime
| trait_ref
;

maybe_ltbounds
: %prec SHIFTPLUS
  ':' ltbounds       { $$ = $2; }
| %empty             { $$ = mk_none(); }
;

ltbounds
: lifetime              { $$ = mk_node("ltbounds", 1, $1); }
| ltbounds '+' lifetime { $$ = ext_node($1, 1, $3); }
;

maybe_ty_default
: '=' ty_sum { $$ = mk_node("TyDefault", 1, $2); }
| %empty     { $$ = mk_none(); }
;

maybe_lifetimes
: lifetimes
| lifetimes ','
| %empty { $$ = mk_none(); }
;

lifetimes
: lifetime_and_bounds               { $$ = mk_node("Lifetimes", 1, $1); }
| lifetimes ',' lifetime_and_bounds { $$ = ext_node($1, 1, $3); }
;

lifetime_and_bounds
: LIFETIME maybe_ltbounds         { $$ = mk_node("lifetime", 2, mk_atom(yytext), $2); }
| STATIC_LIFETIME                 { $$ = mk_atom("static_lifetime"); }
;

lifetime
: LIFETIME         { $$ = mk_node("lifetime", 1, mk_atom(yytext)); }
| STATIC_LIFETIME  { $$ = mk_atom("static_lifetime"); }
;

trait_ref
: %prec IDENT path_generic_args_without_colons
| %prec IDENT MOD_SEP path_generic_args_without_colons { $$ = $2; }
;

////////////////////////////////////////////////////////////////////////
// Part 4: Blocks, statements, and expressions
////////////////////////////////////////////////////////////////////////

inner_attrs_and_block
: '{' maybe_inner_attrs maybe_stmts '}'        { $$ = mk_node("ExprBlock", 2, $2, $3); }
;

block
: '{' maybe_stmts '}'                          { $$ = mk_node("ExprBlock", 1, $2); }
;

maybe_stmts
: stmts
| stmts nonblock_expr { $$ = ext_node($1, 1, $2); }
| nonblock_expr
| %empty              { $$ = mk_none(); }
;

// There are two sub-grammars within a "stmts: exprs" derivation
// depending on whether each stmt-expr is a block-expr form; this is to
// handle the "semicolon rule" for stmt sequencing that permits
// writing
//
//     if foo { bar } 10
//
// as a sequence of two stmts (one if-expr stmt, one lit-10-expr
// stmt). Unfortunately by permitting juxtaposition of exprs in
// sequence like that, the non-block expr grammar has to have a
// second limited sub-grammar that excludes the prefix exprs that
// are ambiguous with binops. That is to say:
//
//     {10} - 1
//
// should parse as (progn (progn 10) (- 1)) not (- (progn 10) 1), that
// is to say, two statements rather than one, at least according to
// the mainline rust parser.
//
// So we wind up with a 3-way split in exprs that occur in stmt lists:
// block, nonblock-prefix, and nonblock-nonprefix.
//
// In non-stmts contexts, expr can relax this trichotomy.

stmts
: stmt           { $$ = mk_node("stmts", 1, $1); }
| stmts stmt     { $$ = ext_node($1, 1, $2); }
;

stmt
: maybe_outer_attrs let     { $$ = $2; }
|                 stmt_item
|             PUB stmt_item { $$ = $2; }
| outer_attrs     stmt_item { $$ = $2; }
| outer_attrs PUB stmt_item { $$ = $3; }
| full_block_expr
| maybe_outer_attrs block   { $$ = $2; }
|             nonblock_expr ';'
| outer_attrs nonblock_expr ';' { $$ = $2; }
| ';'                   { $$ = mk_none(); }
;

maybe_exprs
: exprs
| exprs ','
| %empty { $$ = mk_none(); }
;

maybe_expr
: expr
| %empty { $$ = mk_none(); }
;

exprs
: expr                                                        { $$ = mk_node("exprs", 1, $1); }
| exprs ',' expr                                              { $$ = ext_node($1, 1, $3); }
;

path_expr
: path_generic_args_with_colons
| MOD_SEP path_generic_args_with_colons      { $$ = $2; }
| SELF MOD_SEP path_generic_args_with_colons { $$ = mk_node("SelfPath", 1, $3); }
;

// A path with a lifetime and type parameters with double colons before
// the type parameters; e.g. `foo::bar::<'a>::Baz::<T>`
//
// These show up in expr context, in order to disambiguate from "less-than"
// expressions.
path_generic_args_with_colons
: ident                                              { $$ = mk_node("components", 1, $1); }
| SUPER                                              { $$ = mk_atom("Super"); }
| path_generic_args_with_colons MOD_SEP ident        { $$ = ext_node($1, 1, $3); }
| path_generic_args_with_colons MOD_SEP SUPER        { $$ = ext_node($1, 1, mk_atom("Super")); }
| path_generic_args_with_colons MOD_SEP generic_args { $$ = ext_node($1, 1, $3); }
;

// the braces-delimited macro is a block_expr so it doesn't appear here
macro_expr
: path_expr '!' maybe_ident parens_delimited_token_trees   { $$ = mk_node("MacroExpr", 3, $1, $3, $4); }
| path_expr '!' maybe_ident brackets_delimited_token_trees { $$ = mk_node("MacroExpr", 3, $1, $3, $4); }
;

nonblock_expr
: lit                                                           { $$ = mk_node("ExprLit", 1, $1); }
| %prec IDENT
  path_expr                                                     { $$ = mk_node("ExprPath", 1, $1); }
| SELF                                                          { $$ = mk_node("ExprPath", 1, mk_node("ident", 1, mk_atom("self"))); }
| macro_expr                                                    { $$ = mk_node("ExprMac", 1, $1); }
| path_expr '{' struct_expr_fields '}'                          { $$ = mk_node("ExprStruct", 2, $1, $3); }
| nonblock_expr '?'                                             { $$ = mk_node("ExprTry", 1, $1); }
| nonblock_expr '.' path_generic_args_with_colons               { $$ = mk_node("ExprField", 2, $1, $3); }
| nonblock_expr '.' LIT_INTEGER                                 { $$ = mk_node("ExprTupleIndex", 1, $1); }
| nonblock_expr '[' maybe_expr ']'                              { $$ = mk_node("ExprIndex", 2, $1, $3); }
| nonblock_expr '(' maybe_exprs ')'                             { $$ = mk_node("ExprCall", 2, $1, $3); }
| '[' vec_expr ']'                                              { $$ = mk_node("ExprVec", 1, $2); }
| '(' maybe_exprs ')'                                           { $$ = mk_node("ExprParen", 1, $2); }
| CONTINUE                                                      { $$ = mk_node("ExprAgain", 0); }
| CONTINUE lifetime                                             { $$ = mk_node("ExprAgain", 1, $2); }
| RETURN                                                        { $$ = mk_node("ExprRet", 0); }
| RETURN expr                                                   { $$ = mk_node("ExprRet", 1, $2); }
| BREAK                                                         { $$ = mk_node("ExprBreak", 0); }
| BREAK lifetime                                                { $$ = mk_node("ExprBreak", 1, $2); }
| YIELD                                                         { $$ = mk_node("ExprYield", 0); }
| YIELD expr                                                    { $$ = mk_node("ExprYield", 1, $2); }
| nonblock_expr '=' expr                                        { $$ = mk_node("ExprAssign", 2, $1, $3); }
| nonblock_expr SHLEQ expr                                      { $$ = mk_node("ExprAssignShl", 2, $1, $3); }
| nonblock_expr SHREQ expr                                      { $$ = mk_node("ExprAssignShr", 2, $1, $3); }
| nonblock_expr MINUSEQ expr                                    { $$ = mk_node("ExprAssignSub", 2, $1, $3); }
| nonblock_expr ANDEQ expr                                      { $$ = mk_node("ExprAssignBitAnd", 2, $1, $3); }
| nonblock_expr OREQ expr                                       { $$ = mk_node("ExprAssignBitOr", 2, $1, $3); }
| nonblock_expr PLUSEQ expr                                     { $$ = mk_node("ExprAssignAdd", 2, $1, $3); }
| nonblock_expr STAREQ expr                                     { $$ = mk_node("ExprAssignMul", 2, $1, $3); }
| nonblock_expr SLASHEQ expr                                    { $$ = mk_node("ExprAssignDiv", 2, $1, $3); }
| nonblock_expr CARETEQ expr                                    { $$ = mk_node("ExprAssignBitXor", 2, $1, $3); }
| nonblock_expr PERCENTEQ expr                                  { $$ = mk_node("ExprAssignRem", 2, $1, $3); }
| nonblock_expr OROR expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiOr"), $1, $3); }
| nonblock_expr ANDAND expr                                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiAnd"), $1, $3); }
| nonblock_expr EQEQ expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiEq"), $1, $3); }
| nonblock_expr NE expr                                         { $$ = mk_node("ExprBinary", 3, mk_atom("BiNe"), $1, $3); }
| nonblock_expr '<' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiLt"), $1, $3); }
| nonblock_expr '>' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiGt"), $1, $3); }
| nonblock_expr LE expr                                         { $$ = mk_node("ExprBinary", 3, mk_atom("BiLe"), $1, $3); }
| nonblock_expr GE expr                                         { $$ = mk_node("ExprBinary", 3, mk_atom("BiGe"), $1, $3); }
| nonblock_expr '|' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitOr"), $1, $3); }
| nonblock_expr '^' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitXor"), $1, $3); }
| nonblock_expr '&' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitAnd"), $1, $3); }
| nonblock_expr SHL expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiShl"), $1, $3); }
| nonblock_expr SHR expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiShr"), $1, $3); }
| nonblock_expr '+' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiAdd"), $1, $3); }
| nonblock_expr '-' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiSub"), $1, $3); }
| nonblock_expr '*' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiMul"), $1, $3); }
| nonblock_expr '/' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiDiv"), $1, $3); }
| nonblock_expr '%' expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiRem"), $1, $3); }
| nonblock_expr DOTDOT                                          { $$ = mk_node("ExprRange", 2, $1, mk_none()); }
| nonblock_expr DOTDOT expr                                     { $$ = mk_node("ExprRange", 2, $1, $3); }
|               DOTDOT expr                                     { $$ = mk_node("ExprRange", 2, mk_none(), $2); }
|               DOTDOT                                          { $$ = mk_node("ExprRange", 2, mk_none(), mk_none()); }
| nonblock_expr AS ty                                           { $$ = mk_node("ExprCast", 2, $1, $3); }
| nonblock_expr ':' ty                                          { $$ = mk_node("ExprTypeAscr", 2, $1, $3); }
| BOX expr                                                      { $$ = mk_node("ExprBox", 1, $2); }
| expr_qualified_path
| nonblock_prefix_expr
;

expr
: lit                                                 { $$ = mk_node("ExprLit", 1, $1); }
| %prec IDENT
  path_expr                                           { $$ = mk_node("ExprPath", 1, $1); }
| SELF                                                { $$ = mk_node("ExprPath", 1, mk_node("ident", 1, mk_atom("self"))); }
| macro_expr                                          { $$ = mk_node("ExprMac", 1, $1); }
| path_expr '{' struct_expr_fields '}'                { $$ = mk_node("ExprStruct", 2, $1, $3); }
| expr '?'                                            { $$ = mk_node("ExprTry", 1, $1); }
| expr '.' path_generic_args_with_colons              { $$ = mk_node("ExprField", 2, $1, $3); }
| expr '.' LIT_INTEGER                                { $$ = mk_node("ExprTupleIndex", 1, $1); }
| expr '[' maybe_expr ']'                             { $$ = mk_node("ExprIndex", 2, $1, $3); }
| expr '(' maybe_exprs ')'                            { $$ = mk_node("ExprCall", 2, $1, $3); }
| '(' maybe_exprs ')'                                 { $$ = mk_node("ExprParen", 1, $2); }
| '[' vec_expr ']'                                    { $$ = mk_node("ExprVec", 1, $2); }
| CONTINUE                                            { $$ = mk_node("ExprAgain", 0); }
| CONTINUE ident                                      { $$ = mk_node("ExprAgain", 1, $2); }
| RETURN                                              { $$ = mk_node("ExprRet", 0); }
| RETURN expr                                         { $$ = mk_node("ExprRet", 1, $2); }
| BREAK                                               { $$ = mk_node("ExprBreak", 0); }
| BREAK ident                                         { $$ = mk_node("ExprBreak", 1, $2); }
| YIELD                                               { $$ = mk_node("ExprYield", 0); }
| YIELD expr                                          { $$ = mk_node("ExprYield", 1, $2); }
| expr '=' expr                                       { $$ = mk_node("ExprAssign", 2, $1, $3); }
| expr SHLEQ expr                                     { $$ = mk_node("ExprAssignShl", 2, $1, $3); }
| expr SHREQ expr                                     { $$ = mk_node("ExprAssignShr", 2, $1, $3); }
| expr MINUSEQ expr                                   { $$ = mk_node("ExprAssignSub", 2, $1, $3); }
| expr ANDEQ expr                                     { $$ = mk_node("ExprAssignBitAnd", 2, $1, $3); }
| expr OREQ expr                                      { $$ = mk_node("ExprAssignBitOr", 2, $1, $3); }
| expr PLUSEQ expr                                    { $$ = mk_node("ExprAssignAdd", 2, $1, $3); }
| expr STAREQ expr                                    { $$ = mk_node("ExprAssignMul", 2, $1, $3); }
| expr SLASHEQ expr                                   { $$ = mk_node("ExprAssignDiv", 2, $1, $3); }
| expr CARETEQ expr                                   { $$ = mk_node("ExprAssignBitXor", 2, $1, $3); }
| expr PERCENTEQ expr                                 { $$ = mk_node("ExprAssignRem", 2, $1, $3); }
| expr OROR expr                                      { $$ = mk_node("ExprBinary", 3, mk_atom("BiOr"), $1, $3); }
| expr ANDAND expr                                    { $$ = mk_node("ExprBinary", 3, mk_atom("BiAnd"), $1, $3); }
| expr EQEQ expr                                      { $$ = mk_node("ExprBinary", 3, mk_atom("BiEq"), $1, $3); }
| expr NE expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiNe"), $1, $3); }
| expr '<' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiLt"), $1, $3); }
| expr '>' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiGt"), $1, $3); }
| expr LE expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiLe"), $1, $3); }
| expr GE expr                                        { $$ = mk_node("ExprBinary", 3, mk_atom("BiGe"), $1, $3); }
| expr '|' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitOr"), $1, $3); }
| expr '^' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitXor"), $1, $3); }
| expr '&' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitAnd"), $1, $3); }
| expr SHL expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiShl"), $1, $3); }
| expr SHR expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiShr"), $1, $3); }
| expr '+' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiAdd"), $1, $3); }
| expr '-' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiSub"), $1, $3); }
| expr '*' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiMul"), $1, $3); }
| expr '/' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiDiv"), $1, $3); }
| expr '%' expr                                       { $$ = mk_node("ExprBinary", 3, mk_atom("BiRem"), $1, $3); }
| expr DOTDOT                                         { $$ = mk_node("ExprRange", 2, $1, mk_none()); }
| expr DOTDOT expr                                    { $$ = mk_node("ExprRange", 2, $1, $3); }
|      DOTDOT expr                                    { $$ = mk_node("ExprRange", 2, mk_none(), $2); }
|      DOTDOT                                         { $$ = mk_node("ExprRange", 2, mk_none(), mk_none()); }
| expr AS ty                                          { $$ = mk_node("ExprCast", 2, $1, $3); }
| expr ':' ty                                         { $$ = mk_node("ExprTypeAscr", 2, $1, $3); }
| BOX expr                                            { $$ = mk_node("ExprBox", 1, $2); }
| expr_qualified_path
| block_expr
| block
| nonblock_prefix_expr
;

expr_nostruct
: lit                                                 { $$ = mk_node("ExprLit", 1, $1); }
| %prec IDENT
  path_expr                                           { $$ = mk_node("ExprPath", 1, $1); }
| SELF                                                { $$ = mk_node("ExprPath", 1, mk_node("ident", 1, mk_atom("self"))); }
| macro_expr                                          { $$ = mk_node("ExprMac", 1, $1); }
| expr_nostruct '?'                                   { $$ = mk_node("ExprTry", 1, $1); }
| expr_nostruct '.' path_generic_args_with_colons     { $$ = mk_node("ExprField", 2, $1, $3); }
| expr_nostruct '.' LIT_INTEGER                       { $$ = mk_node("ExprTupleIndex", 1, $1); }
| expr_nostruct '[' maybe_expr ']'                    { $$ = mk_node("ExprIndex", 2, $1, $3); }
| expr_nostruct '(' maybe_exprs ')'                   { $$ = mk_node("ExprCall", 2, $1, $3); }
| '[' vec_expr ']'                                    { $$ = mk_node("ExprVec", 1, $2); }
| '(' maybe_exprs ')'                                 { $$ = mk_node("ExprParen", 1, $2); }
| CONTINUE                                            { $$ = mk_node("ExprAgain", 0); }
| CONTINUE ident                                      { $$ = mk_node("ExprAgain", 1, $2); }
| RETURN                                              { $$ = mk_node("ExprRet", 0); }
| RETURN expr                                         { $$ = mk_node("ExprRet", 1, $2); }
| BREAK                                               { $$ = mk_node("ExprBreak", 0); }
| BREAK ident                                         { $$ = mk_node("ExprBreak", 1, $2); }
| YIELD                                               { $$ = mk_node("ExprYield", 0); }
| YIELD expr                                          { $$ = mk_node("ExprYield", 1, $2); }
| expr_nostruct '=' expr_nostruct                     { $$ = mk_node("ExprAssign", 2, $1, $3); }
| expr_nostruct SHLEQ expr_nostruct                   { $$ = mk_node("ExprAssignShl", 2, $1, $3); }
| expr_nostruct SHREQ expr_nostruct                   { $$ = mk_node("ExprAssignShr", 2, $1, $3); }
| expr_nostruct MINUSEQ expr_nostruct                 { $$ = mk_node("ExprAssignSub", 2, $1, $3); }
| expr_nostruct ANDEQ expr_nostruct                   { $$ = mk_node("ExprAssignBitAnd", 2, $1, $3); }
| expr_nostruct OREQ expr_nostruct                    { $$ = mk_node("ExprAssignBitOr", 2, $1, $3); }
| expr_nostruct PLUSEQ expr_nostruct                  { $$ = mk_node("ExprAssignAdd", 2, $1, $3); }
| expr_nostruct STAREQ expr_nostruct                  { $$ = mk_node("ExprAssignMul", 2, $1, $3); }
| expr_nostruct SLASHEQ expr_nostruct                 { $$ = mk_node("ExprAssignDiv", 2, $1, $3); }
| expr_nostruct CARETEQ expr_nostruct                 { $$ = mk_node("ExprAssignBitXor", 2, $1, $3); }
| expr_nostruct PERCENTEQ expr_nostruct               { $$ = mk_node("ExprAssignRem", 2, $1, $3); }
| expr_nostruct OROR expr_nostruct                    { $$ = mk_node("ExprBinary", 3, mk_atom("BiOr"), $1, $3); }
| expr_nostruct ANDAND expr_nostruct                  { $$ = mk_node("ExprBinary", 3, mk_atom("BiAnd"), $1, $3); }
| expr_nostruct EQEQ expr_nostruct                    { $$ = mk_node("ExprBinary", 3, mk_atom("BiEq"), $1, $3); }
| expr_nostruct NE expr_nostruct                      { $$ = mk_node("ExprBinary", 3, mk_atom("BiNe"), $1, $3); }
| expr_nostruct '<' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiLt"), $1, $3); }
| expr_nostruct '>' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiGt"), $1, $3); }
| expr_nostruct LE expr_nostruct                      { $$ = mk_node("ExprBinary", 3, mk_atom("BiLe"), $1, $3); }
| expr_nostruct GE expr_nostruct                      { $$ = mk_node("ExprBinary", 3, mk_atom("BiGe"), $1, $3); }
| expr_nostruct '|' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitOr"), $1, $3); }
| expr_nostruct '^' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitXor"), $1, $3); }
| expr_nostruct '&' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiBitAnd"), $1, $3); }
| expr_nostruct SHL expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiShl"), $1, $3); }
| expr_nostruct SHR expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiShr"), $1, $3); }
| expr_nostruct '+' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiAdd"), $1, $3); }
| expr_nostruct '-' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiSub"), $1, $3); }
| expr_nostruct '*' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiMul"), $1, $3); }
| expr_nostruct '/' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiDiv"), $1, $3); }
| expr_nostruct '%' expr_nostruct                     { $$ = mk_node("ExprBinary", 3, mk_atom("BiRem"), $1, $3); }
| expr_nostruct DOTDOT               %prec RANGE      { $$ = mk_node("ExprRange", 2, $1, mk_none()); }
| expr_nostruct DOTDOT expr_nostruct                  { $$ = mk_node("ExprRange", 2, $1, $3); }
|               DOTDOT expr_nostruct                  { $$ = mk_node("ExprRange", 2, mk_none(), $2); }
|               DOTDOT                                { $$ = mk_node("ExprRange", 2, mk_none(), mk_none()); }
| expr_nostruct AS ty                                 { $$ = mk_node("ExprCast", 2, $1, $3); }
| expr_nostruct ':' ty                                { $$ = mk_node("ExprTypeAscr", 2, $1, $3); }
| BOX expr                                            { $$ = mk_node("ExprBox", 1, $2); }
| expr_qualified_path
| block_expr
| block
| nonblock_prefix_expr_nostruct
;

nonblock_prefix_expr_nostruct
: '-' expr_nostruct                         { $$ = mk_node("ExprUnary", 2, mk_atom("UnNeg"), $2); }
| '!' expr_nostruct                         { $$ = mk_node("ExprUnary", 2, mk_atom("UnNot"), $2); }
| '*' expr_nostruct                         { $$ = mk_node("ExprUnary", 2, mk_atom("UnDeref"), $2); }
| '&' maybe_mut expr_nostruct               { $$ = mk_node("ExprAddrOf", 2, $2, $3); }
| ANDAND maybe_mut expr_nostruct            { $$ = mk_node("ExprAddrOf", 1, mk_node("ExprAddrOf", 2, $2, $3)); }
| lambda_expr_nostruct
| MOVE lambda_expr_nostruct                 { $$ = $2; }
;

nonblock_prefix_expr
: '-' expr                         { $$ = mk_node("ExprUnary", 2, mk_atom("UnNeg"), $2); }
| '!' expr                         { $$ = mk_node("ExprUnary", 2, mk_atom("UnNot"), $2); }
| '*' expr                         { $$ = mk_node("ExprUnary", 2, mk_atom("UnDeref"), $2); }
| '&' maybe_mut expr               { $$ = mk_node("ExprAddrOf", 2, $2, $3); }
| ANDAND maybe_mut expr            { $$ = mk_node("ExprAddrOf", 1, mk_node("ExprAddrOf", 2, $2, $3)); }
| lambda_expr
| MOVE lambda_expr                 { $$ = $2; }
;

expr_qualified_path
: '<' ty_sum maybe_as_trait_ref '>' MOD_SEP ident maybe_qpath_params
{
  $$ = mk_node("ExprQualifiedPath", 4, $2, $3, $6, $7);
}
| SHL ty_sum maybe_as_trait_ref '>' MOD_SEP ident maybe_as_trait_ref '>' MOD_SEP ident
{
  $$ = mk_node("ExprQualifiedPath", 3, mk_node("ExprQualifiedPath", 3, $2, $3, $6), $7, $10);
}
| SHL ty_sum maybe_as_trait_ref '>' MOD_SEP ident generic_args maybe_as_trait_ref '>' MOD_SEP ident
{
  $$ = mk_node("ExprQualifiedPath", 3, mk_node("ExprQualifiedPath", 4, $2, $3, $6, $7), $8, $11);
}
| SHL ty_sum maybe_as_trait_ref '>' MOD_SEP ident maybe_as_trait_ref '>' MOD_SEP ident generic_args
{
  $$ = mk_node("ExprQualifiedPath", 4, mk_node("ExprQualifiedPath", 3, $2, $3, $6), $7, $10, $11);
}
| SHL ty_sum maybe_as_trait_ref '>' MOD_SEP ident generic_args maybe_as_trait_ref '>' MOD_SEP ident generic_args
{
  $$ = mk_node("ExprQualifiedPath", 4, mk_node("ExprQualifiedPath", 4, $2, $3, $6, $7), $8, $11, $12);
}

maybe_qpath_params
: MOD_SEP generic_args { $$ = $2; }
| %empty               { $$ = mk_none(); }
;

maybe_as_trait_ref
: AS trait_ref { $$ = $2; }
| %empty       { $$ = mk_none(); }
;

lambda_expr
: %prec LAMBDA
  OROR ret_ty expr                                    { $$ = mk_node("ExprFnBlock", 3, mk_none(), $2, $3); }
| %prec LAMBDA
  '|' '|' ret_ty expr                                 { $$ = mk_node("ExprFnBlock", 3, mk_none(), $3, $4); }
| %prec LAMBDA
  '|' inferrable_params '|' ret_ty expr               { $$ = mk_node("ExprFnBlock", 3, $2, $4, $5); }
| %prec LAMBDA
  '|' inferrable_params OROR lambda_expr_no_first_bar { $$ = mk_node("ExprFnBlock", 3, $2, mk_none(), $4); }
;

lambda_expr_no_first_bar
: %prec LAMBDA
  '|' ret_ty expr                                 { $$ = mk_node("ExprFnBlock", 3, mk_none(), $2, $3); }
| %prec LAMBDA
  inferrable_params '|' ret_ty expr               { $$ = mk_node("ExprFnBlock", 3, $1, $3, $4); }
| %prec LAMBDA
  inferrable_params OROR lambda_expr_no_first_bar { $$ = mk_node("ExprFnBlock", 3, $1, mk_none(), $3); }
;

lambda_expr_nostruct
: %prec LAMBDA
  OROR expr_nostruct                                           { $$ = mk_node("ExprFnBlock", 2, mk_none(), $2); }
| %prec LAMBDA
  '|' '|' ret_ty expr_nostruct                                 { $$ = mk_node("ExprFnBlock", 3, mk_none(), $3, $4); }
| %prec LAMBDA
  '|' inferrable_params '|' expr_nostruct                      { $$ = mk_node("ExprFnBlock", 2, $2, $4); }
| %prec LAMBDA
  '|' inferrable_params OROR lambda_expr_nostruct_no_first_bar { $$ = mk_node("ExprFnBlock", 3, $2, mk_none(), $4); }
;

lambda_expr_nostruct_no_first_bar
: %prec LAMBDA
  '|' ret_ty expr_nostruct                                 { $$ = mk_node("ExprFnBlock", 3, mk_none(), $2, $3); }
| %prec LAMBDA
  inferrable_params '|' ret_ty expr_nostruct               { $$ = mk_node("ExprFnBlock", 3, $1, $3, $4); }
| %prec LAMBDA
  inferrable_params OROR lambda_expr_nostruct_no_first_bar { $$ = mk_node("ExprFnBlock", 3, $1, mk_none(), $3); }
;

vec_expr
: maybe_exprs
| exprs ';' expr { $$ = mk_node("VecRepeat", 2, $1, $3); }
;

struct_expr_fields
: field_inits
| field_inits ','
| maybe_field_inits default_field_init { $$ = ext_node($1, 1, $2); }
| %empty                               { $$ = mk_none(); }
;

maybe_field_inits
: field_inits
| field_inits ','
| %empty { $$ = mk_none(); }
;

field_inits
: field_init                 { $$ = mk_node("FieldInits", 1, $1); }
| field_inits ',' field_init { $$ = ext_node($1, 1, $3); }
;

field_init
: ident                { $$ = mk_node("FieldInit", 1, $1); }
| ident ':' expr       { $$ = mk_node("FieldInit", 2, $1, $3); }
| LIT_INTEGER ':' expr { $$ = mk_node("FieldInit", 2, mk_atom(yytext), $3); }
;

default_field_init
: DOTDOT expr   { $$ = mk_node("DefaultFieldInit", 1, $2); }
;

block_expr
: expr_match
| expr_if
| expr_if_let
| expr_while
| expr_while_let
| expr_loop
| expr_for
| UNSAFE block                                           { $$ = mk_node("UnsafeBlock", 1, $2); }
| path_expr '!' maybe_ident braces_delimited_token_trees { $$ = mk_node("Macro", 3, $1, $3, $4); }
;

full_block_expr
: block_expr
| block_expr_dot
;

block_expr_dot
: block_expr     '.' path_generic_args_with_colons %prec IDENT         { $$ = mk_node("ExprField", 2, $1, $3); }
| block_expr_dot '.' path_generic_args_with_colons %prec IDENT         { $$ = mk_node("ExprField", 2, $1, $3); }
| block_expr     '.' path_generic_args_with_colons '[' maybe_expr ']'  { $$ = mk_node("ExprIndex", 3, $1, $3, $5); }
| block_expr_dot '.' path_generic_args_with_colons '[' maybe_expr ']'  { $$ = mk_node("ExprIndex", 3, $1, $3, $5); }
| block_expr     '.' path_generic_args_with_colons '(' maybe_exprs ')' { $$ = mk_node("ExprCall", 3, $1, $3, $5); }
| block_expr_dot '.' path_generic_args_with_colons '(' maybe_exprs ')' { $$ = mk_node("ExprCall", 3, $1, $3, $5); }
| block_expr     '.' LIT_INTEGER                                       { $$ = mk_node("ExprTupleIndex", 1, $1); }
| block_expr_dot '.' LIT_INTEGER                                       { $$ = mk_node("ExprTupleIndex", 1, $1); }
;

expr_match
: MATCH expr_nostruct '{' '}'                                     { $$ = mk_node("ExprMatch", 1, $2); }
| MATCH expr_nostruct '{' match_clauses                       '}' { $$ = mk_node("ExprMatch", 2, $2, $4); }
| MATCH expr_nostruct '{' match_clauses nonblock_match_clause '}' { $$ = mk_node("ExprMatch", 2, $2, ext_node($4, 1, $5)); }
| MATCH expr_nostruct '{'               nonblock_match_clause '}' { $$ = mk_node("ExprMatch", 2, $2, mk_node("Arms", 1, $4)); }
;

match_clauses
: match_clause               { $$ = mk_node("Arms", 1, $1); }
| match_clauses match_clause { $$ = ext_node($1, 1, $2); }
;

match_clause
: nonblock_match_clause ','
| block_match_clause
| block_match_clause ','
;

nonblock_match_clause
: maybe_outer_attrs pats_or maybe_guard FAT_ARROW nonblock_expr  { $$ = mk_node("ArmNonblock", 4, $1, $2, $3, $5); }
| maybe_outer_attrs pats_or maybe_guard FAT_ARROW block_expr_dot { $$ = mk_node("ArmNonblock", 4, $1, $2, $3, $5); }
;

block_match_clause
: maybe_outer_attrs pats_or maybe_guard FAT_ARROW block      { $$ = mk_node("ArmBlock", 4, $1, $2, $3, $5); }
| maybe_outer_attrs pats_or maybe_guard FAT_ARROW block_expr { $$ = mk_node("ArmBlock", 4, $1, $2, $3, $5); }
;

maybe_guard
: IF expr_nostruct           { $$ = $2; }
| %empty                     { $$ = mk_none(); }
;

expr_if
: IF expr_nostruct block                              { $$ = mk_node("ExprIf", 2, $2, $3); }
| IF expr_nostruct block ELSE block_or_if             { $$ = mk_node("ExprIf", 3, $2, $3, $5); }
;

expr_if_let
: IF LET pat '=' expr_nostruct block                  { $$ = mk_node("ExprIfLet", 3, $3, $5, $6); }
| IF LET pat '=' expr_nostruct block ELSE block_or_if { $$ = mk_node("ExprIfLet", 4, $3, $5, $6, $8); }
;

block_or_if
: block
| expr_if
| expr_if_let
;

expr_while
: maybe_label WHILE expr_nostruct block               { $$ = mk_node("ExprWhile", 3, $1, $3, $4); }
;

expr_while_let
: maybe_label WHILE LET pat '=' expr_nostruct block   { $$ = mk_node("ExprWhileLet", 4, $1, $4, $6, $7); }
;

expr_loop
: maybe_label LOOP block                              { $$ = mk_node("ExprLoop", 2, $1, $3); }
;

expr_for
: maybe_label FOR pat IN expr_nostruct block          { $$ = mk_node("ExprForLoop", 4, $1, $3, $5, $6); }
;

maybe_label
: lifetime ':'
| %empty { $$ = mk_none(); }
;

let
: LET pat maybe_ty_ascription maybe_init_expr ';' { $$ = mk_node("DeclLocal", 3, $2, $3, $4); }
;

////////////////////////////////////////////////////////////////////////
// Part 5: Macros and misc. rules
////////////////////////////////////////////////////////////////////////

lit
: LIT_BYTE                   { $$ = mk_node("LitByte", 1, mk_atom(yytext)); }
| LIT_CHAR                   { $$ = mk_node("LitChar", 1, mk_atom(yytext)); }
| LIT_INTEGER                { $$ = mk_node("LitInteger", 1, mk_atom(yytext)); }
| LIT_FLOAT                  { $$ = mk_node("LitFloat", 1, mk_atom(yytext)); }
| TRUE                       { $$ = mk_node("LitBool", 1, mk_atom(yytext)); }
| FALSE                      { $$ = mk_node("LitBool", 1, mk_atom(yytext)); }
| str
;

str
: LIT_STR                    { $$ = mk_node("LitStr", 1, mk_atom(yytext), mk_atom("CookedStr")); }
| LIT_STR_RAW                { $$ = mk_node("LitStr", 1, mk_atom(yytext), mk_atom("RawStr")); }
| LIT_BYTE_STR                 { $$ = mk_node("LitByteStr", 1, mk_atom(yytext), mk_atom("ByteStr")); }
| LIT_BYTE_STR_RAW             { $$ = mk_node("LitByteStr", 1, mk_atom(yytext), mk_atom("RawByteStr")); }
;

maybe_ident
: %empty { $$ = mk_none(); }
| ident
;

ident
: IDENT                      { $$ = mk_node("ident", 1, mk_atom(yytext)); }
// Weak keywords that can be used as identifiers
| CATCH                      { $$ = mk_node("ident", 1, mk_atom(yytext)); }
| DEFAULT                    { $$ = mk_node("ident", 1, mk_atom(yytext)); }
| UNION                      { $$ = mk_node("ident", 1, mk_atom(yytext)); }
;

unpaired_token
: SHL                        { $$ = mk_atom(yytext); }
| SHR                        { $$ = mk_atom(yytext); }
| LE                         { $$ = mk_atom(yytext); }
| EQEQ                       { $$ = mk_atom(yytext); }
| NE                         { $$ = mk_atom(yytext); }
| GE                         { $$ = mk_atom(yytext); }
| ANDAND                     { $$ = mk_atom(yytext); }
| OROR                       { $$ = mk_atom(yytext); }
| LARROW                     { $$ = mk_atom(yytext); }
| SHLEQ                      { $$ = mk_atom(yytext); }
| SHREQ                      { $$ = mk_atom(yytext); }
| MINUSEQ                    { $$ = mk_atom(yytext); }
| ANDEQ                      { $$ = mk_atom(yytext); }
| OREQ                       { $$ = mk_atom(yytext); }
| PLUSEQ                     { $$ = mk_atom(yytext); }
| STAREQ                     { $$ = mk_atom(yytext); }
| SLASHEQ                    { $$ = mk_atom(yytext); }
| CARETEQ                    { $$ = mk_atom(yytext); }
| PERCENTEQ                  { $$ = mk_atom(yytext); }
| DOTDOT                     { $$ = mk_atom(yytext); }
| DOTDOTDOT                  { $$ = mk_atom(yytext); }
| MOD_SEP                    { $$ = mk_atom(yytext); }
| RARROW                     { $$ = mk_atom(yytext); }
| FAT_ARROW                  { $$ = mk_atom(yytext); }
| LIT_BYTE                   { $$ = mk_atom(yytext); }
| LIT_CHAR                   { $$ = mk_atom(yytext); }
| LIT_INTEGER                { $$ = mk_atom(yytext); }
| LIT_FLOAT                  { $$ = mk_atom(yytext); }
| LIT_STR                    { $$ = mk_atom(yytext); }
| LIT_STR_RAW                { $$ = mk_atom(yytext); }
| LIT_BYTE_STR               { $$ = mk_atom(yytext); }
| LIT_BYTE_STR_RAW           { $$ = mk_atom(yytext); }
| IDENT                      { $$ = mk_atom(yytext); }
| UNDERSCORE                 { $$ = mk_atom(yytext); }
| LIFETIME                   { $$ = mk_atom(yytext); }
| SELF                       { $$ = mk_atom(yytext); }
| STATIC                     { $$ = mk_atom(yytext); }
| ABSTRACT                   { $$ = mk_atom(yytext); }
| ALIGNOF                    { $$ = mk_atom(yytext); }
| AS                         { $$ = mk_atom(yytext); }
| BECOME                     { $$ = mk_atom(yytext); }
| BREAK                      { $$ = mk_atom(yytext); }
| CATCH                      { $$ = mk_atom(yytext); }
| CRATE                      { $$ = mk_atom(yytext); }
| DEFAULT                    { $$ = mk_atom(yytext); }
| DO                         { $$ = mk_atom(yytext); }
| ELSE                       { $$ = mk_atom(yytext); }
| ENUM                       { $$ = mk_atom(yytext); }
| EXTERN                     { $$ = mk_atom(yytext); }
| FALSE                      { $$ = mk_atom(yytext); }
| FINAL                      { $$ = mk_atom(yytext); }
| FN                         { $$ = mk_atom(yytext); }
| FOR                        { $$ = mk_atom(yytext); }
| IF                         { $$ = mk_atom(yytext); }
| IMPL                       { $$ = mk_atom(yytext); }
| IN                         { $$ = mk_atom(yytext); }
| LET                        { $$ = mk_atom(yytext); }
| LOOP                       { $$ = mk_atom(yytext); }
| MACRO                      { $$ = mk_atom(yytext); }
| MATCH                      { $$ = mk_atom(yytext); }
| MOD                        { $$ = mk_atom(yytext); }
| MOVE                       { $$ = mk_atom(yytext); }
| MUT                        { $$ = mk_atom(yytext); }
| OFFSETOF                   { $$ = mk_atom(yytext); }
| OVERRIDE                   { $$ = mk_atom(yytext); }
| PRIV                       { $$ = mk_atom(yytext); }
| PUB                        { $$ = mk_atom(yytext); }
| PURE                       { $$ = mk_atom(yytext); }
| REF                        { $$ = mk_atom(yytext); }
| RETURN                     { $$ = mk_atom(yytext); }
| STRUCT                     { $$ = mk_atom(yytext); }
| SIZEOF                     { $$ = mk_atom(yytext); }
| SUPER                      { $$ = mk_atom(yytext); }
| TRUE                       { $$ = mk_atom(yytext); }
| TRAIT                      { $$ = mk_atom(yytext); }
| TYPE                       { $$ = mk_atom(yytext); }
| UNION                      { $$ = mk_atom(yytext); }
| UNSAFE                     { $$ = mk_atom(yytext); }
| UNSIZED                    { $$ = mk_atom(yytext); }
| USE                        { $$ = mk_atom(yytext); }
| VIRTUAL                    { $$ = mk_atom(yytext); }
| WHILE                      { $$ = mk_atom(yytext); }
| YIELD                      { $$ = mk_atom(yytext); }
| CONTINUE                   { $$ = mk_atom(yytext); }
| PROC                       { $$ = mk_atom(yytext); }
| BOX                        { $$ = mk_atom(yytext); }
| CONST                      { $$ = mk_atom(yytext); }
| WHERE                      { $$ = mk_atom(yytext); }
| TYPEOF                     { $$ = mk_atom(yytext); }
| INNER_DOC_COMMENT          { $$ = mk_atom(yytext); }
| OUTER_DOC_COMMENT          { $$ = mk_atom(yytext); }
| SHEBANG                    { $$ = mk_atom(yytext); }
| STATIC_LIFETIME            { $$ = mk_atom(yytext); }
| ';'                        { $$ = mk_atom(yytext); }
| ','                        { $$ = mk_atom(yytext); }
| '.'                        { $$ = mk_atom(yytext); }
| '@'                        { $$ = mk_atom(yytext); }
| '#'                        { $$ = mk_atom(yytext); }
| '~'                        { $$ = mk_atom(yytext); }
| ':'                        { $$ = mk_atom(yytext); }
| '$'                        { $$ = mk_atom(yytext); }
| '='                        { $$ = mk_atom(yytext); }
| '?'                        { $$ = mk_atom(yytext); }
| '!'                        { $$ = mk_atom(yytext); }
| '<'                        { $$ = mk_atom(yytext); }
| '>'                        { $$ = mk_atom(yytext); }
| '-'                        { $$ = mk_atom(yytext); }
| '&'                        { $$ = mk_atom(yytext); }
| '|'                        { $$ = mk_atom(yytext); }
| '+'                        { $$ = mk_atom(yytext); }
| '*'                        { $$ = mk_atom(yytext); }
| '/'                        { $$ = mk_atom(yytext); }
| '^'                        { $$ = mk_atom(yytext); }
| '%'                        { $$ = mk_atom(yytext); }
;

token_trees
: %empty                     { $$ = mk_node("TokenTrees", 0); }
| token_trees token_tree     { $$ = ext_node($1, 1, $2); }
;

token_tree
: delimited_token_trees
| unpaired_token         { $$ = mk_node("TTTok", 1, $1); }
;

delimited_token_trees
: parens_delimited_token_trees
| braces_delimited_token_trees
| brackets_delimited_token_trees
;

parens_delimited_token_trees
: '(' token_trees ')'
{
  $$ = mk_node("TTDelim", 3,
               mk_node("TTTok", 1, mk_atom("(")),
               $2,
               mk_node("TTTok", 1, mk_atom(")")));
}
;

braces_delimited_token_trees
: '{' token_trees '}'
{
  $$ = mk_node("TTDelim", 3,
               mk_node("TTTok", 1, mk_atom("{")),
               $2,
               mk_node("TTTok", 1, mk_atom("}")));
}
;

brackets_delimited_token_trees
: '[' token_trees ']'
{
  $$ = mk_node("TTDelim", 3,
               mk_node("TTTok", 1, mk_atom("[")),
               $2,
               mk_node("TTTok", 1, mk_atom("]")));
}
;

