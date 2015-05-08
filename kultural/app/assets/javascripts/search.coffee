$ ->
  $("#search-field").keyup ->
    url = "/autocomplete.js?search_string=" + $(this).val()
    $.get url
