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
