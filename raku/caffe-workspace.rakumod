
our sub get-caffe-crates {

    ".".IO.dir

    ==> grep({
        $_ ~~ /caffe2*/
    })

    ==> sort()

    ==> grep({
        $_ !~~ /caffe2\-imports/
    })
}
