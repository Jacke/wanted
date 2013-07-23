$(document).ready(function() {
  $('a').draggable({
    helper: "clone",
    opacity : 0.5,
    zIndex: 100
  });
});