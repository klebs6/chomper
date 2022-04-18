unit module Chomper::Cpp::GcppStorageClass;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package StorageClassSpecifier is export {

    # rule storage-class-specifier:sym<extern> { <.extern> }
    our class Extern does IStorageClassSpecifier { 

        has $.text;

        method name {
            'StorageClassSpecifier::Extern'
        }

        method gist(:$treemark=False) {
            "extern"
        }
    }

    # rule storage-class-specifier:sym<mutable> { <.mutable> }
    our class Mutable does IStorageClassSpecifier { 

        has $.text;

        method name {
            'StorageClassSpecifier::Mutable'
        }

        method gist(:$treemark=False) {
            "mutable"
        }
    }

    # rule storage-class-specifier:sym<register> { <.register> }
    our class Register does IStorageClassSpecifier { 

        has $.text;

        method name {
            'StorageClassSpecifier::Register'
        }

        method gist(:$treemark=False) {
            "register"
        }
    }

    # rule storage-class-specifier:sym<static> { <.static> }
    our class Static does IStorageClassSpecifier { 

        has $.text;

        method name {
            'StorageClassSpecifier::Static'
        }

        method gist(:$treemark=False) {
            "static"
        }
    }

    # rule storage-class-specifier:sym<thread_local> { <.thread_local> }
    our class ThreadLocal does IStorageClassSpecifier { 

        has $.text;

        method name {
            'StorageClassSpecifier::ThreadLocal'
        }

        method gist(:$treemark=False) {
            "thread_local"
        }
    }
}

package StorageClassGrammar is export {

    our role Actions {

        # rule storage-class-specifier:sym<register> { <.register> }
        method storage-class-specifier:sym<register>($/) {
            make StorageClassSpecifier::Register.new
        }

        # rule storage-class-specifier:sym<static> { <.static> }
        method storage-class-specifier:sym<static>($/) {
            make StorageClassSpecifier::Static.new
        }

        # rule storage-class-specifier:sym<thread_local> { <.thread_local> }
        method storage-class-specifier:sym<thread_local>($/) {
            make StorageClassSpecifier::ThreadLocal.new
        }

        # rule storage-class-specifier:sym<extern> { <.extern> }
        method storage-class-specifier:sym<extern>($/) {
            make StorageClassSpecifier::Extern.new
        }

        # rule storage-class-specifier:sym<mutable> { <.mutable> } 
        method storage-class-specifier:sym<mutable>($/) {
            make StorageClassSpecifier::Mutable.new
        }
    }

    our role Rules {

        proto rule storage-class-specifier { * }
        rule storage-class-specifier:sym<register>     { <register>     } 
        rule storage-class-specifier:sym<static>       { <static>       } 
        rule storage-class-specifier:sym<thread_local> { <thread_local> } 
        rule storage-class-specifier:sym<extern>       { <extern>       } 
        rule storage-class-specifier:sym<mutable>      { <mutable>      } 
    }
}
