var edited_cart_id;

$('.carts.edit').ready(function () {
  addEditCartListeners();
});

function addEditCartListeners(){
  $('form.js-newCart').on('submit', function(event){
    event.preventDefault();
    $.rails.handleRemote( $(this) ).always(function(response){
      location.hash = 1;
      edited_cart_id = response.cart.id;
    }).done(function(){
      var delay = 50;
      setTimeout(function() {
        $.getJSON('/carts/' + edited_cart_id, function(data){
          showThisCart(data.cart);
        });
      }, delay);
    });
  });
}

