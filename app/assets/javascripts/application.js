// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  var page_w = $("html").width();
  var box = $('#left_group'); // float-fixed block

  if(page_w < 981) {
      box.css('position', 'absolute');
      box.css('top', 0);
  } else {
      box.css('position', 'fixed');
      box.css('top', 85);
  }
});

$(window).resize(function window_resize(){
  var page_w = $("html").width();
  var box = $('#left_group'); // float-fixed block

  if(page_w < 981) {
      box.css('position', 'absolute');
      box.css('top', 0);
  } else {
      box.css('position', 'fixed');
      box.css('top', 85);
  }
});

var showErrors = function(errors){
  var nb = $('.notice-bar');
  nb.removeClass('notice').addClass('error');
  var a = nb.slideDown().delay(10000);
  nb.html('');
  $.each(errors, function(i,msg){
    nb.append('<li>'+msg+'</li>')
  })
  a.slideUp();
}

$("#login_button").click(function(){
  $('#login_form').slideUp();
  $('#sign_up_form').slideDown();
  alert('asdasd');
})
$('#clickme').click(function() {
  $('#login_form').slideDown('slow', function() {
    // Animation complete.
  });
});