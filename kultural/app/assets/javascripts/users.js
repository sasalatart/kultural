//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  var visitedUrls = {};
  $("[data-image-ajax-url]").each(function(key,value){
    var url = $(value).data('image-ajax-url');
    if(visitedUrls[url] === undefined){
      $.get(url);
      visitedUrls[url] = true;
    }
  });
});

