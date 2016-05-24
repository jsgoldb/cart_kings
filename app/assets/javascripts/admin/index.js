$(function () {
  adminListener();
});

function adminListener(){
  $("#js-part form").on("submit", function(e){
    $.ajax({
      url: this.action,
      dataType: 'script'
    });
    e.preventDefault();
  });
}