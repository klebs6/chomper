use Data::Dump::Tree;

use grust-model;
use grust-model-expr;

our role ExprNoStruct::Rules {

    rule expr-nostruct { <expr-nostruct-assign> }

    #--------------------------------
    rule expr-nostruct-assign        {  <expr-nostruct-assign-shleq>  ["=" <expr-nostruct-assign-shleq>]* }
    rule expr-nostruct-assign-shleq  {  <expr-nostruct-assign-shreq>  [<tok-shleq>        <expr-nostruct-assign-shreq>]* }
    rule expr-nostruct-assign-shreq  {  <expr-nostruct-minuseq>       [<tok-shreq>        <expr-nostruct-minuseq>]* }
    rule expr-nostruct-minuseq       {  <expr-nostruct-andeq>         [<tok-minuseq>      <expr-nostruct-andeq>]* }
    rule expr-nostruct-andeq         {  <expr-nostruct-oreq>          [<tok-andeq>        <expr-nostruct-oreq>]* }
    rule expr-nostruct-oreq          {  <expr-nostruct-pluseq>        [<tok-oreq>         <expr-nostruct-pluseq>]* }
    rule expr-nostruct-pluseq        {  <expr-nostruct-stareq>        [<tok-pluseq>       <expr-nostruct-stareq>]* }
    rule expr-nostruct-stareq        {  <expr-nostruct-slasheq>       [<tok-stareq>       <expr-nostruct-slasheq>]* }
    rule expr-nostruct-slasheq       {  <expr-nostruct-careteq>       [<tok-slasheq>      <expr-nostruct-careteq>]* }
    rule expr-nostruct-careteq       {  <expr-nostruct-percenteq>     [<tok-careteq>      <expr-nostruct-percenteq>]* }
    rule expr-nostruct-percenteq     {  <expr-nostruct-oror>          [<tok-percenteq>    <expr-nostruct-oror>]* }
    rule expr-nostruct-oror          {  <expr-nostruct-andand>        [<tok-oror>         <expr-nostruct-andand>]* }
    rule expr-nostruct-andand        {  <expr-nostruct-eqeq>          [<tok-andand>       <expr-nostruct-eqeq>]* }
    rule expr-nostruct-eqeq          {  <expr-nostruct-ne>            [<tok-eqeq>         <expr-nostruct-ne>]* }
    rule expr-nostruct-ne            {  <expr-nostruct-lt>            [<tok-ne>           <expr-nostruct-lt>]* }
    rule expr-nostruct-lt            {  <expr-nostruct-gt>            ['<'                <expr-nostruct-gt>]* }
    rule expr-nostruct-gt            {  <expr-nostruct-le>            ['>'                <expr-nostruct-le>]* }
    rule expr-nostruct-le            {  <expr-nostruct-ge>            [<tok-le>           <expr-nostruct-ge>]* }
    rule expr-nostruct-ge            {  <expr-nostruct-pipe>          [<tok-ge>           <expr-nostruct-pipe>]* }
    rule expr-nostruct-pipe          {  <expr-nostruct-caret>         ['|'  <!before '|'> <expr-nostruct-caret>]* }
    rule expr-nostruct-caret         {  <expr-nostruct-and>           ['^'                <expr-nostruct-and>]* }
    rule expr-nostruct-and           {  <expr-nostruct-shl>           ['&' <!before '&'>  <expr-nostruct-shl>]* }
    rule expr-nostruct-shl           {  <expr-nostruct-shr>           [<tok-shl>          <expr-nostruct-shr>]* }
    rule expr-nostruct-shr           {  <expr-nostruct-add>           [<tok-shr>          <expr-nostruct-add>]* }
    rule expr-nostruct-add           {  <expr-nostruct-sub>           ['+'                <expr-nostruct-sub>]* }
    rule expr-nostruct-sub           {  <expr-nostruct-mul>           ['-'                <expr-nostruct-mul>]* }
    rule expr-nostruct-mul           {  <expr-nostruct-div>           ['*'                <expr-nostruct-div>]* }
    rule expr-nostruct-div           {  <expr-nostruct-mod>           ['/'                <expr-nostruct-mod>]* }
    rule expr-nostruct-mod           {  <expr-nostruct-tight>         ['%'                <expr-nostruct-tight>]* }

    #-----------------------
    proto rule expr-nostruct-range         { * }
    rule expr-nostruct-range:sym<a>        { <tok-dotdot> }
    rule expr-nostruct-range:sym<b>        { <tok-dotdot> <expr-nostruct-tighter> }
    rule expr-nostruct-range:sym<c>        { <expr-nostruct-tighter> <tok-dotdot> }
    rule expr-nostruct-range:sym<d>        { <expr-nostruct-tighter> <tok-dotdot> <expr-nostruct-tighter> }

    #-----------------------
    proto rule expr-nostruct-tight         { * }
    #rule expr-nostruct-tight:sym<range>   { <expr-nostruct-range> }
    rule expr-nostruct-tight:sym<tighter>  { <expr-nostruct-tighter> }

    rule expr-nostruct-tighter             { <expr-nostruct-even-tighter> [<kw-as> <ty>]* }
    rule expr-nostruct-even-tighter        { <expr-nostruct-tightest> [':' <ty>]* }

    proto rule expr-nostruct-tightest { * }

    rule expr-nostruct-tightest:sym<bc> { <kw-box> <expr> }
    rule expr-nostruct-tightest:sym<bd> { <expr-qualified-path> }
    rule expr-nostruct-tightest:sym<be> { <block-expr> }
    rule expr-nostruct-tightest:sym<bf> { <block> }
    rule expr-nostruct-tightest:sym<a>  { <expr-nostruct-unary-minus> }

    #--------------------------

    rule expr-nostruct-unary-minus {
      <tok-minus>? 
      <expr-nostruct-unary-not> 
    }

    rule expr-nostruct-unary-not {
        <tok-bang>? 
        <expr-nostruct-unary-star> 
    }

    rule expr-nostruct-unary-star {
        <tok-star>? 
        <expr-nostruct-unary-ampersand> 
    }

    rule unary-ampersand-maybe-mut {
        '&' <maybe-mut> 
    }

    rule expr-nostruct-unary-ampersand {
        <unary-ampersand-maybe-mut>? 
        <expr-nostruct-unary-refref>
    }

    rule unary-refref-maybe-mut {
        <tok-andand> 
        <maybe-mut> 
    }

    rule expr-nostruct-unary-refref { 
        <unary-refref-maybe-mut>?
        <expr-nostruct-most-tightest-of-all> 
    }

    #----------------------
    proto rule expr-nostruct-most-tightest-of-all { * }

    rule expr-nostruct-most-tightest-of-all:sym<f>  { <lambda-expr-nostruct> }
    rule expr-nostruct-most-tightest-of-all:sym<g>  { <kw-move> <lambda-expr-nostruct> }
    rule expr-nostruct-most-tightest-of-all:sym<c>  { <expr-nostruct-base> } #{self.set-prec(IDENT)} 

    #--------------------------------
    rule expr-nostruct-base { <expr-nostruct-root> <tok-qmark>* }

    #--------------------------------
    proto rule expr-nostruct-root { * }
    rule expr-nostruct-root:sym<a> { <lit> }
    rule expr-nostruct-root:sym<b> { <path-expr> } #{self.set-prec(IDENT)} 
    rule expr-nostruct-root:sym<c> { <kw-self> }
    rule expr-nostruct-root:sym<d> { <macro-expr> }
    rule expr-nostruct-root:sym<f> { <expr-nostruct-dot-path> }

    #--------------------------------
    rule expr-nostruct-dot-path    { <expr-nostruct-dot-lit-int> ["." <path-generic-args-with-colons>]* }
    rule expr-nostruct-dot-lit-int { <expr-nostruct-brack-index> ["." <lit-int>]* }
    rule expr-nostruct-brack-index { <expr-nostruct-call>        ['[' <maybe-expr> ']']* }
    rule expr-nostruct-call        { <expr-nostruct-basic>       ['(' <maybe-exprs> ')']* }

    #--------------------------------
    proto rule expr-nostruct-basic { * }

    rule expr-nostruct-basic:sym<j> { '[' <vec-expr> ']' }
    rule expr-nostruct-basic:sym<k> { '(' <maybe-exprs> ')' }
    rule expr-nostruct-basic:sym<m> { <kw-continue> <ident>? }
    rule expr-nostruct-basic:sym<o> { <kw-return>   <expr>? }
    rule expr-nostruct-basic:sym<q> { <kw-break>    <ident>? }
    rule expr-nostruct-basic:sym<s> { <kw-yield>    <expr>? }
}

our role ExprNoStruct::Actions {}
