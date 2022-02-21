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

