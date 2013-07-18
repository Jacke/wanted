$(document).ready ->
  $("#sign_up_form")
    .bind "ajax:success", (e, data, status, xhr) ->
      if data.success
        window.location.replace("/users/edit")
      else
        showErrors(data.errors);

  $("#login_form")
    .bind "ajax:success", (e, data, status, xhr) ->
      if data.success
        window.location.replace("/")
      else
        showErrors(data.errors);

  $("#login_button").click ->
    lf = $('#login_form');
    sf = $('#sign_up_form');
    lf.slideDown();
    sf.slideUp();
  $("#sign_up_button").click ->
    lf = $('#login_form');
    sf = $('#sign_up_form');
    lf.slideUp();
    sf.slideDown();

  $("#edit_pass_button").click ->
    $("#pass_inputs").slideToggle();

