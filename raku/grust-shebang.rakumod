use grust-model;

=begin comment
# { BEGIN(pound); yymore(); }
<tok-pound>\! { BEGIN(shebang-or-attr); yymore(); }
<shebang-or-attr>\[ {
  BEGIN(INITIAL);
  yyless(2);
  return SHEBANG;
}
<shebang-or-attr>[^\[\n]*\n {
  // Since the \n was eaten as part of the token, yylineno will have
  // been incremented to the value 2 if the shebang was on the first
  // line. This yyless undoes that, setting yylineno back to 1.
  yyless(yyleng - 1);
  if (yyget-lineno() == 1) {
    BEGIN(INITIAL);
    return SHEBANG-LINE;
  } else {
    BEGIN(INITIAL);
    yyless(2);
    return SHEBANG;
  }
}
<tok-pound>. { BEGIN(INITIAL); yyless(1); return '#'; }
=end comment
our role Lex::Pound {

    token shebang { '#!' }

    token shebang-line { 
        #{at-beginning-of-file()}?
        '#!' <-[ \n ]>* '\n'
    }

    token pound {
        'TODO'

    }
}
