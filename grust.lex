=begin comment


static char pushback[PUSHBACK_LEN];
static int verbose;

// If there is a non-null char at the head of the
// pushback queue, dequeue it and shift the rest
// of the queue forwards. Otherwise, return the
// token from calling yylex.
int rslex() {
  if (pushback[0] == '\0') {
    return yylex();
  } else {
    char c = pushback[0];
    memmove(pushback, pushback + 1, PUSHBACK_LEN - 1);
    pushback[PUSHBACK_LEN - 1] = '\0';
    return c;
  }
}

// Note: this does nothing if the pushback queue
// is full. As long as there aren't more than
// PUSHBACK_LEN consecutive calls to push_back in
// an action, this shouldn't be a problem.
void push_back(char c) {
  for (int i = 0; i < PUSHBACK_LEN; ++i) {
    if (pushback[i] == '\0') {
      pushback[i] = c;
      break;
    }
  }
}

extern int rsdebug;

struct node {
  struct node *next;
  struct node *prev;
  int own_string;
  char const *name;
  int n_elems;
  struct node *elems[];
};

struct node *nodes = NULL;
int n_nodes;

struct node *mk_node(char const *name, int n, ...) {
  va_list ap;
  int i = 0;
  unsigned sz = sizeof(struct node) + (n * sizeof(struct node *));
  struct node *nn, *nd = (struct node *)malloc(sz);

  print("# New %d-ary node: %s = %p\n", n, name, nd);

  nd->own_string = 0;
  nd->prev = NULL;
  nd->next = nodes;
  if (nodes) {
    nodes->prev = nd;
  }
  nodes = nd;

  nd->name = name;
  nd->n_elems = n;

  va_start(ap, n);
  while (i < n) {
    nn = va_arg(ap, struct node *);
    print("#   arg[%d]: %p\n", i, nn);
    print("#            (%s ...)\n", nn->name);
    nd->elems[i++] = nn;
  }
  va_end(ap);
  n_nodes++;
  return nd;
}

struct node *mk_atom(char *name) {
  struct node *nd = mk_node((char const *)strdup(name), 0);
  nd->own_string = 1;
  return nd;
}

struct node *mk_none() {
  return mk_atom("<none>");
}

struct node *ext_node(struct node *nd, int n, ...) {
  va_list ap;
  int i = 0, c = nd->n_elems + n;
  unsigned sz = sizeof(struct node) + (c * sizeof(struct node *));
  struct node *nn;

  print("# Extending %d-ary node by %d nodes: %s = %p",
        nd->n_elems, c, nd->name, nd);

  if (nd->next) {
    nd->next->prev = nd->prev;
  }
  if (nd->prev) {
    nd->prev->next = nd->next;
  }
  nd = realloc(nd, sz);
  nd->prev = NULL;
  nd->next = nodes;
  nodes->prev = nd;
  nodes = nd;

  print(" ==> %p\n", nd);

  va_start(ap, n);
  while (i < n) {
    nn = va_arg(ap, struct node *);
    print("#   arg[%d]: %p\n", i, nn);
    print("#            (%s ...)\n", nn->name);
    nd->elems[nd->n_elems++] = nn;
    ++i;
  }
  va_end(ap);
  return nd;
}

int const indent_step = 4;

void print_indent(int depth) {
  while (depth) {
    if (depth-- % indent_step == 0) {
      print("|");
    } else {
      print(" ");
    }
  }
}

void print_node(struct node *n, int depth) {
  int i = 0;
  print_indent(depth);
  if (n->n_elems == 0) {
    print("%s\n", n->name);
  } else {
    print("(%s\n", n->name);
    for (i = 0; i < n->n_elems; ++i) {
      print_node(n->elems[i], depth + indent_step);
    }
    print_indent(depth);
    print(")\n");
  }
}

int main(int argc, char **argv) {
  if (argc == 2 && strcmp(argv[1], "-v") == 0) {
    verbose = 1;
  } else {
    verbose = 0;
  }
  int ret = 0;
  struct node *tmp;
  memset(pushback, '\0', PUSHBACK_LEN);
  ret = rsparse();
  print("--- PARSE COMPLETE: ret:%d, n_nodes:%d ---\n", ret, n_nodes);
  if (nodes) {
    print_node(nodes, 0);
  }
  while (nodes) {
    tmp = nodes;
    nodes = tmp->next;
    if (tmp->own_string) {
      free((void*)tmp->name);
    }
    free(tmp);
  }
  return ret;
}

void rserror(char const *s) {
  fprintf(stderr, "%s\n", s);
}

=end comment
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




