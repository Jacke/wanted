$(document).ready ->
    $("#sign_up_form")
      .bind "ajax:success", (e, data, status, xhr) ->
        if data.success
          window.location.replace("/users/edit")
        else
          showErrors(data.errors);