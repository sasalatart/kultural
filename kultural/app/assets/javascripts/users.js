//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

var ajaxImages = {};
var fetchAjaxImages = function(){
  $("[data-image-ajax-url]").each(function(key,value){
    var url = $(value).data('image-ajax-url');
    if(ajaxImages[url] === undefined){
      $.get(url);
      ajaxImages[url] = true;
    }
    else if(ajaxImages[url] !== true){
      $(value).replaceWith(ajaxImages[url]);
    }
  });
};

$(document).ready(fetchAjaxImages);

