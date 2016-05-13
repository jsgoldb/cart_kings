var newCartId;

$('.carts.new').ready(function () {
  addNewCartListeners();
});

function addNewCartListeners(){
  $('form.js-newCart').on('submit', function(event){
    event.preventDefault();
    $.rails.handleRemote( $(this) ).always(function(response){
      location.hash = 1;
      newCartId = response.cart.id;
    }).always(function(){
      var delay = 50;
      setTimeout(function() {
        //get second cart produced w image (remotipart bug)
        $.getJSON('/carts/' + (parseInt(newCartId, 10) + 1), function(data){
          showThisCart(data.cart);
        });
      }, delay);
    });
  });
}
