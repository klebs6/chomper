our sub get-api-tag($api) {
    $api ?? "#[PLUGIN_API]\n" !! ""
}
