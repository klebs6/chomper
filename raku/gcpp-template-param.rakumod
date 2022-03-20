# rule templateparameter-list { 
#   <template-parameter> 
#   [ <.comma> <template-parameter> ]* 
# }
our class TemplateParameterList { 
    has ITemplateParameter @.template-parameters is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule template-parameter:sym<type> { <type-parameter> }
our class TemplateParameter::Type does ITemplateParameter {
    has TypeParameter $.type-parameter is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule template-parameter:sym<param> { 
#   <parameter-declaration> 
# }
our class TemplateParameter::Param does ITemplateParameter {
    has ParameterDeclaration $.parameter-declaration is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
