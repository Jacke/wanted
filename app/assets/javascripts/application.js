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
//= require jquery.form
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
  var page_h = $(document).height();

  var box = $('#left_group'); // float-fixed block
  var frame = $('iframe#framesite');

  if(page_w < 981) {
      box.css('position', 'absolute');
      box.css('top', 0);
  } else {
      box.css('position', 'fixed');
      box.css('top', 85);
  }

  frame.css('height',page_h-90);

});

var showErrors = function(errors){
  var nb = $('.notice-bar');
  nb.removeClass('notice').addClass('error');
  var a = nb.slideDown().delay(5000);
  nb.html('');
  $.each(errors, function(i,msg){
    nb.append('<li>'+msg+'</li>')
  })
  a.slideUp();
}

$(document).ready(function() {
  /* Checkboxes and radio */
  $(".radio").dgStyle(15);
  $(".checkbox").dgStyle(15);

  var page_h = $(document).height();
  var frame = $('iframe#framesite');
  frame.css('height',page_h-90);

  $("input[checked='checked']").parent('div').attr("style","background-position: 50% -30px; ");

  // смена аватара
  $("#edit_avatar_button").click(function(){
    $("#avatar_input").click();
  })

  $("input#avatar_input").change(function (){
      $("#update_user_avatar_form").ajaxForm({ target: ".avatar" }).submit();
      return false;
  });

  // AJAX запрос для регистрации и авторизации
  $("#sign_up_form").bind("ajax:success", function(e, data, status, xhr) {
    if (data.success) {
      return window.location.replace("/users/edit");
    } else {
      return showErrors(data.errors);
    }
  });
  $("#login_form").bind("ajax:success", function(e, data, status, xhr) {
    if (data.success) {
      return window.location.replace("/");
    } else {
      return showErrors(data.errors);
    }
  });

  // смена форм регистрации и авторизации
  $("#login_button").click(function (){
    var lf = $('#login_form');
    var sf = $('#sign_up_form');
    lf.slideDown();
    sf.slideUp();
  });
  $("#sign_up_button").click(function (){
    var lf = $('#login_form');
    var sf = $('#sign_up_form');
    lf.slideUp();
    sf.slideDown();
  });

  // форма для смены пароля
  $("#edit_pass_button").click(function(){
    $("#pass_inputs").slideToggle();
  });

  //dragg and drop
  $('section.element').draggable({
    helper: "clone",
    opacity : 0.5,
    zIndex: 100
  });

  $('#drug_box').droppable({
        iframeFix: true,
        drop : function(event, ui) {
                var x = ui.draggable.attr('id');
                alert('id:='+x);
        }
  });

  $("#drug_box").hover(function() {
        $(this).data("hovered", true);
    }, function() {
        $(this).data("hovered", false);
    });

  $('#framesite').load( function() {
      var images = $(this.contentDocument).find("img")
      
      var is_dragged;
      var dragged; 
      
      $(images).mousedown( function() {
        dragged = $(this).clone().css("position", "absolute");
        dragged.css({"left": -1000, "top": -1000});
        dragged.css("z-index","1000");
        $(dragged).appendTo($("body"));
        $('#pololo').css('display','block');
        is_dragged = true;
        return false;
      });
      
      $(document).mousemove( function(e) {
        if(is_dragged){
          $(dragged).css({"left": e.pageX, "top": e.pageY});
        }
      });

      var ifr = $(this);
      var ifr_body = $(this).find('body');
      $(this.contentDocument).mousemove( function(e) {
        if(is_dragged){
          $(dragged).css({"left": e.pageX + $(ifr).offset().left, "top": e.pageY + $(ifr).offset().top});
        }
      });
      
      $(document).mouseup( function(e) {
        if ($('#drug_box').data("hovered")) {
          alert(dragged.html);
        }
        else{
          dragged.remove();
        }
        is_dragged = false;
        $('#pololo').css('display','none');
      });
    });

});