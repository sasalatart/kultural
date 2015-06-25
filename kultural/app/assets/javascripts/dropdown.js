$(document).ready(function() {

  $('.dropdown').hover(function(){
    if ($(this).children('ul').is(':hidden')){
      $(this).children('ul').slideDown();
    }
  },
  function() {
    $(this).children('ul').slideUp();
  });
});
