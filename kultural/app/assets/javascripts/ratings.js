//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

  var stars = $("#user-rating").data("stars");

  var paintStars = function(index){
    $("#user-rating").children().each(function(key, val){
      if(key <= index){
        $(val).removeClass('fa-star-o');
        $(val).addClass('fa-star');
      }
      else{
        $(val).removeClass('fa-star');
        $(val).addClass('fa-star-o');
      }
    });
  };

  $("#user-rating").children().bind('mouseenter', function(){
    var index = $("#user-rating").children().index(this);
    paintStars(index);
  });

  $("#user-rating").children().bind('mouseleave', function(){
    paintStars(stars - 1);
  });

  $("#user-rating").children().bind('click', function(){
    var index = $("#user-rating").children().index(this);
    stars = index + 1;
    $.ajax({
      method: $("#user-rating").data("method"),
      url: $("#user-rating").data("url"),
      data: { rating: { value: stars } } ,
      dataType: "script"
    });
  });
});