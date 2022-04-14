our sub get-api-tag(Bool $api) {
    $api ?? "#[PLUGIN_API]\n" !! ""
}
