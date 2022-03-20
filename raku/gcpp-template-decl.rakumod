
# rule template-declaration { 
#   <template> 
#   <less> 
#   <templateparameter-list> 
#   <greater> 
#   <declaration> 
# }
our class TemplateDeclaration { 
    has TemplateParameterList $.templateparameter-list is required;
    has IDeclaration          $.declaration            is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule scoped-template-id { 
#   <nested-name-specifier> 
#   <.template> 
#   <simple-template-id> 
# }
our class ScopedTemplateId { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
