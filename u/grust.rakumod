=begin comment
#|{ "action" : { "@lexer::members" : "{\n      static int dotChar = 46;\n\n      // is this character followed by an identifier or\n      // a dot? this is used in parsing numbers, to distinguish\n      // floating-point numbers from ranges and method calls.\n      public boolean followed_by_ident_or_dot() {\n        CharStream cs = getInputStream();\n        int nextChar = cs.LA(1);\n        // KNOWN POTENTIAL ISSUE : this fn needs to be\n        // aligned with the list appearing in xidstart....\n        return (java.lang.Character.isUnicodeIdentifierStart(nextChar)\n                || nextChar == dotChar);\n      }\n\n      // are we at the beginning of the file? This is needed in\n      // order to parse shebangs.\n      public boolean at_beginning_of_file() {\n        return (getInputStream().index() == 0);\n      }\n\n    }" } }
grammar Rust::Grammar {
	token tts {
		||	<tt>*
	}
	token prog {
		||	<module_contents>
	}
	token module_contents {
		||	<inner_attr>*
			<extern_mod_view_item>*
			<view_item>*
			<mod_item>*
	}
	token extern_mod_view_item {
		||	<attrs_and_vis>
			<EXTERN>
			<MOD>
			<ident>
			(	||	<lib_selectors>
			)?
			<SEMI>
	}
	token view_item {
		||	<attrs_and_vis>
			<USE>
			<view_paths>
			<SEMI>
	}
	token mod_item {
		||	<attrs_and_vis>
			<mod_decl>
		||	<attrs_and_vis>
			<foreign_mod>
		||	<attrs_and_vis>
			<type_decl>
		||	<attrs_and_vis>
			<struct_decl>
		||	<attrs_and_vis>
			<enum_decl>
		||	<attrs_and_vis>
			<trait_decl>
		||	<attrs_and_vis>
			<const_item>
		||	<attrs_and_vis>
			<impl>
		||	<outer_attrs>
			<impl_trait_for_type>
		||	<attrs_and_vis>
			(	||	<UNSAFE>
			)?
			<item_fn_decl>
		||	<attrs_and_vis>
			<EXTERN>
			(	||	<LIT_STR>
			)?
			<item_fn_decl>
		||	<macro_item>
	}
	token mod_decl {
		||	<MOD>
			<ident>
			<SEMI>
		||	<MOD>
			<ident>
			<LBRACE>
			<module_contents>
			<RBRACE>
	}
	token foreign_mod {
		||	<EXTERN>
			(	||	<LIT_STR>
			)?
			<MOD>
			<ident>
			<LBRACE>
			<inner_attr>*
			<foreign_item>*
			<RBRACE>
		||	<EXTERN>
			(	||	<LIT_STR>
			)?
			<LBRACE>
			<inner_attr>*
			<foreign_item>*
			<RBRACE>
	}
	token foreign_item {
		||	<outer_attrs>
			<STATIC>
			<ident>
			<COLON>
			<ty>
			<SEMI>
		||	<outer_attrs>
			<visibility>
			(	||	<UNSAFE>
			)?
			<FN>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<args>
			)?
			<RPAREN>
			<ret_ty>
			<SEMI>
	}
	token type_decl {
		||	<TYPE>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<EQ>
			<ty>
			<SEMI>
	}
	token struct_decl {
		||	<STRUCT>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LBRACE>
			(	||	<struct_fields>
					(	||	<COMMA>
					)?
			)?
			<RBRACE>
		||	<STRUCT>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<tys>
			)?
			<RPAREN>
			<SEMI>
		||	<STRUCT>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<SEMI>
	}
	token struct_fields {
		||	<struct_field>
			<COMMA>
			<struct_fields>
		||	<struct_field>
	}
	token struct_field {
		||	<attrs_and_vis>
			<mutability>
			<ident>
			<COLON>
			<ty>
		||	<outer_attrs>
			<DROP>
			<block>
	}
	token enum_decl {
		||	<ENUM>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LBRACE>
			(	||	<enum_variant_decls>
					(	||	<COMMA>
					)?
			)?
			<RBRACE>
	}
	token enum_variant_decls {
		||	<enum_variant_decl>
			<COMMA>
			<enum_variant_decls>
		||	<enum_variant_decl>
	}
	token enum_variant_decl {
		||	<attrs_and_vis>
			<ident>
			<LBRACE>
			(	||	<struct_fields>
					(	||	<COMMA>
					)?
			)?
			<RBRACE>
		||	<attrs_and_vis>
			<ident>
			<LPAREN>
			(	||	<tys>
			)?
			<RPAREN>
		||	<attrs_and_vis>
			<ident>
			<EQ>
			<expr>
		||	<attrs_and_vis>
			<ident>
	}
	token trait_decl {
		||	<TRAIT>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			(	||	<COLON>
					<traits>
			)?
			<LBRACE>
			<trait_method>*
			<RBRACE>
	}
	token trait_method {
		||	<attrs_and_vis>
			(	||	<UNSAFE>
			)?
			<FN>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<self_ty_and_maybenamed_args>
			)?
			<RPAREN>
			<ret_ty>
			<SEMI>
		||	<attrs_and_vis>
			(	||	<UNSAFE>
			)?
			<FN>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<self_ty_and_maybenamed_args>
			)?
			<RPAREN>
			<ret_ty>
			<fun_body>
	}
	token impl {
		||	<IMPL>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<ty>
			<impl_body>
	}
	token impl_trait_for_type {
		||	<IMPL>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<trait>
			<FOR>
			<ty>
			<impl_body>
	}
	token impl_body {
		||	<SEMI>
		||	<LBRACE>
			<impl_method>*
			<RBRACE>
	}
	token impl_method {
		||	<attrs_and_vis>
			(	||	<UNSAFE>
			)?
			<FN>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<self_ty_and_args>
			)?
			<RPAREN>
			<ret_ty>
			<fun_body>
	}
	token item_fn_decl {
		||	<FN>
			<ident>
			(	||	<LT>
					(	||	<generic_decls>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<args>
			)?
			<RPAREN>
			<ret_ty>
			<fun_body>
	}
	token fun_body {
		||	<LBRACE>
			<inner_attr>*
			<view_item>*
			<block_element>*
			(	||	<block_last_element>
			)?
			<RBRACE>
	}
	token block {
		||	<LBRACE>
			<view_item>*
			<block_element>*
			(	||	<block_last_element>
			)?
			<RBRACE>
	}
	token block_element {
		||	<expr_RL>
			(	||	<SEMI>
			)+
		||	<stmt_not_just_expr>
			(	||	<SEMI>
			)*
	}
	token block_last_element {
		||	<expr_RL>
		||	<macro_parens>
		||	<expr_stmt>
	}
	token ret_ty {
		||	<RARROW>
			<NOT>
		||	<RARROW>
			<ty>
	}
	token macro_item {
		||	<ident>
			<NOT>
			(	||	<ident>
			)?
			<parendelim>
		||	<ident>
			<NOT>
			(	||	<ident>
			)?
			<bracedelim>
	}
	token attrs_and_vis {
		||	<outer_attrs>
			<visibility>
	}
	token visibility {
		||	<PUB>
		||	<PRIV>
	}
	token mutability {
		||	<MUT>
		||	<CONST>
	}
	token lib_selectors {
		||	<LPAREN>
			(	||	<meta_items>
			)?
			<RPAREN>
	}
	token outer_attrs {
		||	<outer_attr>
			<outer_attrs>
	}
	token outer_attr {
		||	<POUND>
			<LBRACKET>
			<meta_item>
			<RBRACKET>
		||	<OUTER_DOC_COMMENT>
	}
	token inner_attr {
		||	<POUND>
			<LBRACKET>
			<meta_item>
			<RBRACKET>
			<SEMI>
		||	<INNER_DOC_COMMENT>
	}
	token meta_item {
		||	<ident>
		||	<ident>
			<EQ>
			<lit>
		||	<ident>
			<LPAREN>
			(	||	<meta_items>
			)?
			<RPAREN>
	}
	token meta_items {
		||	<meta_item>
		||	<meta_item>
			<COMMA>
			<meta_items>
	}
	token args {
		||	<arg>
		||	<arg>
			<COMMA>
			<args>
	}
	token arg {
		||	(	||	<arg_mode>
			)?
			<mutability>
			<pat>
			<COLON>
			<ty>
	}
	token arg_mode {
		||	<AND>
			<AND>
		||	<PLUS>
		||	<obsoletemode>
	}
	token obsoletemode {
		||	<PLUS>
			<PLUS>
	}
	token self_ty_and_args {
		||	<self_ty>
			(	||	<COMMA>
					<args>
			)?
		||	<args>
	}
	token self_ty_and_maybenamed_args {
		||	<self_ty>
			(	||	<COMMA>
					<maybenamed_args>
			)?
		||	<maybenamed_args>
	}
	token self_ty {
		||	<AND>
			(	||	<lifetime>
			)?
			<mutability>
			<SELF>
		||	<AT>
			<mutability>
			<SELF>
		||	<TILDE>
			<mutability>
			<SELF>
		||	<SELF>
	}
	token maybetyped_args {
		||	<maybetyped_arg>
		||	<maybetyped_arg>
			<COMMA>
			<maybetyped_args>
	}
	token maybetyped_arg {
		||	(	||	<arg_mode>
			)?
			<mutability>
			<pat>
			(	||	<COLON>
					<ty>
			)?
	}
	token maybenamed_args {
		||	<maybenamed_arg>
		||	<maybenamed_arg>
			<COMMA>
			<maybenamed_args>
	}
	token maybenamed_arg {
		||	<arg>
		||	<ty>
	}
	token pat {
		||	<AT>
			<pat>
		||	<TILDE>
			<pat>
		||	<AND>
			<pat>
		||	<LPAREN>
			<RPAREN>
		||	<LPAREN>
			<pats>
			<RPAREN>
		||	<LBRACKET>
			(	||	<vec_pats>
			)?
			<RBRACKET>
		||	<expr_RB>
			(	||	<DOTDOT>
					<expr_RB>
			)?
		||	<REF>
			<mutability>
			<ident>
			(	||	<AT>
					<pat>
			)?
		||	<COPYTOK>
			<ident>
			(	||	<AT>
					<pat>
			)?
		||	<path>
			<AT>
			<pat>
		||	<path_with_colon_tps>
		||	<path_with_colon_tps>
			<LBRACE>
			<pat_fields>
			<RBRACE>
		||	<path_with_colon_tps>
			<LPAREN>
			<STAR>
			<RPAREN>
		||	<path_with_colon_tps>
			<LPAREN>
			(	||	<pats>
			)?
			<RPAREN>
	}
	token pats {
		||	<pat>
			(	||	<COMMA>
			)?
		||	<pat>
			<COMMA>
			<pats>
	}
	token pats_or {
		||	<pat>
		||	<pat>
			<OR>
			<pats_or>
	}
	token vec_pats {
		||	<pat>
		||	<DOTDOT>
			<ident>
		||	<pat>
			<COMMA>
			<vec_pats>
		||	<DOTDOT>
			<ident>
			<COMMA>
			<vec_pats_no_slice>
	}
	token vec_pats_no_slice {
		||	<pat>
		||	<pat>
			<COMMA>
			<vec_pats_no_slice>
	}
	token const_item {
		||	<STATIC>
			<ident>
			<COLON>
			<ty>
			<EQ>
			<expr>
			<SEMI>
	}
	token view_paths {
		||	<view_path>
		||	<view_path>
			<COMMA>
			<view_paths>
	}
	token view_path {
		||	(	||	<MOD>
			)?
			<ident>
			<EQ>
			<non_global_path>
		||	(	||	<MOD>
			)?
			<non_global_path>
			<MOD_SEP>
			<LBRACE>
			<RBRACE>
		||	(	||	<MOD>
			)?
			<non_global_path>
			<MOD_SEP>
			<LBRACE>
			<idents>
			(	||	<COMMA>
			)?
			<RBRACE>
		||	(	||	<MOD>
			)?
			<non_global_path>
			<MOD_SEP>
			<STAR>
		||	(	||	<MOD>
			)?
			<non_global_path>
	}
	token pat_fields {
		||	<IDENT>
			(	||	<COLON>
					<pat>
			)?
		||	<IDENT>
			(	||	<COLON>
					<pat>
			)?
			<COMMA>
			<pat_fields>
		||	<UNDERSCORE>
	}
	token traits {
		||	<trait>
		||	<trait>
			<PLUS>
			<traits>
	}
	token trait {
		||	<path>
			(	||	<LT>
					(	||	<generics>
					)?
					<GT>
			)?
	}
	token tys {
		||	<ty>
		||	<ty>
			<COMMA>
			<tys>
	}
	token ty {
		||	<LPAREN>
			<RPAREN>
		||	<LPAREN>
			<ty>
			<RPAREN>
		||	<LPAREN>
			<ty>
			<COMMA>
			<RPAREN>
		||	<LPAREN>
			<tys>
			<RPAREN>
		||	<AT>
			<box_or_uniq_pointee>
		||	<TILDE>
			<box_or_uniq_pointee>
		||	<STAR>
			<mutability>
			<ty>
		||	<path>
			(	||	<LT>
					(	||	<generics>
					)?
					<GT>
			)?
		||	<LBRACKET>
			(	||	<obsoleteconst>
			)?
			<ty>
			<COMMA>
			<DOTDOT>
			<expr>
			<RBRACKET>
		||	<LBRACKET>
			(	||	<obsoleteconst>
			)?
			<ty>
			<RBRACKET>
		||	<AND>
			<borrowed_pointee>
		||	<EXTERN>
			(	||	<LIT_STR>
			)?
			(	||	<UNSAFE>
			)?
			<ty_fn>
		||	<ty_closure>
		||	<path>
			(	||	<LT>
					(	||	<generics>
					)?
					<GT>
			)?
	}
	token box_or_uniq_pointee {
		||	(	||	<lifetime>
			)?
			<ty_closure>
		||	<mutability>
			<ty>
	}
	token borrowed_pointee {
		||	(	||	<lifetime>
			)?
			<ty_closure>
		||	(	||	<lifetime>
			)?
			<mutability>
			<ty>
	}
	token ty_closure {
		||	(	||	<UNSAFE>
			)?
			(	||	<ONCE>
			)?
			<ty_fn>
	}
	token ty_fn {
		||	<FN>
			(	||	<LT>
					(	||	<lifetimes>
					)?
					<GT>
			)?
			<LPAREN>
			(	||	<maybenamed_args>
			)?
			<RPAREN>
			<ret_ty>
	}
	token obsoleteconst {
		||	<CONST>
	}
	token stmt_not_just_expr {
		||	<let_stmt>
		||	<macro_parens>
		||	<mod_item>
		||	<expr_stmt>
	}
	token let_stmt {
		||	<LET>
			<mutability>
			<local_var_decl>
			(	||	<COMMA>
					<local_var_decl>
			)*
			<SEMI>
	}
	token local_var_decl {
		||	<pat>
			(	||	<COLON>
					<ty>
			)?
			(	||	<EQ>
					<expr>
			)?
	}
	token generic_decls {
		||	<lifetime>
		||	<lifetime>
			<COMMA>
			<generic_decls>
		||	<ty_params>
	}
	token ty_params {
		||	<ty_param>
		||	<ty_param>
			<COMMA>
			<ty_params>
	}
	token ty_param {
		||	<ident>
		||	<ident>
			<COLON>
		||	<ident>
			<COLON>
			<boundseq>
	}
	token boundseq {
		||	<bound>
		||	<bound>
			<PLUS>
			<boundseq>
	}
	token bound {
		||	<STATIC_LIFETIME>
		||	<ty>
		||	<obsoletekind>
	}
	token obsoletekind {
		||	<COPYTOK>
		||	<CONST>
	}
	token generics {
		||	<lifetime>
		||	<lifetime>
			<COMMA>
			<generics>
		||	<tys>
	}
	token lifetimes_in_braces {
		||	<LT>
			(	||	<lifetimes>
			)?
			<GT>
	}
	token lifetimes {
		||	<lifetime>
		||	<lifetime>
			<COMMA>
			<lifetimes>
	}
	token idents {
		||	<ident>
		||	<ident>
			<COMMA>
			<idents>
	}
	token path {
		||	<MOD_SEP>?
			<non_global_path>
	}
	token non_global_path {
		||	<ident>
			(	||	<MOD_SEP>
					<ident>
			)*
	}
	token exprs {
		||	<expr>
		||	<expr>
			<COMMA>
			<exprs>
	}
	token expr {
		||	<expr_1>
			<EQ>
			<expr>
		||	<expr_1>
			<BINOPEQ>
			<expr>
		||	<expr_1>
			<DARROW>
			<expr>
		||	<expr_1>
	}
	token expr_1 {
		||	<expr_1>
			<OR>
			<expr_2>
		||	<expr_2>
	}
	token expr_2 {
		||	<expr_2>
			<AND>
			<expr_3>
		||	<expr_3>
	}
	token expr_3 {
		||	<expr_3>
			<EQEQ>
			<expr_4>
		||	<expr_3>
			<NE>
			<expr_4>
		||	<expr_4>
	}
	token expr_4 {
		||	<expr_4>
			<LT>
			<expr_5>
		||	<expr_4>
			<LE>
			<expr_5>
		||	<expr_4>
			<GE>
			<expr_5>
		||	<expr_4>
			<GT>
			<expr_5>
		||	<expr_5>
	}
	token expr_5 {
		||	<expr_6>
	}
	token expr_6 {
		||	<expr_6>
			<OR>
			<OR>
			<expr_7>
		||	<expr_7>
	}
	token expr_7 {
		||	<expr_7>
			<CARET>
			<expr_8>
		||	<expr_8>
	}
	token expr_8 {
		||	<expr_8>
			<AND>
			<expr_9>
		||	<expr_9>
	}
	token expr_9 {
		||	<expr_9>
			<LT>
			<LT>
			<expr_10>
		||	<expr_9>
			<GT>
			<GT>
			<expr_10>
		||	<expr_10>
	}
	token expr_10 {
		||	<expr_10>
			<PLUS>
			<expr_11>
		||	<expr_10>
			<MINUS>
			<expr_11>
		||	<expr_11>
	}
	token expr_11 {
		||	<expr_11>
			<AS>
			<ty>
		||	<expr_12>
	}
	token expr_12 {
		||	<expr_12>
			<STAR>
			<expr_prefix>
		||	<expr_12>
			<DIV>
			<expr_prefix>
		||	<expr_12>
			<REM>
			<expr_prefix>
		||	<expr_prefix>
	}
	token expr_prefix {
		||	<NOT>
			<expr_prefix>
		||	<MINUS>
			<expr_prefix>
		||	<STAR>
			<expr_prefix>
		||	<AND>
			(	||	<lifetime>
			)?
			<mutability>
			<expr_prefix>
		||	<AT>
			<mutability>
			<expr_prefix>
		||	<TILDE>
			<expr_prefix>
		||	<expr_dot_or_call>
	}
	token expr_dot_or_call {
		||	<expr_dot_or_call>
			<DOT>
			<ident>
			(	||	<MOD_SEP>
					<LT>
					(	||	<generics>
					)?
					<GT>
			)?
			(	||	<LPAREN>
					(	||	<exprs>
					)?
					<RPAREN>
			)?
		||	<expr_dot_or_call>
			<LPAREN>
			(	||	<exprs>
			)?
			<RPAREN>
		||	<expr_dot_or_call>
			<LBRACKET>
			<expr>
			<RBRACKET>
		||	<expr_bottom>
	}
	token expr_bottom {
		||	<LPAREN>
			(	||	<exprs>
					(	||	<COMMA>
					)?
			)?
			<RPAREN>
		||	<expr_lambda>
		||	<expr_stmt>
		||	<expr_vector>
		||	<LOG>
			<LPAREN>
			<expr>
			<COMMA>
			<expr>
			<RPAREN>
		||	<LOOP>
			(	||	<ident>
			)?
		||	<RETURN>
			<expr>
		||	<RETURN>
		||	<BREAK>
			(	||	<ident>
			)?
		||	<COPYTOK>
			<expr>
		||	<macro>
		||	<path_with_colon_tps>
			<LBRACE>
			<field_inits>
			<default_field_inits>
			<RBRACE>
		||	<path_with_colon_tps>
		||	<lit>
	}
	token expr_RL {
		||	<expr_1RL>
			<EQ>
			<expr>
		||	<expr_1RL>
			<BINOPEQ>
			<expr>
		||	<expr_1RL>
			<DARROW>
			<expr>
		||	<expr_1RL>
	}
	token expr_1RL {
		||	<expr_1RL>
			<OR>
			<expr_2>
		||	<expr_2RL>
	}
	token expr_2RL {
		||	<expr_2RL>
			<AND>
			<expr_3>
		||	<expr_3RL>
	}
	token expr_3RL {
		||	<expr_3RL>
			<EQEQ>
			<expr_4>
		||	<expr_3RL>
			<NE>
			<expr_4>
		||	<expr_4RL>
	}
	token expr_4RL {
		||	<expr_4RL>
			<LT>
			<expr_5>
		||	<expr_4RL>
			<LE>
			<expr_5>
		||	<expr_4RL>
			<GE>
			<expr_5>
		||	<expr_4RL>
			<GT>
			<expr_5>
		||	<expr_5RL>
	}
	token expr_5RL {
		||	<expr_6RL>
	}
	token expr_6RL {
		||	<expr_6RL>
			<OR>
			<OR>
			<expr_7>
		||	<expr_7RL>
	}
	token expr_7RL {
		||	<expr_7RL>
			<CARET>
			<expr_8>
		||	<expr_8RL>
	}
	token expr_8RL {
		||	<expr_8RL>
			<AND>
			<expr_9>
		||	<expr_9RL>
	}
	token expr_9RL {
		||	<expr_9RL>
			<LT>
			<LT>
			<expr_10>
		||	<expr_9RL>
			<GT>
			<GT>
			<expr_10>
		||	<expr_10RL>
	}
	token expr_10RL {
		||	<expr_10RL>
			<PLUS>
			<expr_11>
		||	<expr_10RL>
			<MINUS>
			<expr_11>
		||	<expr_11RL>
	}
	token expr_11RL {
		||	<expr_11RL>
			<AS>
			<ty>
		||	<expr_12RL>
	}
	token expr_12RL {
		||	<expr_12RL>
			<STAR>
			<expr_prefix>
		||	<expr_12RL>
			<DIV>
			<expr_prefix>
		||	<expr_12RL>
			<REM>
			<expr_prefix>
		||	<expr_prefixRL>
	}
	token expr_prefixRL {
		||	<NOT>
			<expr_prefix>
		||	<MINUS>
			<expr_prefix>
		||	<STAR>
			<expr_prefix>
		||	<AND>
			(	||	<lifetime>
			)?
			<mutability>
			<expr_prefix>
		||	<AT>
			<mutability>
			<expr_prefix>
		||	<TILDE>
			<expr_prefix>
		||	<expr_dot_or_callRL>
	}
	token expr_dot_or_callRL {
		||	<expr_dot_or_call>
			<DOT>
			<ident>
			(	||	<MOD_SEP>
					<LT>
					(	||	<generics>
					)?
					<GT>
			)?
			(	||	<LPAREN>
					(	||	<exprs>
					)?
					<RPAREN>
			)?
		||	<expr_dot_or_callRL>
			<LPAREN>
			(	||	<exprs>
			)?
			<RPAREN>
		||	<expr_dot_or_callRL>
			<LBRACKET>
			<expr>
			<RBRACKET>
		||	<expr_bottomRL>
	}
	token expr_bottomRL {
		||	<LPAREN>
			(	||	<exprs>
					(	||	<COMMA>
					)?
			)?
			<RPAREN>
		||	<expr_lambda>
		||	<expr_vector>
		||	<LOG>
			<LPAREN>
			<expr>
			<COMMA>
			<expr>
			<RPAREN>
		||	<LOOP>
			(	||	<ident>
			)?
		||	<RETURN>
			<expr>
		||	<RETURN>
		||	<BREAK>
			(	||	<ident>
			)?
		||	<COPYTOK>
			<expr>
		||	<macro>
		||	<path_with_colon_tps>
			<LBRACE>
			<field_inits>
			<default_field_inits>
			<RBRACE>
		||	<path_with_colon_tps>
		||	<lit>
	}
	token expr_RB {
		||	<expr_2>
			<EQ>
			<expr_RB>
		||	<expr_2>
			<BINOPEQ>
			<expr_RB>
		||	<expr_2>
			<DARROW>
			<expr_RB>
		||	<expr_2>
	}
	token expr_RBB {
		||	<expr_2RBB>
			<EQ>
			<expr_RBB>
		||	<expr_2RBB>
			<BINOPEQ>
			<expr_RBB>
		||	<expr_2RBB>
			<DARROW>
			<expr_RBB>
		||	<expr_2RBB>
	}
	token expr_2RBB {
		||	<expr_2RBB>
			<AND>
			<expr_3RBB>
		||	<expr_3RBB>
	}
	token expr_3RBB {
		||	<expr_3RBB>
			<EQEQ>
			<expr_4RBB>
		||	<expr_3RBB>
			<NE>
			<expr_4RBB>
		||	<expr_4RBB>
	}
	token expr_4RBB {
		||	<expr_4RBB>
			<LT>
			<expr_5RBB>
		||	<expr_4RBB>
			<LE>
			<expr_5RBB>
		||	<expr_4RBB>
			<GE>
			<expr_5RBB>
		||	<expr_4RBB>
			<GT>
			<expr_5RBB>
		||	<expr_5RBB>
	}
	token expr_5RBB {
		||	<expr_7>
	}
	token expr_stmt {
		||	<expr_stmt_block>
		||	<expr_stmt_not_block>
	}
	token expr_stmt_block {
		||	(	||	<UNSAFE>
			)?
			<block>
	}
	token expr_stmt_not_block {
		||	<expr_if>
		||	<expr_match>
		||	<expr_while>
		||	<expr_loop>
		||	<expr_for>
		||	<expr_do>
	}
	token field_inits {
		||	<field_init>
		||	<field_init>
			<COMMA>
			<field_inits>
	}
	token default_field_inits {
		||	<COMMA>
			<DOTDOT>
			<expr>
		||	(	||	<COMMA>
			)?
	}
	token field_init {
		||	<mutability>
			<ident>
			<COLON>
			<expr>
	}
	token expr_vector {
		||	<LBRACKET>
			<RBRACKET>
		||	<LBRACKET>
			<expr>
			(	||	<COMMA>
					<DOTDOT>
					<expr>
			)?
			<RBRACKET>
		||	<LBRACKET>
			<expr>
			<COMMA>
			<exprs>
			(	||	<COMMA>
			)?
			<RBRACKET>
	}
	token expr_if {
		||	<IF>
			<expr>
			<block>
			(	||	<ELSE>
					<block_or_if>
			)?
	}
	token block_or_if {
		||	<block>
		||	<expr_if>
	}
	token expr_for {
		||	<FOR>
			<expr_RBB>
			(	||	<OR>
					(	||	<maybetyped_args>
					)?
					<OR>
			)?
			<block>
	}
	token expr_do {
		||	<DO>
			<expr_RBB>
			(	||	<OR>
					(	||	<maybetyped_args>
					)?
					<OR>
			)?
			<block>
	}
	token expr_while {
		||	<WHILE>
			<expr>
			<block>
	}
	token expr_loop {
		||	<LOOP>
			(	||	<UNSAFE>
			)?
			<block>
		||	<LOOP>
			<ident>
			<COLON>
			<block>
	}
	token expr_match {
		||	<MATCH>
			<expr>
			<LBRACE>
			(	||	<match_clauses>
			)?
			<RBRACE>
	}
	token match_clauses {
		||	<match_final_clause>
		||	<match_clause>
			<match_clauses>
	}
	token match_final_clause {
		||	<pats_or>
			(	||	<IF>
					<expr>
			)?
			<FAT_ARROW>
			(	||	<expr_RL>
				||	<expr_stmt_not_block>
				||	<expr_stmt_block>
			)
			(	||	<COMMA>
			)?
	}
	token match_clause {
		||	<pats_or>
			(	||	<IF>
					<expr>
			)?
			<FAT_ARROW>
			(	||	<expr_RL>
					<COMMA>
				||	<expr_stmt_not_block>
					<COMMA>
				||	<expr_stmt_block>
					(	||	<COMMA>
					)?
			)
	}
	token expr_lambda {
		||	<OR>
			(	||	<maybetyped_args>
			)?
			<OR>
			<ret_ty>
			<expr>
	}
	token ident {
		||	<IDENT>
		||	<SELF>
		||	<STATIC>
		||	<UNDERSCORE>
	}
	token lifetime {
		||	<STATIC_LIFETIME>
		||	<LIFETIME>
	}
	token macro {
		||	<macro_parens>
		||	<macro_braces>
	}
	token macro_parens {
		||	<ident>
			<NOT>
			<parendelim>
	}
	token macro_braces {
		||	<ident>
			<NOT>
			<bracedelim>
	}
	token path_with_tps {
		||	<path>
			(	||	<LT>
					(	||	<generics>
					)?
					<GT>
			)?
	}
	token path_with_colon_tps {
		||	<path>
			(	||	<MOD_SEP>
					<LT>
					(	||	<generics>
					)?
					<GT>
			)?
	}
	token lit {
		||	<TRUE>
		||	<FALSE>
		||	<LIT_INT>
		||	<LIT_FLOAT>
		||	<LIT_STR>
		||	<LPAREN>
			<RPAREN>
	}
	token tt {
		||	<non_delimiter>
		||	<delimited>
	}
	token delimited {
		||	<parendelim>
		||	<bracketdelim>
		||	<bracedelim>
	}
	token parendelim {
		||	<LPAREN>
			<tt>*
			<RPAREN>
	}
	token bracketdelim {
		||	<LBRACKET>
			<tt>*
			<RBRACKET>
	}
	token bracedelim {
		||	<LBRACE>
			<tt>*
			<RBRACE>
	}
	token non_delimiter {
		||	<AS>
		||	<BREAK>
		||	<CONST>
		||	<COPYTOK>
		||	<DO>
		||	<DROP>
		||	<ELSE>
		||	<ENUM>
		||	<EXTERN>
		||	<FALSE>
		||	<FN>
		||	<FOR>
		||	<IF>
		||	<IMPL>
		||	<LET>
		||	<LOG>
		||	<LOOP>
		||	<MATCH>
		||	<MOD>
		||	<MUT>
		||	<ONCE>
		||	<PRIV>
		||	<PUB>
		||	<PURE>
		||	<REF>
		||	<RETURN>
		||	<STATIC>
		||	<STRUCT>
		||	<SELF>
		||	<TRUE>
		||	<TRAIT>
		||	<TYPE>
		||	<UNSAFE>
		||	<USE>
		||	<WHILE>
		||	<AND>
		||	<PLUS>
		||	<MINUS>
		||	<DIV>
		||	<REM>
		||	<CARET>
		||	<OR>
		||	<EQ>
		||	<LT>
		||	<LE>
		||	<EQEQ>
		||	<NE>
		||	<GE>
		||	<GT>
		||	<NOT>
		||	<TILDE>
		||	<STAR>
		||	<BINOPEQ>
		||	<AT>
		||	<DOT>
		||	<DOTDOT>
		||	<COMMA>
		||	<SEMI>
		||	<COLON>
		||	<MOD_SEP>
		||	<RARROW>
		||	<LARROW>
		||	<DARROW>
		||	<FAT_ARROW>
		||	<POUND>
		||	<DOLLAR>
		||	<LIT_INT>
		||	<LIT_FLOAT>
		||	<LIT_STR>
		||	<IDENT>
		||	<UNDERSCORE>
		||	<STATIC_LIFETIME>
		||	<LIFETIME>
		||	<OUTER_DOC_COMMENT>
		||	<INNER_DOC_COMMENT>
	}

	token AS {
		||	'as'
	}
	token BREAK {
		||	'break'
	}
	token CONST {
		||	'const'
	}
	token COPYTOK {
		||	'copy'
	}
	token DO {
		||	'do'
	}
	token DROP {
		||	'drop'
	}
	token ELSE {
		||	'else'
	}
	token ENUM {
		||	'enum'
	}
	token EXTERN {
		||	'extern'
	}
	token FALSE {
		||	'false'
	}
	token FN {
		||	'fn'
	}
	token FOR {
		||	'for'
	}
	token IF {
		||	'if'
	}
	token IMPL {
		||	'impl'
	}
	token LET {
		||	'let'
	}
	token LOG {
		||	'__log'
	}
	token LOOP {
		||	'loop'
	}
	token MATCH {
		||	'match'
	}
	token MOD {
		||	'mod'
	}
	token MUT {
		||	'mut'
	}
	token ONCE {
		||	'once'
	}
	token PRIV {
		||	'priv'
	}
	token PUB {
		||	'pub'
	}
	token PURE {
		||	'pure'
	}
	token REF {
		||	'ref'
	}
	token RETURN {
		||	'return'
	}
	token SELF {
		||	'self'
	}
	token STATIC {
		||	'static'
	}
	token STRUCT {
		||	'struct'
	}
	token TRUE {
		||	'true'
	}
	token TRAIT {
		||	'trait'
	}
	token TYPE {
		||	'type'
	}
	token UNSAFE {
		||	'unsafe'
	}
	token USE {
		||	'use'
	}
	token WHILE {
		||	'while'
	}
	token PLUS {
		||	'+'
	}
	token AND {
		||	'&'
	}
	token MINUS {
		||	'-'
	}
	token DIV {
		||	'/'
	}
	token REM {
		||	'%'
	}
	token CARET {
		||	'^'
	}
	token OR {
		||	'|'
	}
	token EQ {
		||	'='
	}
	token LE {
		||	'<='
	}
	token LT {
		||	'<'
	}
	token EQEQ {
		||	'=='
	}
	token NE {
		||	'!='
	}
	token GE {
		||	'>='
	}
	token GT {
		||	'>'
	}
	token NOT {
		||	'!'
	}
	token TILDE {
		||	'~'
	}
	token STAR {
		||	'*'
	}
	token BINOPEQ {
		||	'/='
		||	'%='
		||	'^='
		||	'|='
		||	'-='
		||	'*='
		||	'&='
		||	'+='
		||	'<<='
		||	'>>='
	}
	token AT {
		||	'@'
	}
	token DOT {
		||	'.'
	}
	token DOTDOT {
		||	'..'
	}
	token COMMA {
		||	','
	}
	token SEMI {
		||	';'
	}
	token COLON {
		||	':'
	}
	token MOD_SEP {
		||	'::'
	}
	token RARROW {
		||	'->'
	}
	token LARROW {
		||	'<-'
	}
	token DARROW {
		||	'<->'
	}
	token FAT_ARROW {
		||	'=>'
	}
	token LPAREN {
		||	'('
	}
	token RPAREN {
		||	')'
	}
	token LBRACKET {
		||	'['
	}
	token RBRACKET {
		||	'\]'
	}
	token LBRACE {
		||	'{'
	}
	token RBRACE {
		||	'}'
	}
	token POUND {
		||	'#'
	}
	token DOLLAR {
		||	'$'
	}

	token LIT_INT {
		||	<LIT_CHAR>
		||	'0x'
			<HEXDIGIT>+
			<INTLIT_TY>?
		||	'0b'
			<BINDIGIT>+
			<INTLIT_TY>?
		||	<DECDIGIT>
			<DECDIGIT_CONT>*
			<INTLIT_TY>?
	}
	token LIT_FLOAT {
		||	<DECDIGIT>
			<DECDIGIT_CONT>*
			'.'
			#|{!followed_by_ident_or_dot()}
		||	<DECDIGIT>
			<DECDIGIT_CONT>*
			'.'
			<DECDIGIT>
			<DECDIGIT_CONT>*
			<LITFLOAT_EXP>?
			<LITFLOAT_TY>?
		||	<DECDIGIT>
			<DECDIGIT_CONT>*
			<LITFLOAT_EXP>
			<LITFLOAT_TY>?
		||	<DECDIGIT>
			<DECDIGIT_CONT>*
			<LITFLOAT_TY>
	}
	token LIT_STR {
		||	'\"'
			<STRCHAR>*
			'\"'
	}
	token IDENT {
		||	<IDSTART>
			<IDCONT>*
	}
	token UNDERSCORE {
		||	'_'
	}
	token STATIC_LIFETIME {
		||	'\'static'
	}
	token LIFETIME {
		||	'\''
			<IDENT>
		||	'\''
			<SELF>
	}

	token OUTER_DOC_COMMENT {
		||	'///'
			'/'*
			<NON_SLASH_OR_WS>
			<-[ \n ]>*
		||	'///'
			'/'*
			<[   \r \t ]>
			<-[   \r \t ]>
			<-[ \n ]>*
		||	'///'
			<[   \t ]>*
		||	'/**'
			(	||	<-[ * ]>
				||	(	||	'*'+
							<-[ * / ]>
					)
			)
			<-[ * ]>
			(	||	<-[ * ]>
				||	(	||	'*'+
							<-[ * / ]>
					)
			)
			'*'+
			'/'
	}
	token INNER_DOC_COMMENT {
		||	'//!'
			<-[ \n ]>*
		||	'/*!'
			(	||	<-[ * ]>
				||	(	||	'*'+
							<-[ * / ]>
					)
			)*
			'*'+
			'/'
	}
	token WS {
		||	<[   \t \r \n ]>+
	}
	token OTHER_LINE_COMMENT {
		||	'//'
			<-[ \n ]>*
	}
	token OTHER_BLOCK_COMMENT {
		||	'/*'
			(	||	<-[ * ]>
				||	(	||	'*'+
							<-[ * / ]>
					)
			)
			'*'+
			'/'
	}
	token SHEBANG_LINE {
		||	#|{at_beginning_of_file()}?
			'#!'
			<-[ \n ]>*
			'\n'
	}
	token BINDIGIT {
		||	<[ 0 .. 1 ]>
	}
	token DECDIGIT {
		||	<[ 0 .. 9 ]>
	}
	token DECDIGIT_CONT {
		||	<[ 0 .. 9 ]>
	}
	token HEXDIGIT {
		||	<[ 0 .. 9 ]>
	}
	token INTLIT_TY {
		||	(	||	'u'
				||	'i'
			)
			(	||	'8'
				||	'16'
				||	'32'
				||	'64'
			)?
	}
	token LITFLOAT_EXP {
		||	<[ e E ]>
			<[ + - ]>?
			<DECDIGIT_CONT>+
	}
	token LITFLOAT_TY {
		||	'f'
			(	||	'32'
				||	'64'
			)?
	}
	token ESCAPEDCHAR {
		||	'n'
		||	'r'
		||	't'
		||	'\\'
		||	'\''
		||	'\"'
		||	'x'
			<HEXDIGIT>
			<HEXDIGIT>
		||	'u'
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
		||	'U'
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
			<HEXDIGIT>
	}

	token LIT_CHAR {
		||	'\'\\'
			<ESCAPEDCHAR>
			'\''
		||	'\''
			.
			'\''
	}

	token STRCHAR {
		||	<-[ \\ " ]>
		||	'\\'
			<STRESCAPE>
	}

	token STRESCAPE {
		||	'\n'
		||	<ESCAPEDCHAR>
	}

	token IDSTART {
		||	<[ _ a-z A-Z ]>
		||	<XIDSTART>
	}

	token IDCONT {
		||	<[ _ a-z A-Z 0-9 ]>
		||	<XIDCONT>
	}

	token NON_SLASH_OR_WS {
		||	<-[   \t \r \n / ]>
	}

	token XIDCONT {
		||	<[ \x[0030] .. \x[0039] ]>
		||	<[ \x[0041] .. \x[005a] ]>
		||	'\x[005f]'
		||	<[ \x[0061] .. \x[007a] ]>
		||	'\x[00aa]'
		||	'\x[00b5]'
		||	'\x[00b7]'
		||	'\x[00ba]'
		||	<[ \x[00c0] .. \x[00d6] ]>
		||	<[ \x[00d8] .. \x[00f6] ]>
		||	<[ \x[00f8] .. \x[01ba] ]>
		||	'\x[01bb]'
		||	<[ \x[01bc] .. \x[01bf] ]>
		||	<[ \x[01c0] .. \x[01c3] ]>
		||	<[ \x[01c4] .. \x[0293] ]>
		||	'\x[0294]'
		||	<[ \x[0295] .. \x[02af] ]>
		||	<[ \x[02b0] .. \x[02c1] ]>
		||	<[ \x[02c6] .. \x[02d1] ]>
		||	<[ \x[02e0] .. \x[02e4] ]>
		||	'\x[02ec]'
		||	'\x[02ee]'
		||	<[ \x[0300] .. \x[036f] ]>
		||	<[ \x[0370] .. \x[0373] ]>
		||	'\x[0374]'
		||	<[ \x[0376] .. \x[0377] ]>
		||	<[ \x[037b] .. \x[037d] ]>
		||	'\x[0386]'
		||	'\x[0387]'
		||	<[ \x[0388] .. \x[038a] ]>
		||	'\x[038c]'
		||	<[ \x[038e] .. \x[03a1] ]>
		||	<[ \x[03a3] .. \x[03f5] ]>
		||	<[ \x[03f7] .. \x[0481] ]>
		||	<[ \x[0483] .. \x[0487] ]>
		||	<[ \x[048a] .. \x[0527] ]>
		||	<[ \x[0531] .. \x[0556] ]>
		||	'\x[0559]'
		||	<[ \x[0561] .. \x[0587] ]>
		||	<[ \x[0591] .. \x[05bd] ]>
		||	'\x[05bf]'
		||	<[ \x[05c1] .. \x[05c2] ]>
		||	<[ \x[05c4] .. \x[05c5] ]>
		||	'\x[05c7]'
		||	<[ \x[05d0] .. \x[05ea] ]>
		||	<[ \x[05f0] .. \x[05f2] ]>
		||	<[ \x[0610] .. \x[061a] ]>
		||	<[ \x[0620] .. \x[063f] ]>
		||	'\x[0640]'
		||	<[ \x[0641] .. \x[064a] ]>
		||	<[ \x[064b] .. \x[065f] ]>
		||	<[ \x[0660] .. \x[0669] ]>
		||	<[ \x[066e] .. \x[066f] ]>
		||	'\x[0670]'
		||	<[ \x[0671] .. \x[06d3] ]>
		||	'\x[06d5]'
		||	<[ \x[06d6] .. \x[06dc] ]>
		||	<[ \x[06df] .. \x[06e4] ]>
		||	<[ \x[06e5] .. \x[06e6] ]>
		||	<[ \x[06e7] .. \x[06e8] ]>
		||	<[ \x[06ea] .. \x[06ed] ]>
		||	<[ \x[06ee] .. \x[06ef] ]>
		||	<[ \x[06f0] .. \x[06f9] ]>
		||	<[ \x[06fa] .. \x[06fc] ]>
		||	'\x[06ff]'
		||	'\x[0710]'
		||	'\x[0711]'
		||	<[ \x[0712] .. \x[072f] ]>
		||	<[ \x[0730] .. \x[074a] ]>
		||	<[ \x[074d] .. \x[07a5] ]>
		||	<[ \x[07a6] .. \x[07b0] ]>
		||	'\x[07b1]'
		||	<[ \x[07c0] .. \x[07c9] ]>
		||	<[ \x[07ca] .. \x[07ea] ]>
		||	<[ \x[07eb] .. \x[07f3] ]>
		||	<[ \x[07f4] .. \x[07f5] ]>
		||	'\x[07fa]'
		||	<[ \x[0800] .. \x[0815] ]>
		||	<[ \x[0816] .. \x[0819] ]>
		||	'\x[081a]'
		||	<[ \x[081b] .. \x[0823] ]>
		||	'\x[0824]'
		||	<[ \x[0825] .. \x[0827] ]>
		||	'\x[0828]'
		||	<[ \x[0829] .. \x[082d] ]>
		||	<[ \x[0840] .. \x[0858] ]>
		||	<[ \x[0859] .. \x[085b] ]>
		||	<[ \x[0900] .. \x[0902] ]>
		||	'\x[0903]'
		||	<[ \x[0904] .. \x[0939] ]>
		||	'\x[093a]'
		||	'\x[093b]'
		||	'\x[093c]'
		||	'\x[093d]'
		||	<[ \x[093e] .. \x[0940] ]>
		||	<[ \x[0941] .. \x[0948] ]>
		||	<[ \x[0949] .. \x[094c] ]>
		||	'\x[094d]'
		||	<[ \x[094e] .. \x[094f] ]>
		||	'\x[0950]'
		||	<[ \x[0951] .. \x[0957] ]>
		||	<[ \x[0958] .. \x[0961] ]>
		||	<[ \x[0962] .. \x[0963] ]>
		||	<[ \x[0966] .. \x[096f] ]>
		||	'\x[0971]'
		||	<[ \x[0972] .. \x[0977] ]>
		||	<[ \x[0979] .. \x[097f] ]>
		||	'\x[0981]'
		||	<[ \x[0982] .. \x[0983] ]>
		||	<[ \x[0985] .. \x[098c] ]>
		||	<[ \x[098f] .. \x[0990] ]>
		||	<[ \x[0993] .. \x[09a8] ]>
		||	<[ \x[09aa] .. \x[09b0] ]>
		||	'\x[09b2]'
		||	<[ \x[09b6] .. \x[09b9] ]>
		||	'\x[09bc]'
		||	'\x[09bd]'
		||	<[ \x[09be] .. \x[09c0] ]>
		||	<[ \x[09c1] .. \x[09c4] ]>
		||	<[ \x[09c7] .. \x[09c8] ]>
		||	<[ \x[09cb] .. \x[09cc] ]>
		||	'\x[09cd]'
		||	'\x[09ce]'
		||	'\x[09d7]'
		||	<[ \x[09dc] .. \x[09dd] ]>
		||	<[ \x[09df] .. \x[09e1] ]>
		||	<[ \x[09e2] .. \x[09e3] ]>
		||	<[ \x[09e6] .. \x[09ef] ]>
		||	<[ \x[09f0] .. \x[09f1] ]>
		||	<[ \x[0a01] .. \x[0a02] ]>
		||	'\x[0a03]'
		||	<[ \x[0a05] .. \x[0a0a] ]>
		||	<[ \x[0a0f] .. \x[0a10] ]>
		||	<[ \x[0a13] .. \x[0a28] ]>
		||	<[ \x[0a2a] .. \x[0a30] ]>
		||	<[ \x[0a32] .. \x[0a33] ]>
		||	<[ \x[0a35] .. \x[0a36] ]>
		||	<[ \x[0a38] .. \x[0a39] ]>
		||	'\x[0a3c]'
		||	<[ \x[0a3e] .. \x[0a40] ]>
		||	<[ \x[0a41] .. \x[0a42] ]>
		||	<[ \x[0a47] .. \x[0a48] ]>
		||	<[ \x[0a4b] .. \x[0a4d] ]>
		||	'\x[0a51]'
		||	<[ \x[0a59] .. \x[0a5c] ]>
		||	'\x[0a5e]'
		||	<[ \x[0a66] .. \x[0a6f] ]>
		||	<[ \x[0a70] .. \x[0a71] ]>
		||	<[ \x[0a72] .. \x[0a74] ]>
		||	'\x[0a75]'
		||	<[ \x[0a81] .. \x[0a82] ]>
		||	'\x[0a83]'
		||	<[ \x[0a85] .. \x[0a8d] ]>
		||	<[ \x[0a8f] .. \x[0a91] ]>
		||	<[ \x[0a93] .. \x[0aa8] ]>
		||	<[ \x[0aaa] .. \x[0ab0] ]>
		||	<[ \x[0ab2] .. \x[0ab3] ]>
		||	<[ \x[0ab5] .. \x[0ab9] ]>
		||	'\x[0abc]'
		||	'\x[0abd]'
		||	<[ \x[0abe] .. \x[0ac0] ]>
		||	<[ \x[0ac1] .. \x[0ac5] ]>
		||	<[ \x[0ac7] .. \x[0ac8] ]>
		||	'\x[0ac9]'
		||	<[ \x[0acb] .. \x[0acc] ]>
		||	'\x[0acd]'
		||	'\x[0ad0]'
		||	<[ \x[0ae0] .. \x[0ae1] ]>
		||	<[ \x[0ae2] .. \x[0ae3] ]>
		||	<[ \x[0ae6] .. \x[0aef] ]>
		||	'\x[0b01]'
		||	<[ \x[0b02] .. \x[0b03] ]>
		||	<[ \x[0b05] .. \x[0b0c] ]>
		||	<[ \x[0b0f] .. \x[0b10] ]>
		||	<[ \x[0b13] .. \x[0b28] ]>
		||	<[ \x[0b2a] .. \x[0b30] ]>
		||	<[ \x[0b32] .. \x[0b33] ]>
		||	<[ \x[0b35] .. \x[0b39] ]>
		||	'\x[0b3c]'
		||	'\x[0b3d]'
		||	'\x[0b3e]'
		||	'\x[0b3f]'
		||	'\x[0b40]'
		||	<[ \x[0b41] .. \x[0b44] ]>
		||	<[ \x[0b47] .. \x[0b48] ]>
		||	<[ \x[0b4b] .. \x[0b4c] ]>
		||	'\x[0b4d]'
		||	'\x[0b56]'
		||	'\x[0b57]'
		||	<[ \x[0b5c] .. \x[0b5d] ]>
		||	<[ \x[0b5f] .. \x[0b61] ]>
		||	<[ \x[0b62] .. \x[0b63] ]>
		||	<[ \x[0b66] .. \x[0b6f] ]>
		||	'\x[0b71]'
		||	'\x[0b82]'
		||	'\x[0b83]'
		||	<[ \x[0b85] .. \x[0b8a] ]>
		||	<[ \x[0b8e] .. \x[0b90] ]>
		||	<[ \x[0b92] .. \x[0b95] ]>
		||	<[ \x[0b99] .. \x[0b9a] ]>
		||	'\x[0b9c]'
		||	<[ \x[0b9e] .. \x[0b9f] ]>
		||	<[ \x[0ba3] .. \x[0ba4] ]>
		||	<[ \x[0ba8] .. \x[0baa] ]>
		||	<[ \x[0bae] .. \x[0bb9] ]>
		||	<[ \x[0bbe] .. \x[0bbf] ]>
		||	'\x[0bc0]'
		||	<[ \x[0bc1] .. \x[0bc2] ]>
		||	<[ \x[0bc6] .. \x[0bc8] ]>
		||	<[ \x[0bca] .. \x[0bcc] ]>
		||	'\x[0bcd]'
		||	'\x[0bd0]'
		||	'\x[0bd7]'
		||	<[ \x[0be6] .. \x[0bef] ]>
		||	<[ \x[0c01] .. \x[0c03] ]>
		||	<[ \x[0c05] .. \x[0c0c] ]>
		||	<[ \x[0c0e] .. \x[0c10] ]>
		||	<[ \x[0c12] .. \x[0c28] ]>
		||	<[ \x[0c2a] .. \x[0c33] ]>
		||	<[ \x[0c35] .. \x[0c39] ]>
		||	'\x[0c3d]'
		||	<[ \x[0c3e] .. \x[0c40] ]>
		||	<[ \x[0c41] .. \x[0c44] ]>
		||	<[ \x[0c46] .. \x[0c48] ]>
		||	<[ \x[0c4a] .. \x[0c4d] ]>
		||	<[ \x[0c55] .. \x[0c56] ]>
		||	<[ \x[0c58] .. \x[0c59] ]>
		||	<[ \x[0c60] .. \x[0c61] ]>
		||	<[ \x[0c62] .. \x[0c63] ]>
		||	<[ \x[0c66] .. \x[0c6f] ]>
		||	<[ \x[0c82] .. \x[0c83] ]>
		||	<[ \x[0c85] .. \x[0c8c] ]>
		||	<[ \x[0c8e] .. \x[0c90] ]>
		||	<[ \x[0c92] .. \x[0ca8] ]>
		||	<[ \x[0caa] .. \x[0cb3] ]>
		||	<[ \x[0cb5] .. \x[0cb9] ]>
		||	'\x[0cbc]'
		||	'\x[0cbd]'
		||	'\x[0cbe]'
		||	'\x[0cbf]'
		||	<[ \x[0cc0] .. \x[0cc4] ]>
		||	'\x[0cc6]'
		||	<[ \x[0cc7] .. \x[0cc8] ]>
		||	<[ \x[0cca] .. \x[0ccb] ]>
		||	<[ \x[0ccc] .. \x[0ccd] ]>
		||	<[ \x[0cd5] .. \x[0cd6] ]>
		||	'\x[0cde]'
		||	<[ \x[0ce0] .. \x[0ce1] ]>
		||	<[ \x[0ce2] .. \x[0ce3] ]>
		||	<[ \x[0ce6] .. \x[0cef] ]>
		||	<[ \x[0cf1] .. \x[0cf2] ]>
		||	<[ \x[0d02] .. \x[0d03] ]>
		||	<[ \x[0d05] .. \x[0d0c] ]>
		||	<[ \x[0d0e] .. \x[0d10] ]>
		||	<[ \x[0d12] .. \x[0d3a] ]>
		||	'\x[0d3d]'
		||	<[ \x[0d3e] .. \x[0d40] ]>
		||	<[ \x[0d41] .. \x[0d44] ]>
		||	<[ \x[0d46] .. \x[0d48] ]>
		||	<[ \x[0d4a] .. \x[0d4c] ]>
		||	'\x[0d4d]'
		||	'\x[0d4e]'
		||	'\x[0d57]'
		||	<[ \x[0d60] .. \x[0d61] ]>
		||	<[ \x[0d62] .. \x[0d63] ]>
		||	<[ \x[0d66] .. \x[0d6f] ]>
		||	<[ \x[0d7a] .. \x[0d7f] ]>
		||	<[ \x[0d82] .. \x[0d83] ]>
		||	<[ \x[0d85] .. \x[0d96] ]>
		||	<[ \x[0d9a] .. \x[0db1] ]>
		||	<[ \x[0db3] .. \x[0dbb] ]>
		||	'\x[0dbd]'
		||	<[ \x[0dc0] .. \x[0dc6] ]>
		||	'\x[0dca]'
		||	<[ \x[0dcf] .. \x[0dd1] ]>
		||	<[ \x[0dd2] .. \x[0dd4] ]>
		||	'\x[0dd6]'
		||	<[ \x[0dd8] .. \x[0ddf] ]>
		||	<[ \x[0df2] .. \x[0df3] ]>
		||	<[ \x[0e01] .. \x[0e30] ]>
		||	'\x[0e31]'
		||	<[ \x[0e32] .. \x[0e33] ]>
		||	<[ \x[0e34] .. \x[0e3a] ]>
		||	<[ \x[0e40] .. \x[0e45] ]>
		||	'\x[0e46]'
		||	<[ \x[0e47] .. \x[0e4e] ]>
		||	<[ \x[0e50] .. \x[0e59] ]>
		||	<[ \x[0e81] .. \x[0e82] ]>
		||	'\x[0e84]'
		||	<[ \x[0e87] .. \x[0e88] ]>
		||	'\x[0e8a]'
		||	'\x[0e8d]'
		||	<[ \x[0e94] .. \x[0e97] ]>
		||	<[ \x[0e99] .. \x[0e9f] ]>
		||	<[ \x[0ea1] .. \x[0ea3] ]>
		||	'\x[0ea5]'
		||	'\x[0ea7]'
		||	<[ \x[0eaa] .. \x[0eab] ]>
		||	<[ \x[0ead] .. \x[0eb0] ]>
		||	'\x[0eb1]'
		||	<[ \x[0eb2] .. \x[0eb3] ]>
		||	<[ \x[0eb4] .. \x[0eb9] ]>
		||	<[ \x[0ebb] .. \x[0ebc] ]>
		||	'\x[0ebd]'
		||	<[ \x[0ec0] .. \x[0ec4] ]>
		||	'\x[0ec6]'
		||	<[ \x[0ec8] .. \x[0ecd] ]>
		||	<[ \x[0ed0] .. \x[0ed9] ]>
		||	<[ \x[0edc] .. \x[0edd] ]>
		||	'\x[0f00]'
		||	<[ \x[0f18] .. \x[0f19] ]>
		||	<[ \x[0f20] .. \x[0f29] ]>
		||	'\x[0f35]'
		||	'\x[0f37]'
		||	'\x[0f39]'
		||	<[ \x[0f3e] .. \x[0f3f] ]>
		||	<[ \x[0f40] .. \x[0f47] ]>
		||	<[ \x[0f49] .. \x[0f6c] ]>
		||	<[ \x[0f71] .. \x[0f7e] ]>
		||	'\x[0f7f]'
		||	<[ \x[0f80] .. \x[0f84] ]>
		||	<[ \x[0f86] .. \x[0f87] ]>
		||	<[ \x[0f88] .. \x[0f8c] ]>
		||	<[ \x[0f8d] .. \x[0f97] ]>
		||	<[ \x[0f99] .. \x[0fbc] ]>
		||	'\x[0fc6]'
		||	<[ \x[1000] .. \x[102a] ]>
		||	<[ \x[102b] .. \x[102c] ]>
		||	<[ \x[102d] .. \x[1030] ]>
		||	'\x[1031]'
		||	<[ \x[1032] .. \x[1037] ]>
		||	'\x[1038]'
		||	<[ \x[1039] .. \x[103a] ]>
		||	<[ \x[103b] .. \x[103c] ]>
		||	<[ \x[103d] .. \x[103e] ]>
		||	'\x[103f]'
		||	<[ \x[1040] .. \x[1049] ]>
		||	<[ \x[1050] .. \x[1055] ]>
		||	<[ \x[1056] .. \x[1057] ]>
		||	<[ \x[1058] .. \x[1059] ]>
		||	<[ \x[105a] .. \x[105d] ]>
		||	<[ \x[105e] .. \x[1060] ]>
		||	'\x[1061]'
		||	<[ \x[1062] .. \x[1064] ]>
		||	<[ \x[1065] .. \x[1066] ]>
		||	<[ \x[1067] .. \x[106d] ]>
		||	<[ \x[106e] .. \x[1070] ]>
		||	<[ \x[1071] .. \x[1074] ]>
		||	<[ \x[1075] .. \x[1081] ]>
		||	'\x[1082]'
		||	<[ \x[1083] .. \x[1084] ]>
		||	<[ \x[1085] .. \x[1086] ]>
		||	<[ \x[1087] .. \x[108c] ]>
		||	'\x[108d]'
		||	'\x[108e]'
		||	'\x[108f]'
		||	<[ \x[1090] .. \x[1099] ]>
		||	<[ \x[109a] .. \x[109c] ]>
		||	'\x[109d]'
		||	<[ \x[10a0] .. \x[10c5] ]>
		||	<[ \x[10d0] .. \x[10fa] ]>
		||	'\x[10fc]'
		||	<[ \x[1100] .. \x[1248] ]>
		||	<[ \x[124a] .. \x[124d] ]>
		||	<[ \x[1250] .. \x[1256] ]>
		||	'\x[1258]'
		||	<[ \x[125a] .. \x[125d] ]>
		||	<[ \x[1260] .. \x[1288] ]>
		||	<[ \x[128a] .. \x[128d] ]>
		||	<[ \x[1290] .. \x[12b0] ]>
		||	<[ \x[12b2] .. \x[12b5] ]>
		||	<[ \x[12b8] .. \x[12be] ]>
		||	'\x[12c0]'
		||	<[ \x[12c2] .. \x[12c5] ]>
		||	<[ \x[12c8] .. \x[12d6] ]>
		||	<[ \x[12d8] .. \x[1310] ]>
		||	<[ \x[1312] .. \x[1315] ]>
		||	<[ \x[1318] .. \x[135a] ]>
		||	<[ \x[135d] .. \x[135f] ]>
		||	<[ \x[1369] .. \x[1371] ]>
		||	<[ \x[1380] .. \x[138f] ]>
		||	<[ \x[13a0] .. \x[13f4] ]>
		||	<[ \x[1401] .. \x[166c] ]>
		||	<[ \x[166f] .. \x[167f] ]>
		||	<[ \x[1681] .. \x[169a] ]>
		||	<[ \x[16a0] .. \x[16ea] ]>
		||	<[ \x[16ee] .. \x[16f0] ]>
		||	<[ \x[1700] .. \x[170c] ]>
		||	<[ \x[170e] .. \x[1711] ]>
		||	<[ \x[1712] .. \x[1714] ]>
		||	<[ \x[1720] .. \x[1731] ]>
		||	<[ \x[1732] .. \x[1734] ]>
		||	<[ \x[1740] .. \x[1751] ]>
		||	<[ \x[1752] .. \x[1753] ]>
		||	<[ \x[1760] .. \x[176c] ]>
		||	<[ \x[176e] .. \x[1770] ]>
		||	<[ \x[1772] .. \x[1773] ]>
		||	<[ \x[1780] .. \x[17b3] ]>
		||	'\x[17b6]'
		||	<[ \x[17b7] .. \x[17bd] ]>
		||	<[ \x[17be] .. \x[17c5] ]>
		||	'\x[17c6]'
		||	<[ \x[17c7] .. \x[17c8] ]>
		||	<[ \x[17c9] .. \x[17d3] ]>
		||	'\x[17d7]'
		||	'\x[17dc]'
		||	'\x[17dd]'
		||	<[ \x[17e0] .. \x[17e9] ]>
		||	<[ \x[180b] .. \x[180d] ]>
		||	<[ \x[1810] .. \x[1819] ]>
		||	<[ \x[1820] .. \x[1842] ]>
		||	'\x[1843]'
		||	<[ \x[1844] .. \x[1877] ]>
		||	<[ \x[1880] .. \x[18a8] ]>
		||	'\x[18a9]'
		||	'\x[18aa]'
		||	<[ \x[18b0] .. \x[18f5] ]>
		||	<[ \x[1900] .. \x[191c] ]>
		||	<[ \x[1920] .. \x[1922] ]>
		||	<[ \x[1923] .. \x[1926] ]>
		||	<[ \x[1927] .. \x[1928] ]>
		||	<[ \x[1929] .. \x[192b] ]>
		||	<[ \x[1930] .. \x[1931] ]>
		||	'\x[1932]'
		||	<[ \x[1933] .. \x[1938] ]>
		||	<[ \x[1939] .. \x[193b] ]>
		||	<[ \x[1946] .. \x[194f] ]>
		||	<[ \x[1950] .. \x[196d] ]>
		||	<[ \x[1970] .. \x[1974] ]>
		||	<[ \x[1980] .. \x[19ab] ]>
		||	<[ \x[19b0] .. \x[19c0] ]>
		||	<[ \x[19c1] .. \x[19c7] ]>
		||	<[ \x[19c8] .. \x[19c9] ]>
		||	<[ \x[19d0] .. \x[19d9] ]>
		||	'\x[19da]'
		||	<[ \x[1a00] .. \x[1a16] ]>
		||	<[ \x[1a17] .. \x[1a18] ]>
		||	<[ \x[1a19] .. \x[1a1b] ]>
		||	<[ \x[1a20] .. \x[1a54] ]>
		||	'\x[1a55]'
		||	'\x[1a56]'
		||	'\x[1a57]'
		||	<[ \x[1a58] .. \x[1a5e] ]>
		||	'\x[1a60]'
		||	'\x[1a61]'
		||	'\x[1a62]'
		||	<[ \x[1a63] .. \x[1a64] ]>
		||	<[ \x[1a65] .. \x[1a6c] ]>
		||	<[ \x[1a6d] .. \x[1a72] ]>
		||	<[ \x[1a73] .. \x[1a7c] ]>
		||	'\x[1a7f]'
		||	<[ \x[1a80] .. \x[1a89] ]>
		||	<[ \x[1a90] .. \x[1a99] ]>
		||	'\x[1aa7]'
		||	<[ \x[1b00] .. \x[1b03] ]>
		||	'\x[1b04]'
		||	<[ \x[1b05] .. \x[1b33] ]>
		||	'\x[1b34]'
		||	'\x[1b35]'
		||	<[ \x[1b36] .. \x[1b3a] ]>
		||	'\x[1b3b]'
		||	'\x[1b3c]'
		||	<[ \x[1b3d] .. \x[1b41] ]>
		||	'\x[1b42]'
		||	<[ \x[1b43] .. \x[1b44] ]>
		||	<[ \x[1b45] .. \x[1b4b] ]>
		||	<[ \x[1b50] .. \x[1b59] ]>
		||	<[ \x[1b6b] .. \x[1b73] ]>
		||	<[ \x[1b80] .. \x[1b81] ]>
		||	'\x[1b82]'
		||	<[ \x[1b83] .. \x[1ba0] ]>
		||	'\x[1ba1]'
		||	<[ \x[1ba2] .. \x[1ba5] ]>
		||	<[ \x[1ba6] .. \x[1ba7] ]>
		||	<[ \x[1ba8] .. \x[1ba9] ]>
		||	'\x[1baa]'
		||	<[ \x[1bae] .. \x[1baf] ]>
		||	<[ \x[1bb0] .. \x[1bb9] ]>
		||	<[ \x[1bc0] .. \x[1be5] ]>
		||	'\x[1be6]'
		||	'\x[1be7]'
		||	<[ \x[1be8] .. \x[1be9] ]>
		||	<[ \x[1bea] .. \x[1bec] ]>
		||	'\x[1bed]'
		||	'\x[1bee]'
		||	<[ \x[1bef] .. \x[1bf1] ]>
		||	<[ \x[1bf2] .. \x[1bf3] ]>
		||	<[ \x[1c00] .. \x[1c23] ]>
		||	<[ \x[1c24] .. \x[1c2b] ]>
		||	<[ \x[1c2c] .. \x[1c33] ]>
		||	<[ \x[1c34] .. \x[1c35] ]>
		||	<[ \x[1c36] .. \x[1c37] ]>
		||	<[ \x[1c40] .. \x[1c49] ]>
		||	<[ \x[1c4d] .. \x[1c4f] ]>
		||	<[ \x[1c50] .. \x[1c59] ]>
		||	<[ \x[1c5a] .. \x[1c77] ]>
		||	<[ \x[1c78] .. \x[1c7d] ]>
		||	<[ \x[1cd0] .. \x[1cd2] ]>
		||	<[ \x[1cd4] .. \x[1ce0] ]>
		||	'\x[1ce1]'
		||	<[ \x[1ce2] .. \x[1ce8] ]>
		||	<[ \x[1ce9] .. \x[1cec] ]>
		||	'\x[1ced]'
		||	<[ \x[1cee] .. \x[1cf1] ]>
		||	'\x[1cf2]'
		||	<[ \x[1d00] .. \x[1d2b] ]>
		||	<[ \x[1d2c] .. \x[1d61] ]>
		||	<[ \x[1d62] .. \x[1d77] ]>
		||	'\x[1d78]'
		||	<[ \x[1d79] .. \x[1d9a] ]>
		||	<[ \x[1d9b] .. \x[1dbf] ]>
		||	<[ \x[1dc0] .. \x[1de6] ]>
		||	<[ \x[1dfc] .. \x[1dff] ]>
		||	<[ \x[1e00] .. \x[1f15] ]>
		||	<[ \x[1f18] .. \x[1f1d] ]>
		||	<[ \x[1f20] .. \x[1f45] ]>
		||	<[ \x[1f48] .. \x[1f4d] ]>
		||	<[ \x[1f50] .. \x[1f57] ]>
		||	'\x[1f59]'
		||	'\x[1f5b]'
		||	'\x[1f5d]'
		||	<[ \x[1f5f] .. \x[1f7d] ]>
		||	<[ \x[1f80] .. \x[1fb4] ]>
		||	<[ \x[1fb6] .. \x[1fbc] ]>
		||	'\x[1fbe]'
		||	<[ \x[1fc2] .. \x[1fc4] ]>
		||	<[ \x[1fc6] .. \x[1fcc] ]>
		||	<[ \x[1fd0] .. \x[1fd3] ]>
		||	<[ \x[1fd6] .. \x[1fdb] ]>
		||	<[ \x[1fe0] .. \x[1fec] ]>
		||	<[ \x[1ff2] .. \x[1ff4] ]>
		||	<[ \x[1ff6] .. \x[1ffc] ]>
		||	<[ \x[203f] .. \x[2040] ]>
		||	'\x[2054]'
		||	'\x[2071]'
		||	'\x[207f]'
		||	<[ \x[2090] .. \x[209c] ]>
		||	<[ \x[20d0] .. \x[20dc] ]>
		||	'\x[20e1]'
		||	<[ \x[20e5] .. \x[20f0] ]>
		||	'\x[2102]'
		||	'\x[2107]'
		||	<[ \x[210a] .. \x[2113] ]>
		||	'\x[2115]'
		||	'\x[2118]'
		||	<[ \x[2119] .. \x[211d] ]>
		||	'\x[2124]'
		||	'\x[2126]'
		||	'\x[2128]'
		||	<[ \x[212a] .. \x[212d] ]>
		||	'\x[212e]'
		||	<[ \x[212f] .. \x[2134] ]>
		||	<[ \x[2135] .. \x[2138] ]>
		||	'\x[2139]'
		||	<[ \x[213c] .. \x[213f] ]>
		||	<[ \x[2145] .. \x[2149] ]>
		||	'\x[214e]'
		||	<[ \x[2160] .. \x[2182] ]>
		||	<[ \x[2183] .. \x[2184] ]>
		||	<[ \x[2185] .. \x[2188] ]>
		||	<[ \x[2c00] .. \x[2c2e] ]>
		||	<[ \x[2c30] .. \x[2c5e] ]>
		||	<[ \x[2c60] .. \x[2c7c] ]>
		||	'\x[2c7d]'
		||	<[ \x[2c7e] .. \x[2ce4] ]>
		||	<[ \x[2ceb] .. \x[2cee] ]>
		||	<[ \x[2cef] .. \x[2cf1] ]>
		||	<[ \x[2d00] .. \x[2d25] ]>
		||	<[ \x[2d30] .. \x[2d65] ]>
		||	'\x[2d6f]'
		||	'\x[2d7f]'
		||	<[ \x[2d80] .. \x[2d96] ]>
		||	<[ \x[2da0] .. \x[2da6] ]>
		||	<[ \x[2da8] .. \x[2dae] ]>
		||	<[ \x[2db0] .. \x[2db6] ]>
		||	<[ \x[2db8] .. \x[2dbe] ]>
		||	<[ \x[2dc0] .. \x[2dc6] ]>
		||	<[ \x[2dc8] .. \x[2dce] ]>
		||	<[ \x[2dd0] .. \x[2dd6] ]>
		||	<[ \x[2dd8] .. \x[2dde] ]>
		||	<[ \x[2de0] .. \x[2dff] ]>
		||	'\x[3005]'
		||	'\x[3006]'
		||	'\x[3007]'
		||	<[ \x[3021] .. \x[3029] ]>
		||	<[ \x[302a] .. \x[302f] ]>
		||	<[ \x[3031] .. \x[3035] ]>
		||	<[ \x[3038] .. \x[303a] ]>
		||	'\x[303b]'
		||	'\x[303c]'
		||	<[ \x[3041] .. \x[3096] ]>
		||	<[ \x[3099] .. \x[309a] ]>
		||	<[ \x[309d] .. \x[309e] ]>
		||	'\x[309f]'
		||	<[ \x[30a1] .. \x[30fa] ]>
		||	<[ \x[30fc] .. \x[30fe] ]>
		||	'\x[30ff]'
		||	<[ \x[3105] .. \x[312d] ]>
		||	<[ \x[3131] .. \x[318e] ]>
		||	<[ \x[31a0] .. \x[31ba] ]>
		||	<[ \x[31f0] .. \x[31ff] ]>
		||	<[ \x[3400] .. \x[4db5] ]>
		||	<[ \x[4e00] .. \x[9fcb] ]>
		||	<[ \x[a000] .. \x[a014] ]>
		||	'\x[a015]'
		||	<[ \x[a016] .. \x[a48c] ]>
		||	<[ \x[a4d0] .. \x[a4f7] ]>
		||	<[ \x[a4f8] .. \x[a4fd] ]>
		||	<[ \x[a500] .. \x[a60b] ]>
		||	'\x[a60c]'
		||	<[ \x[a610] .. \x[a61f] ]>
		||	<[ \x[a620] .. \x[a629] ]>
		||	<[ \x[a62a] .. \x[a62b] ]>
		||	<[ \x[a640] .. \x[a66d] ]>
		||	'\x[a66e]'
		||	'\x[a66f]'
		||	<[ \x[a67c] .. \x[a67d] ]>
		||	'\x[a67f]'
		||	<[ \x[a680] .. \x[a697] ]>
		||	<[ \x[a6a0] .. \x[a6e5] ]>
		||	<[ \x[a6e6] .. \x[a6ef] ]>
		||	<[ \x[a6f0] .. \x[a6f1] ]>
		||	<[ \x[a717] .. \x[a71f] ]>
		||	<[ \x[a722] .. \x[a76f] ]>
		||	'\x[a770]'
		||	<[ \x[a771] .. \x[a787] ]>
		||	'\x[a788]'
		||	<[ \x[a78b] .. \x[a78e] ]>
		||	<[ \x[a790] .. \x[a791] ]>
		||	<[ \x[a7a0] .. \x[a7a9] ]>
		||	'\x[a7fa]'
		||	<[ \x[a7fb] .. \x[a801] ]>
		||	'\x[a802]'
		||	<[ \x[a803] .. \x[a805] ]>
		||	'\x[a806]'
		||	<[ \x[a807] .. \x[a80a] ]>
		||	'\x[a80b]'
		||	<[ \x[a80c] .. \x[a822] ]>
		||	<[ \x[a823] .. \x[a824] ]>
		||	<[ \x[a825] .. \x[a826] ]>
		||	'\x[a827]'
		||	<[ \x[a840] .. \x[a873] ]>
		||	<[ \x[a880] .. \x[a881] ]>
		||	<[ \x[a882] .. \x[a8b3] ]>
		||	<[ \x[a8b4] .. \x[a8c3] ]>
		||	'\x[a8c4]'
		||	<[ \x[a8d0] .. \x[a8d9] ]>
		||	<[ \x[a8e0] .. \x[a8f1] ]>
		||	<[ \x[a8f2] .. \x[a8f7] ]>
		||	'\x[a8fb]'
		||	<[ \x[a900] .. \x[a909] ]>
		||	<[ \x[a90a] .. \x[a925] ]>
		||	<[ \x[a926] .. \x[a92d] ]>
		||	<[ \x[a930] .. \x[a946] ]>
		||	<[ \x[a947] .. \x[a951] ]>
		||	<[ \x[a952] .. \x[a953] ]>
		||	<[ \x[a960] .. \x[a97c] ]>
		||	<[ \x[a980] .. \x[a982] ]>
		||	'\x[a983]'
		||	<[ \x[a984] .. \x[a9b2] ]>
		||	'\x[a9b3]'
		||	<[ \x[a9b4] .. \x[a9b5] ]>
		||	<[ \x[a9b6] .. \x[a9b9] ]>
		||	<[ \x[a9ba] .. \x[a9bb] ]>
		||	'\x[a9bc]'
		||	<[ \x[a9bd] .. \x[a9c0] ]>
		||	'\x[a9cf]'
		||	<[ \x[a9d0] .. \x[a9d9] ]>
		||	<[ \x[aa00] .. \x[aa28] ]>
		||	<[ \x[aa29] .. \x[aa2e] ]>
		||	<[ \x[aa2f] .. \x[aa30] ]>
		||	<[ \x[aa31] .. \x[aa32] ]>
		||	<[ \x[aa33] .. \x[aa34] ]>
		||	<[ \x[aa35] .. \x[aa36] ]>
		||	<[ \x[aa40] .. \x[aa42] ]>
		||	'\x[aa43]'
		||	<[ \x[aa44] .. \x[aa4b] ]>
		||	'\x[aa4c]'
		||	'\x[aa4d]'
		||	<[ \x[aa50] .. \x[aa59] ]>
		||	<[ \x[aa60] .. \x[aa6f] ]>
		||	'\x[aa70]'
		||	<[ \x[aa71] .. \x[aa76] ]>
		||	'\x[aa7a]'
		||	'\x[aa7b]'
		||	<[ \x[aa80] .. \x[aaaf] ]>
		||	'\x[aab0]'
		||	'\x[aab1]'
		||	<[ \x[aab2] .. \x[aab4] ]>
		||	<[ \x[aab5] .. \x[aab6] ]>
		||	<[ \x[aab7] .. \x[aab8] ]>
		||	<[ \x[aab9] .. \x[aabd] ]>
		||	<[ \x[aabe] .. \x[aabf] ]>
		||	'\x[aac0]'
		||	'\x[aac1]'
		||	'\x[aac2]'
		||	<[ \x[aadb] .. \x[aadc] ]>
		||	'\x[aadd]'
		||	<[ \x[ab01] .. \x[ab06] ]>
		||	<[ \x[ab09] .. \x[ab0e] ]>
		||	<[ \x[ab11] .. \x[ab16] ]>
		||	<[ \x[ab20] .. \x[ab26] ]>
		||	<[ \x[ab28] .. \x[ab2e] ]>
		||	<[ \x[abc0] .. \x[abe2] ]>
		||	<[ \x[abe3] .. \x[abe4] ]>
		||	'\x[abe5]'
		||	<[ \x[abe6] .. \x[abe7] ]>
		||	'\x[abe8]'
		||	<[ \x[abe9] .. \x[abea] ]>
		||	'\x[abec]'
		||	'\x[abed]'
		||	<[ \x[abf0] .. \x[abf9] ]>
		||	<[ \x[ac00] .. \x[d7a3] ]>
		||	<[ \x[d7b0] .. \x[d7c6] ]>
		||	<[ \x[d7cb] .. \x[d7fb] ]>
		||	<[ \x[f900] .. \x[fa2d] ]>
		||	<[ \x[fa30] .. \x[fa6d] ]>
		||	<[ \x[fa70] .. \x[fad9] ]>
		||	<[ \x[fb00] .. \x[fb06] ]>
		||	<[ \x[fb13] .. \x[fb17] ]>
		||	'\x[fb1d]'
		||	'\x[fb1e]'
		||	<[ \x[fb1f] .. \x[fb28] ]>
		||	<[ \x[fb2a] .. \x[fb36] ]>
		||	<[ \x[fb38] .. \x[fb3c] ]>
		||	'\x[fb3e]'
		||	<[ \x[fb40] .. \x[fb41] ]>
		||	<[ \x[fb43] .. \x[fb44] ]>
		||	<[ \x[fb46] .. \x[fbb1] ]>
		||	<[ \x[fbd3] .. \x[fc5d] ]>
		||	<[ \x[fc64] .. \x[fd3d] ]>
		||	<[ \x[fd50] .. \x[fd8f] ]>
		||	<[ \x[fd92] .. \x[fdc7] ]>
		||	<[ \x[fdf0] .. \x[fdf9] ]>
		||	<[ \x[fe00] .. \x[fe0f] ]>
		||	<[ \x[fe20] .. \x[fe26] ]>
		||	<[ \x[fe33] .. \x[fe34] ]>
		||	<[ \x[fe4d] .. \x[fe4f] ]>
		||	'\x[fe71]'
		||	'\x[fe73]'
		||	'\x[fe77]'
		||	'\x[fe79]'
		||	'\x[fe7b]'
		||	'\x[fe7d]'
		||	<[ \x[fe7f] .. \x[fefc] ]>
		||	<[ \x[ff10] .. \x[ff19] ]>
		||	<[ \x[ff21] .. \x[ff3a] ]>
		||	'\x[ff3f]'
		||	<[ \x[ff41] .. \x[ff5a] ]>
		||	<[ \x[ff66] .. \x[ff6f] ]>
		||	'\x[ff70]'
		||	<[ \x[ff71] .. \x[ff9d] ]>
		||	<[ \x[ff9e] .. \x[ff9f] ]>
		||	<[ \x[ffa0] .. \x[ffbe] ]>
		||	<[ \x[ffc2] .. \x[ffc7] ]>
		||	<[ \x[ffca] .. \x[ffcf] ]>
		||	<[ \x[ffd2] .. \x[ffd7] ]>
		||	<[ \x[ffda] .. \x[ffdc] ]>
		||	<[ \U00010000 .. \U0001000b ]>
		||	<[ \U0001000d .. \U00010026 ]>
		||	<[ \U00010028 .. \U0001003a ]>
		||	<[ \U0001003c .. \U0001003d ]>
		||	<[ \U0001003f .. \U0001004d ]>
		||	<[ \U00010050 .. \U0001005d ]>
		||	<[ \U00010080 .. \U000100fa ]>
		||	<[ \U00010140 .. \U00010174 ]>
		||	'\U000101fd'
		||	<[ \U00010280 .. \U0001029c ]>
		||	<[ \U000102a0 .. \U000102d0 ]>
		||	<[ \U00010300 .. \U0001031e ]>
		||	<[ \U00010330 .. \U00010340 ]>
		||	'\U00010341'
		||	<[ \U00010342 .. \U00010349 ]>
		||	'\U0001034a'
		||	<[ \U00010380 .. \U0001039d ]>
		||	<[ \U000103a0 .. \U000103c3 ]>
		||	<[ \U000103c8 .. \U000103cf ]>
		||	<[ \U000103d1 .. \U000103d5 ]>
		||	<[ \U00010400 .. \U0001044f ]>
		||	<[ \U00010450 .. \U0001049d ]>
		||	<[ \U000104a0 .. \U000104a9 ]>
		||	<[ \U00010800 .. \U00010805 ]>
		||	'\U00010808'
		||	<[ \U0001080a .. \U00010835 ]>
		||	<[ \U00010837 .. \U00010838 ]>
		||	'\U0001083c'
		||	<[ \U0001083f .. \U00010855 ]>
		||	<[ \U00010900 .. \U00010915 ]>
		||	<[ \U00010920 .. \U00010939 ]>
		||	'\U00010a00'
		||	<[ \U00010a01 .. \U00010a03 ]>
		||	<[ \U00010a05 .. \U00010a06 ]>
		||	<[ \U00010a0c .. \U00010a0f ]>
		||	<[ \U00010a10 .. \U00010a13 ]>
		||	<[ \U00010a15 .. \U00010a17 ]>
		||	<[ \U00010a19 .. \U00010a33 ]>
		||	<[ \U00010a38 .. \U00010a3a ]>
		||	'\U00010a3f'
		||	<[ \U00010a60 .. \U00010a7c ]>
		||	<[ \U00010b00 .. \U00010b35 ]>
		||	<[ \U00010b40 .. \U00010b55 ]>
		||	<[ \U00010b60 .. \U00010b72 ]>
		||	<[ \U00010c00 .. \U00010c48 ]>
		||	'\U00011000'
		||	'\U00011001'
		||	'\U00011002'
		||	<[ \U00011003 .. \U00011037 ]>
		||	<[ \U00011038 .. \U00011046 ]>
		||	<[ \U00011066 .. \U0001106f ]>
		||	<[ \U00011080 .. \U00011081 ]>
		||	'\U00011082'
		||	<[ \U00011083 .. \U000110af ]>
		||	<[ \U000110b0 .. \U000110b2 ]>
		||	<[ \U000110b3 .. \U000110b6 ]>
		||	<[ \U000110b7 .. \U000110b8 ]>
		||	<[ \U000110b9 .. \U000110ba ]>
		||	<[ \U00012000 .. \U0001236e ]>
		||	<[ \U00012400 .. \U00012462 ]>
		||	<[ \U00013000 .. \U0001342e ]>
		||	<[ \U00016800 .. \U00016a38 ]>
		||	<[ \U0001b000 .. \U0001b001 ]>
		||	<[ \U0001d165 .. \U0001d166 ]>
		||	<[ \U0001d167 .. \U0001d169 ]>
		||	<[ \U0001d16d .. \U0001d172 ]>
		||	<[ \U0001d17b .. \U0001d182 ]>
		||	<[ \U0001d185 .. \U0001d18b ]>
		||	<[ \U0001d1aa .. \U0001d1ad ]>
		||	<[ \U0001d242 .. \U0001d244 ]>
		||	<[ \U0001d400 .. \U0001d454 ]>
		||	<[ \U0001d456 .. \U0001d49c ]>
		||	<[ \U0001d49e .. \U0001d49f ]>
		||	'\U0001d4a2'
		||	<[ \U0001d4a5 .. \U0001d4a6 ]>
		||	<[ \U0001d4a9 .. \U0001d4ac ]>
		||	<[ \U0001d4ae .. \U0001d4b9 ]>
		||	'\U0001d4bb'
		||	<[ \U0001d4bd .. \U0001d4c3 ]>
		||	<[ \U0001d4c5 .. \U0001d505 ]>
		||	<[ \U0001d507 .. \U0001d50a ]>
		||	<[ \U0001d50d .. \U0001d514 ]>
		||	<[ \U0001d516 .. \U0001d51c ]>
		||	<[ \U0001d51e .. \U0001d539 ]>
		||	<[ \U0001d53b .. \U0001d53e ]>
		||	<[ \U0001d540 .. \U0001d544 ]>
		||	'\U0001d546'
		||	<[ \U0001d54a .. \U0001d550 ]>
		||	<[ \U0001d552 .. \U0001d6a5 ]>
		||	<[ \U0001d6a8 .. \U0001d6c0 ]>
		||	<[ \U0001d6c2 .. \U0001d6da ]>
		||	<[ \U0001d6dc .. \U0001d6fa ]>
		||	<[ \U0001d6fc .. \U0001d714 ]>
		||	<[ \U0001d716 .. \U0001d734 ]>
		||	<[ \U0001d736 .. \U0001d74e ]>
		||	<[ \U0001d750 .. \U0001d76e ]>
		||	<[ \U0001d770 .. \U0001d788 ]>
		||	<[ \U0001d78a .. \U0001d7a8 ]>
		||	<[ \U0001d7aa .. \U0001d7c2 ]>
		||	<[ \U0001d7c4 .. \U0001d7cb ]>
		||	<[ \U0001d7ce .. \U0001d7ff ]>
		||	<[ \U00020000 .. \U0002a6d6 ]>
		||	<[ \U0002a700 .. \U0002b734 ]>
		||	<[ \U0002b740 .. \U0002b81d ]>
		||	<[ \U0002f800 .. \U0002fa1d ]>
		||	<[ \U000e0100 .. \U000e01ef ]>
	}

	token XIDSTART {
		||	<[ \x[0041] .. \x[005a] ]>
		||	<[ \x[0061] .. \x[007a] ]>
		||	'\x[00aa]'
		||	'\x[00b5]'
		||	'\x[00ba]'
		||	<[ \x[00c0] .. \x[00d6] ]>
		||	<[ \x[00d8] .. \x[00f6] ]>
		||	<[ \x[00f8] .. \x[01ba] ]>
		||	'\x[01bb]'
		||	<[ \x[01bc] .. \x[01bf] ]>
		||	<[ \x[01c0] .. \x[01c3] ]>
		||	<[ \x[01c4] .. \x[0293] ]>
		||	'\x[0294]'
		||	<[ \x[0295] .. \x[02af] ]>
		||	<[ \x[02b0] .. \x[02c1] ]>
		||	<[ \x[02c6] .. \x[02d1] ]>
		||	<[ \x[02e0] .. \x[02e4] ]>
		||	'\x[02ec]'
		||	'\x[02ee]'
		||	<[ \x[0370] .. \x[0373] ]>
		||	'\x[0374]'
		||	<[ \x[0376] .. \x[0377] ]>
		||	<[ \x[037b] .. \x[037d] ]>
		||	'\x[0386]'
		||	<[ \x[0388] .. \x[038a] ]>
		||	'\x[038c]'
		||	<[ \x[038e] .. \x[03a1] ]>
		||	<[ \x[03a3] .. \x[03f5] ]>
		||	<[ \x[03f7] .. \x[0481] ]>
		||	<[ \x[048a] .. \x[0527] ]>
		||	<[ \x[0531] .. \x[0556] ]>
		||	'\x[0559]'
		||	<[ \x[0561] .. \x[0587] ]>
		||	<[ \x[05d0] .. \x[05ea] ]>
		||	<[ \x[05f0] .. \x[05f2] ]>
		||	<[ \x[0620] .. \x[063f] ]>
		||	'\x[0640]'
		||	<[ \x[0641] .. \x[064a] ]>
		||	<[ \x[066e] .. \x[066f] ]>
		||	<[ \x[0671] .. \x[06d3] ]>
		||	'\x[06d5]'
		||	<[ \x[06e5] .. \x[06e6] ]>
		||	<[ \x[06ee] .. \x[06ef] ]>
		||	<[ \x[06fa] .. \x[06fc] ]>
		||	'\x[06ff]'
		||	'\x[0710]'
		||	<[ \x[0712] .. \x[072f] ]>
		||	<[ \x[074d] .. \x[07a5] ]>
		||	'\x[07b1]'
		||	<[ \x[07ca] .. \x[07ea] ]>
		||	<[ \x[07f4] .. \x[07f5] ]>
		||	'\x[07fa]'
		||	<[ \x[0800] .. \x[0815] ]>
		||	'\x[081a]'
		||	'\x[0824]'
		||	'\x[0828]'
		||	<[ \x[0840] .. \x[0858] ]>
		||	<[ \x[0904] .. \x[0939] ]>
		||	'\x[093d]'
		||	'\x[0950]'
		||	<[ \x[0958] .. \x[0961] ]>
		||	'\x[0971]'
		||	<[ \x[0972] .. \x[0977] ]>
		||	<[ \x[0979] .. \x[097f] ]>
		||	<[ \x[0985] .. \x[098c] ]>
		||	<[ \x[098f] .. \x[0990] ]>
		||	<[ \x[0993] .. \x[09a8] ]>
		||	<[ \x[09aa] .. \x[09b0] ]>
		||	'\x[09b2]'
		||	<[ \x[09b6] .. \x[09b9] ]>
		||	'\x[09bd]'
		||	'\x[09ce]'
		||	<[ \x[09dc] .. \x[09dd] ]>
		||	<[ \x[09df] .. \x[09e1] ]>
		||	<[ \x[09f0] .. \x[09f1] ]>
		||	<[ \x[0a05] .. \x[0a0a] ]>
		||	<[ \x[0a0f] .. \x[0a10] ]>
		||	<[ \x[0a13] .. \x[0a28] ]>
		||	<[ \x[0a2a] .. \x[0a30] ]>
		||	<[ \x[0a32] .. \x[0a33] ]>
		||	<[ \x[0a35] .. \x[0a36] ]>
		||	<[ \x[0a38] .. \x[0a39] ]>
		||	<[ \x[0a59] .. \x[0a5c] ]>
		||	'\x[0a5e]'
		||	<[ \x[0a72] .. \x[0a74] ]>
		||	<[ \x[0a85] .. \x[0a8d] ]>
		||	<[ \x[0a8f] .. \x[0a91] ]>
		||	<[ \x[0a93] .. \x[0aa8] ]>
		||	<[ \x[0aaa] .. \x[0ab0] ]>
		||	<[ \x[0ab2] .. \x[0ab3] ]>
		||	<[ \x[0ab5] .. \x[0ab9] ]>
		||	'\x[0abd]'
		||	'\x[0ad0]'
		||	<[ \x[0ae0] .. \x[0ae1] ]>
		||	<[ \x[0b05] .. \x[0b0c] ]>
		||	<[ \x[0b0f] .. \x[0b10] ]>
		||	<[ \x[0b13] .. \x[0b28] ]>
		||	<[ \x[0b2a] .. \x[0b30] ]>
		||	<[ \x[0b32] .. \x[0b33] ]>
		||	<[ \x[0b35] .. \x[0b39] ]>
		||	'\x[0b3d]'
		||	<[ \x[0b5c] .. \x[0b5d] ]>
		||	<[ \x[0b5f] .. \x[0b61] ]>
		||	'\x[0b71]'
		||	'\x[0b83]'
		||	<[ \x[0b85] .. \x[0b8a] ]>
		||	<[ \x[0b8e] .. \x[0b90] ]>
		||	<[ \x[0b92] .. \x[0b95] ]>
		||	<[ \x[0b99] .. \x[0b9a] ]>
		||	'\x[0b9c]'
		||	<[ \x[0b9e] .. \x[0b9f] ]>
		||	<[ \x[0ba3] .. \x[0ba4] ]>
		||	<[ \x[0ba8] .. \x[0baa] ]>
		||	<[ \x[0bae] .. \x[0bb9] ]>
		||	'\x[0bd0]'
		||	<[ \x[0c05] .. \x[0c0c] ]>
		||	<[ \x[0c0e] .. \x[0c10] ]>
		||	<[ \x[0c12] .. \x[0c28] ]>
		||	<[ \x[0c2a] .. \x[0c33] ]>
		||	<[ \x[0c35] .. \x[0c39] ]>
		||	'\x[0c3d]'
		||	<[ \x[0c58] .. \x[0c59] ]>
		||	<[ \x[0c60] .. \x[0c61] ]>
		||	<[ \x[0c85] .. \x[0c8c] ]>
		||	<[ \x[0c8e] .. \x[0c90] ]>
		||	<[ \x[0c92] .. \x[0ca8] ]>
		||	<[ \x[0caa] .. \x[0cb3] ]>
		||	<[ \x[0cb5] .. \x[0cb9] ]>
		||	'\x[0cbd]'
		||	'\x[0cde]'
		||	<[ \x[0ce0] .. \x[0ce1] ]>
		||	<[ \x[0cf1] .. \x[0cf2] ]>
		||	<[ \x[0d05] .. \x[0d0c] ]>
		||	<[ \x[0d0e] .. \x[0d10] ]>
		||	<[ \x[0d12] .. \x[0d3a] ]>
		||	'\x[0d3d]'
		||	'\x[0d4e]'
		||	<[ \x[0d60] .. \x[0d61] ]>
		||	<[ \x[0d7a] .. \x[0d7f] ]>
		||	<[ \x[0d85] .. \x[0d96] ]>
		||	<[ \x[0d9a] .. \x[0db1] ]>
		||	<[ \x[0db3] .. \x[0dbb] ]>
		||	'\x[0dbd]'
		||	<[ \x[0dc0] .. \x[0dc6] ]>
		||	<[ \x[0e01] .. \x[0e30] ]>
		||	'\x[0e32]'
		||	<[ \x[0e40] .. \x[0e45] ]>
		||	'\x[0e46]'
		||	<[ \x[0e81] .. \x[0e82] ]>
		||	'\x[0e84]'
		||	<[ \x[0e87] .. \x[0e88] ]>
		||	'\x[0e8a]'
		||	'\x[0e8d]'
		||	<[ \x[0e94] .. \x[0e97] ]>
		||	<[ \x[0e99] .. \x[0e9f] ]>
		||	<[ \x[0ea1] .. \x[0ea3] ]>
		||	'\x[0ea5]'
		||	'\x[0ea7]'
		||	<[ \x[0eaa] .. \x[0eab] ]>
		||	<[ \x[0ead] .. \x[0eb0] ]>
		||	'\x[0eb2]'
		||	'\x[0ebd]'
		||	<[ \x[0ec0] .. \x[0ec4] ]>
		||	'\x[0ec6]'
		||	<[ \x[0edc] .. \x[0edd] ]>
		||	'\x[0f00]'
		||	<[ \x[0f40] .. \x[0f47] ]>
		||	<[ \x[0f49] .. \x[0f6c] ]>
		||	<[ \x[0f88] .. \x[0f8c] ]>
		||	<[ \x[1000] .. \x[102a] ]>
		||	'\x[103f]'
		||	<[ \x[1050] .. \x[1055] ]>
		||	<[ \x[105a] .. \x[105d] ]>
		||	'\x[1061]'
		||	<[ \x[1065] .. \x[1066] ]>
		||	<[ \x[106e] .. \x[1070] ]>
		||	<[ \x[1075] .. \x[1081] ]>
		||	'\x[108e]'
		||	<[ \x[10a0] .. \x[10c5] ]>
		||	<[ \x[10d0] .. \x[10fa] ]>
		||	'\x[10fc]'
		||	<[ \x[1100] .. \x[1248] ]>
		||	<[ \x[124a] .. \x[124d] ]>
		||	<[ \x[1250] .. \x[1256] ]>
		||	'\x[1258]'
		||	<[ \x[125a] .. \x[125d] ]>
		||	<[ \x[1260] .. \x[1288] ]>
		||	<[ \x[128a] .. \x[128d] ]>
		||	<[ \x[1290] .. \x[12b0] ]>
		||	<[ \x[12b2] .. \x[12b5] ]>
		||	<[ \x[12b8] .. \x[12be] ]>
		||	'\x[12c0]'
		||	<[ \x[12c2] .. \x[12c5] ]>
		||	<[ \x[12c8] .. \x[12d6] ]>
		||	<[ \x[12d8] .. \x[1310] ]>
		||	<[ \x[1312] .. \x[1315] ]>
		||	<[ \x[1318] .. \x[135a] ]>
		||	<[ \x[1380] .. \x[138f] ]>
		||	<[ \x[13a0] .. \x[13f4] ]>
		||	<[ \x[1401] .. \x[166c] ]>
		||	<[ \x[166f] .. \x[167f] ]>
		||	<[ \x[1681] .. \x[169a] ]>
		||	<[ \x[16a0] .. \x[16ea] ]>
		||	<[ \x[16ee] .. \x[16f0] ]>
		||	<[ \x[1700] .. \x[170c] ]>
		||	<[ \x[170e] .. \x[1711] ]>
		||	<[ \x[1720] .. \x[1731] ]>
		||	<[ \x[1740] .. \x[1751] ]>
		||	<[ \x[1760] .. \x[176c] ]>
		||	<[ \x[176e] .. \x[1770] ]>
		||	<[ \x[1780] .. \x[17b3] ]>
		||	'\x[17d7]'
		||	'\x[17dc]'
		||	<[ \x[1820] .. \x[1842] ]>
		||	'\x[1843]'
		||	<[ \x[1844] .. \x[1877] ]>
		||	<[ \x[1880] .. \x[18a8] ]>
		||	'\x[18aa]'
		||	<[ \x[18b0] .. \x[18f5] ]>
		||	<[ \x[1900] .. \x[191c] ]>
		||	<[ \x[1950] .. \x[196d] ]>
		||	<[ \x[1970] .. \x[1974] ]>
		||	<[ \x[1980] .. \x[19ab] ]>
		||	<[ \x[19c1] .. \x[19c7] ]>
		||	<[ \x[1a00] .. \x[1a16] ]>
		||	<[ \x[1a20] .. \x[1a54] ]>
		||	'\x[1aa7]'
		||	<[ \x[1b05] .. \x[1b33] ]>
		||	<[ \x[1b45] .. \x[1b4b] ]>
		||	<[ \x[1b83] .. \x[1ba0] ]>
		||	<[ \x[1bae] .. \x[1baf] ]>
		||	<[ \x[1bc0] .. \x[1be5] ]>
		||	<[ \x[1c00] .. \x[1c23] ]>
		||	<[ \x[1c4d] .. \x[1c4f] ]>
		||	<[ \x[1c5a] .. \x[1c77] ]>
		||	<[ \x[1c78] .. \x[1c7d] ]>
		||	<[ \x[1ce9] .. \x[1cec] ]>
		||	<[ \x[1cee] .. \x[1cf1] ]>
		||	<[ \x[1d00] .. \x[1d2b] ]>
		||	<[ \x[1d2c] .. \x[1d61] ]>
		||	<[ \x[1d62] .. \x[1d77] ]>
		||	'\x[1d78]'
		||	<[ \x[1d79] .. \x[1d9a] ]>
		||	<[ \x[1d9b] .. \x[1dbf] ]>
		||	<[ \x[1e00] .. \x[1f15] ]>
		||	<[ \x[1f18] .. \x[1f1d] ]>
		||	<[ \x[1f20] .. \x[1f45] ]>
		||	<[ \x[1f48] .. \x[1f4d] ]>
		||	<[ \x[1f50] .. \x[1f57] ]>
		||	'\x[1f59]'
		||	'\x[1f5b]'
		||	'\x[1f5d]'
		||	<[ \x[1f5f] .. \x[1f7d] ]>
		||	<[ \x[1f80] .. \x[1fb4] ]>
		||	<[ \x[1fb6] .. \x[1fbc] ]>
		||	'\x[1fbe]'
		||	<[ \x[1fc2] .. \x[1fc4] ]>
		||	<[ \x[1fc6] .. \x[1fcc] ]>
		||	<[ \x[1fd0] .. \x[1fd3] ]>
		||	<[ \x[1fd6] .. \x[1fdb] ]>
		||	<[ \x[1fe0] .. \x[1fec] ]>
		||	<[ \x[1ff2] .. \x[1ff4] ]>
		||	<[ \x[1ff6] .. \x[1ffc] ]>
		||	'\x[2071]'
		||	'\x[207f]'
		||	<[ \x[2090] .. \x[209c] ]>
		||	'\x[2102]'
		||	'\x[2107]'
		||	<[ \x[210a] .. \x[2113] ]>
		||	'\x[2115]'
		||	'\x[2118]'
		||	<[ \x[2119] .. \x[211d] ]>
		||	'\x[2124]'
		||	'\x[2126]'
		||	'\x[2128]'
		||	<[ \x[212a] .. \x[212d] ]>
		||	'\x[212e]'
		||	<[ \x[212f] .. \x[2134] ]>
		||	<[ \x[2135] .. \x[2138] ]>
		||	'\x[2139]'
		||	<[ \x[213c] .. \x[213f] ]>
		||	<[ \x[2145] .. \x[2149] ]>
		||	'\x[214e]'
		||	<[ \x[2160] .. \x[2182] ]>
		||	<[ \x[2183] .. \x[2184] ]>
		||	<[ \x[2185] .. \x[2188] ]>
		||	<[ \x[2c00] .. \x[2c2e] ]>
		||	<[ \x[2c30] .. \x[2c5e] ]>
		||	<[ \x[2c60] .. \x[2c7c] ]>
		||	'\x[2c7d]'
		||	<[ \x[2c7e] .. \x[2ce4] ]>
		||	<[ \x[2ceb] .. \x[2cee] ]>
		||	<[ \x[2d00] .. \x[2d25] ]>
		||	<[ \x[2d30] .. \x[2d65] ]>
		||	'\x[2d6f]'
		||	<[ \x[2d80] .. \x[2d96] ]>
		||	<[ \x[2da0] .. \x[2da6] ]>
		||	<[ \x[2da8] .. \x[2dae] ]>
		||	<[ \x[2db0] .. \x[2db6] ]>
		||	<[ \x[2db8] .. \x[2dbe] ]>
		||	<[ \x[2dc0] .. \x[2dc6] ]>
		||	<[ \x[2dc8] .. \x[2dce] ]>
		||	<[ \x[2dd0] .. \x[2dd6] ]>
		||	<[ \x[2dd8] .. \x[2dde] ]>
		||	'\x[3005]'
		||	'\x[3006]'
		||	'\x[3007]'
		||	<[ \x[3021] .. \x[3029] ]>
		||	<[ \x[3031] .. \x[3035] ]>
		||	<[ \x[3038] .. \x[303a] ]>
		||	'\x[303b]'
		||	'\x[303c]'
		||	<[ \x[3041] .. \x[3096] ]>
		||	<[ \x[309d] .. \x[309e] ]>
		||	'\x[309f]'
		||	<[ \x[30a1] .. \x[30fa] ]>
		||	<[ \x[30fc] .. \x[30fe] ]>
		||	'\x[30ff]'
		||	<[ \x[3105] .. \x[312d] ]>
		||	<[ \x[3131] .. \x[318e] ]>
		||	<[ \x[31a0] .. \x[31ba] ]>
		||	<[ \x[31f0] .. \x[31ff] ]>
		||	<[ \x[3400] .. \x[4db5] ]>
		||	<[ \x[4e00] .. \x[9fcb] ]>
		||	<[ \x[a000] .. \x[a014] ]>
		||	'\x[a015]'
		||	<[ \x[a016] .. \x[a48c] ]>
		||	<[ \x[a4d0] .. \x[a4f7] ]>
		||	<[ \x[a4f8] .. \x[a4fd] ]>
		||	<[ \x[a500] .. \x[a60b] ]>
		||	'\x[a60c]'
		||	<[ \x[a610] .. \x[a61f] ]>
		||	<[ \x[a62a] .. \x[a62b] ]>
		||	<[ \x[a640] .. \x[a66d] ]>
		||	'\x[a66e]'
		||	'\x[a67f]'
		||	<[ \x[a680] .. \x[a697] ]>
		||	<[ \x[a6a0] .. \x[a6e5] ]>
		||	<[ \x[a6e6] .. \x[a6ef] ]>
		||	<[ \x[a717] .. \x[a71f] ]>
		||	<[ \x[a722] .. \x[a76f] ]>
		||	'\x[a770]'
		||	<[ \x[a771] .. \x[a787] ]>
		||	'\x[a788]'
		||	<[ \x[a78b] .. \x[a78e] ]>
		||	<[ \x[a790] .. \x[a791] ]>
		||	<[ \x[a7a0] .. \x[a7a9] ]>
		||	'\x[a7fa]'
		||	<[ \x[a7fb] .. \x[a801] ]>
		||	<[ \x[a803] .. \x[a805] ]>
		||	<[ \x[a807] .. \x[a80a] ]>
		||	<[ \x[a80c] .. \x[a822] ]>
		||	<[ \x[a840] .. \x[a873] ]>
		||	<[ \x[a882] .. \x[a8b3] ]>
		||	<[ \x[a8f2] .. \x[a8f7] ]>
		||	'\x[a8fb]'
		||	<[ \x[a90a] .. \x[a925] ]>
		||	<[ \x[a930] .. \x[a946] ]>
		||	<[ \x[a960] .. \x[a97c] ]>
		||	<[ \x[a984] .. \x[a9b2] ]>
		||	'\x[a9cf]'
		||	<[ \x[aa00] .. \x[aa28] ]>
		||	<[ \x[aa40] .. \x[aa42] ]>
		||	<[ \x[aa44] .. \x[aa4b] ]>
		||	<[ \x[aa60] .. \x[aa6f] ]>
		||	'\x[aa70]'
		||	<[ \x[aa71] .. \x[aa76] ]>
		||	'\x[aa7a]'
		||	<[ \x[aa80] .. \x[aaaf] ]>
		||	'\x[aab1]'
		||	<[ \x[aab5] .. \x[aab6] ]>
		||	<[ \x[aab9] .. \x[aabd] ]>
		||	'\x[aac0]'
		||	'\x[aac2]'
		||	<[ \x[aadb] .. \x[aadc] ]>
		||	'\x[aadd]'
		||	<[ \x[ab01] .. \x[ab06] ]>
		||	<[ \x[ab09] .. \x[ab0e] ]>
		||	<[ \x[ab11] .. \x[ab16] ]>
		||	<[ \x[ab20] .. \x[ab26] ]>
		||	<[ \x[ab28] .. \x[ab2e] ]>
		||	<[ \x[abc0] .. \x[abe2] ]>
		||	<[ \x[ac00] .. \x[d7a3] ]>
		||	<[ \x[d7b0] .. \x[d7c6] ]>
		||	<[ \x[d7cb] .. \x[d7fb] ]>
		||	<[ \x[f900] .. \x[fa2d] ]>
		||	<[ \x[fa30] .. \x[fa6d] ]>
		||	<[ \x[fa70] .. \x[fad9] ]>
		||	<[ \x[fb00] .. \x[fb06] ]>
		||	<[ \x[fb13] .. \x[fb17] ]>
		||	'\x[fb1d]'
		||	<[ \x[fb1f] .. \x[fb28] ]>
		||	<[ \x[fb2a] .. \x[fb36] ]>
		||	<[ \x[fb38] .. \x[fb3c] ]>
		||	'\x[fb3e]'
		||	<[ \x[fb40] .. \x[fb41] ]>
		||	<[ \x[fb43] .. \x[fb44] ]>
		||	<[ \x[fb46] .. \x[fbb1] ]>
		||	<[ \x[fbd3] .. \x[fc5d] ]>
		||	<[ \x[fc64] .. \x[fd3d] ]>
		||	<[ \x[fd50] .. \x[fd8f] ]>
		||	<[ \x[fd92] .. \x[fdc7] ]>
		||	<[ \x[fdf0] .. \x[fdf9] ]>
		||	'\x[fe71]'
		||	'\x[fe73]'
		||	'\x[fe77]'
		||	'\x[fe79]'
		||	'\x[fe7b]'
		||	'\x[fe7d]'
		||	<[ \x[fe7f] .. \x[fefc] ]>
		||	<[ \x[ff21] .. \x[ff3a] ]>
		||	<[ \x[ff41] .. \x[ff5a] ]>
		||	<[ \x[ff66] .. \x[ff6f] ]>
		||	'\x[ff70]'
		||	<[ \x[ff71] .. \x[ff9d] ]>
		||	<[ \x[ffa0] .. \x[ffbe] ]>
		||	<[ \x[ffc2] .. \x[ffc7] ]>
		||	<[ \x[ffca] .. \x[ffcf] ]>
		||	<[ \x[ffd2] .. \x[ffd7] ]>
		||	<[ \x[ffda] .. \x[ffdc] ]>
		||	<[ \U00010000 .. \U0001000b ]>
		||	<[ \U0001000d .. \U00010026 ]>
		||	<[ \U00010028 .. \U0001003a ]>
		||	<[ \U0001003c .. \U0001003d ]>
		||	<[ \U0001003f .. \U0001004d ]>
		||	<[ \U00010050 .. \U0001005d ]>
		||	<[ \U00010080 .. \U000100fa ]>
		||	<[ \U00010140 .. \U00010174 ]>
		||	<[ \U00010280 .. \U0001029c ]>
		||	<[ \U000102a0 .. \U000102d0 ]>
		||	<[ \U00010300 .. \U0001031e ]>
		||	<[ \U00010330 .. \U00010340 ]>
		||	'\U00010341'
		||	<[ \U00010342 .. \U00010349 ]>
		||	'\U0001034a'
		||	<[ \U00010380 .. \U0001039d ]>
		||	<[ \U000103a0 .. \U000103c3 ]>
		||	<[ \U000103c8 .. \U000103cf ]>
		||	<[ \U000103d1 .. \U000103d5 ]>
		||	<[ \U00010400 .. \U0001044f ]>
		||	<[ \U00010450 .. \U0001049d ]>
		||	<[ \U00010800 .. \U00010805 ]>
		||	'\U00010808'
		||	<[ \U0001080a .. \U00010835 ]>
		||	<[ \U00010837 .. \U00010838 ]>
		||	'\U0001083c'
		||	<[ \U0001083f .. \U00010855 ]>
		||	<[ \U00010900 .. \U00010915 ]>
		||	<[ \U00010920 .. \U00010939 ]>
		||	'\U00010a00'
		||	<[ \U00010a10 .. \U00010a13 ]>
		||	<[ \U00010a15 .. \U00010a17 ]>
		||	<[ \U00010a19 .. \U00010a33 ]>
		||	<[ \U00010a60 .. \U00010a7c ]>
		||	<[ \U00010b00 .. \U00010b35 ]>
		||	<[ \U00010b40 .. \U00010b55 ]>
		||	<[ \U00010b60 .. \U00010b72 ]>
		||	<[ \U00010c00 .. \U00010c48 ]>
		||	<[ \U00011003 .. \U00011037 ]>
		||	<[ \U00011083 .. \U000110af ]>
		||	<[ \U00012000 .. \U0001236e ]>
		||	<[ \U00012400 .. \U00012462 ]>
		||	<[ \U00013000 .. \U0001342e ]>
		||	<[ \U00016800 .. \U00016a38 ]>
		||	<[ \U0001b000 .. \U0001b001 ]>
		||	<[ \U0001d400 .. \U0001d454 ]>
		||	<[ \U0001d456 .. \U0001d49c ]>
		||	<[ \U0001d49e .. \U0001d49f ]>
		||	'\U0001d4a2'
		||	<[ \U0001d4a5 .. \U0001d4a6 ]>
		||	<[ \U0001d4a9 .. \U0001d4ac ]>
		||	<[ \U0001d4ae .. \U0001d4b9 ]>
		||	'\U0001d4bb'
		||	<[ \U0001d4bd .. \U0001d4c3 ]>
		||	<[ \U0001d4c5 .. \U0001d505 ]>
		||	<[ \U0001d507 .. \U0001d50a ]>
		||	<[ \U0001d50d .. \U0001d514 ]>
		||	<[ \U0001d516 .. \U0001d51c ]>
		||	<[ \U0001d51e .. \U0001d539 ]>
		||	<[ \U0001d53b .. \U0001d53e ]>
		||	<[ \U0001d540 .. \U0001d544 ]>
		||	'\U0001d546'
		||	<[ \U0001d54a .. \U0001d550 ]>
		||	<[ \U0001d552 .. \U0001d6a5 ]>
		||	<[ \U0001d6a8 .. \U0001d6c0 ]>
		||	<[ \U0001d6c2 .. \U0001d6da ]>
		||	<[ \U0001d6dc .. \U0001d6fa ]>
		||	<[ \U0001d6fc .. \U0001d714 ]>
		||	<[ \U0001d716 .. \U0001d734 ]>
		||	<[ \U0001d736 .. \U0001d74e ]>
		||	<[ \U0001d750 .. \U0001d76e ]>
		||	<[ \U0001d770 .. \U0001d788 ]>
		||	<[ \U0001d78a .. \U0001d7a8 ]>
		||	<[ \U0001d7aa .. \U0001d7c2 ]>
		||	<[ \U0001d7c4 .. \U0001d7cb ]>
		||	<[ \U00020000 .. \U0002a6d6 ]>
		||	<[ \U0002a700 .. \U0002b734 ]>
		||	<[ \U0002b740 .. \U0002b81d ]>
		||	<[ \U0002f800 .. \U0002fa1d ]>
	}
}
=end comment
