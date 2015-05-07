#initialize multisearch options
PgSearch.multisearch_options = {
  :using => {:tsearch => {prefix: true}}
  #:ignoring => :accents
}
