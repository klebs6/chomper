# rule storage-class-specifier:sym<extern> { <.extern> }
our class StorageClassSpecifier::Extern does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<mutable> { <.mutable> }
our class StorageClassSpecifier::Mutable does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<register> { <.register> }
our class StorageClassSpecifier::Register does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<static> { <.static> }
our class StorageClassSpecifier::Static does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<thread_local> { <.thread_local> }
our class StorageClassSpecifier::Thread_local does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
