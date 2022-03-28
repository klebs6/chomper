use translate-io;

our sub translate-python-ir-to-rust($typename, $item)
{
    given $typename {
        default {
            die "need write method to handle $typename!";
        }
    }
}
