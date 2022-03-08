=begin comment
These keywords can only be used in their correct
contexts. They cannot be used as the names of:

    Items
    Variables and function parameters
    Fields and variants
    Type parameters
    Lifetime parameters or loop labels
    Macros or attributes
    Macro placeholders
    Crates
=end comment
our role StrictKeywords::Rules {
    token kw-as        { as }
    token kw-break     { break }
    token kw-const     { const }
    token kw-continue  { continue }
    token kw-crate     { crate }
    token kw-else      { else }
    token kw-enum      { enum }
    token kw-extern    { extern }
    token kw-false     { false }
    token kw-fn        { fn }
    token kw-for       { for }
    token kw-if        { if }
    token kw-impl      { impl }
    token kw-in        { in }
    token kw-let       { let }
    token kw-loop      { loop }
    token kw-match     { match }
    token kw-mod       { mod }
    token kw-move      { move }
    token kw-mut       { mut }
    token kw-pub       { pub }
    token kw-ref       { ref }
    token kw-return    { return }
    token kw-selfvalue { self }
    token kw-selftype  { Self }
    token kw-static    { static }
    token kw-struct    { struct }
    token kw-super     { super }
    token kw-trait     { trait }
    token kw-true      { true }
    token kw-type      { type }
    token kw-unsafe    { unsafe }
    token kw-use       { use }
    token kw-where     { where }
    token kw-while     { while }

    #added in the 2018 edition
    token kw-async     { async }
    token kw-await     { await }
    token kw-dyn       { dyn }
}

=begin comment
These keywords aren't used yet, but they are
reserved for future use. They have the same
restrictions as strict keywords. The reasoning
behind this is to make current programs forward
compatible with future versions of Rust by
forbidding them to use these keywords.
=end comment
our role ReservedKeywords::Rules {
    token kw-abstract { abstract }
    token kw-become   { become }
    token kw-box      { box }
    token kw-do       { do }
    token kw-final    { final }
    token kw-macro    { macro }
    token kw-override { override }
    token kw-priv     { priv }
    token kw-typeof   { typeof }
    token kw-unsized  { unsized }
    token kw-virtual  { virtual }
    token kw-yield    { yield }

    #added in the 2018 edition
    token kw-try      { try }
}

=begin comment
These keywords have special meaning only in
certain contexts. For example, it is possible to
declare a variable or method with the name union.
=end comment
our role WeakKeywords::Rules {
    token kw-union          { union }
    token kw-staticlifetime { \'static }
}
