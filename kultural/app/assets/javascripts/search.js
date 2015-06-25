$(document).ready(function() {
  $("#search-field").keyup(function() {
    if ($(this).val() !== '') {
      var url = "/autocomplete.js?search_string=" + $(this).val();
      $.get(url);
    } else {
      $("#autocomplete").slideUp();
    }
  });
  $("#search-field").focusout(function() {
    $("#autocomplete").slideUp();
  });
});
