use python3-prelude;

our class Python3::VfpDef  {
    has Python3::Name  $.name is required;
    has Python3::ITest $.test;
}

our class Python3::VarArgsList  {
    has Python3::VfpDef @.basic-args;
    has Python3::VfpDef @.star-args;
    has Python3::VfpDef @.kwargs;
}
