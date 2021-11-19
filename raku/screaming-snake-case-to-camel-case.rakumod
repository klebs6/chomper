
our sub screaming-snake-case-to-camel-case($in) {
    $in.trim.chomp.split("_")>>.lc>>.tc.join("")
}

