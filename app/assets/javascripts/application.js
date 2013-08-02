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

function adaptive_page(){
  var head = $('header#hd')
  var content = $('div#conteiner')

  // +260
  var page_w = $("html").width()
  var nav_panel = $('#nav_panel #block')

  if (page_w > 1300){
    // header
    $(head).removeClass('normal')
    $(head).addClass('large')
    $(content).removeClass('normal')
    $(content).addClass('large')
  } else {
    // header
    $(head).removeClass('large')
    $(head).addClass('normal')
    $(content).removeClass('large')
    $(content).addClass('normal')
  }
}

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

  adaptive_page()

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
  adaptive_page()
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
  // AJAX запрос для добавления товара
  $("#add_item_submit").click(function(){
    $("#new_item").ajaxForm(function(data){
      if (data.success) {
        return window.location.replace("/user");
      } else {
        return showErrors(data.errors);
      }
    }).submit();
    return false;
  })

  // comment
  $(document).on('ajax:success','#comment-form', function(s,data,x){
    if(typeof data == 'object'){
      showErrors(data.errors);
    }else{
      $('#comments .comnt_list').html(data);
      $('#comments textarea').val('');
      $('#comment-form #send_comment').fadeOut()

      showNotices(["Комментарий успешно добавлен"]);
    }
  });

  // follow item
  $('#select_collecton span.submit').click(function(e){
    e.preventDefault();

    var collection_id = $('#select_collecton .current').attr('id')
    var id = $('#select_collecton .current').attr('item')
    //var item = $(this).parent('#like').children('span');
    //var id = $(this).prop('id');
    $.post('/item/'+id+'/add/'+collection_id, function(data,status,xhr){
      var ans = data.ans
      $.arcticmodal('close')
    })
    return false;
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

  // форма для добавления товара
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('.image_preview').attr('src', e.target.result);
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#imgInp").change(function(){
    readURL(this);
  });
  // конец формы для добавления товара
  // поставить лайк
  $('section.element #like a').click(function(e){
    e.preventDefault();
    var item = $(this).parent('#like').children('span');
    var id = $(this).prop('id');
    $.post('/item/'+id+'/up', function(data,status,xhr){
      var rating = parseInt(data.item.rating)
      $(item).text(rating);
    })
    return false;
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

  $('#framesite').load( function() {
      var images = $(this.contentDocument).find("img")
      
      var is_dragged;
      var dragged;
      var img_prev = $('img.image_preview')
      var item_url = $('#itemmodal input#item_url')
      var itemmodal = $('#itemmodal')
      var image_inp_by_url = $('#itemmodal input#image_by_url')
      var imgInp = $('#itemmodal input#imgInp')
      
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

          var ifr = $(this);
          var ifr_body = $(this).find('body');
          $(this.contentDocument).mousemove( function(e) {
            if(is_dragged){
              $(dragged).css({"left": e.pageX + $(ifr).offset().left, "top": e.pageY + $(ifr).offset().top});
            }
          });
        }
      });
      
      $(document).mouseup( function(e) {
        var ifr = $('#framesite')

        // если эллемент левее фрэйма
        if(is_dragged && (e.pageX < $(ifr).offset().left)){
          var img_url = $(dragged).attr('src')                        // получаем урл изображения
          var frame_url = $(ifr).get(0).contentWindow.location        // получаем текущий адрес фрэйма
          var cut_url = frame_url.href.split('full_url%5D=')[1];      // 
          var domen = $(ifr).attr('src').split('=')[1].split('/')[0]  // получаем домен из адреса фрэйма
          if (cut_url == undefined) {cut_url = ''};                   // если ещё никуда не переходили текущий адрес пустой

          $(item_url).val('http://'+domen+cut_url)                    // подставляем полный урл товара
          $(image_inp_by_url).val(img_url)                            // подставляем урл картики в инпут
          $(img_prev).attr('src',img_url)                             // подставляем урл картинки
          $(itemmodal).arcticmodal();                                 // запускаем диалог добавления товара
        }
        // удаляем клон эллемента и останавливаем драг
        if (is_dragged) {
          dragged.remove()
          is_dragged = false
        };
        $('#pololo').css('display','none');
      });
    });

});