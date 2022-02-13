
our class TodoBlock {
    has Str $.body is required;
    has Int $.lvl  is required;
}

our class TodoBlock::Actions {

    method TOP($/) {
        make TodoBlock.new(
            body => $<todo-body>.made,
            lvl  => $<todo><todo-level><level>.made // 0,
        )
    }

    method level($/) {
        make $/.Int
    }

    method todo-body($/) {
        make $/.Str
    }
}

our grammar TodoBlock::Grammar {

    token TOP {
        <todo> <.ws> '/*' <todo-body> <.ws> '*/' 
    }

    regex todo-body {
        .* <?before '*/'>
    }

    token todo {
        'todo!(' <todo-level>? ')' ';'
    }

    token level {
        <[0..9]>
    }

    token todo-level {
        \"
        <level>
        \"
    }
}
