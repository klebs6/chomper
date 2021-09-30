use block-comment;

our sub reformat-block-comment($text, :$indent = False) {

    my $actions = BlockCommentActions.new( :$indent );

    my $body = BlockComment.parse( $text, :$actions ).made;

}
