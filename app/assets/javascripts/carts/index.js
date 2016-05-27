$(function () {
  listenerFunction();
});


function listenerFunction(){
  $('.js-showCart').on('click', function(event){
  event.preventDefault();
  loadCart(event.currentTarget.dataset.id); //access data attribute from DOM
  });
}

function loadCart(cartID){
  $.getJSON('/carts/' + cartID, function(data){
    showThisCart(data.cart);
  });
}

function showThisCart(cart) {
  var newCart = new Cart(cart.id, cart.comments, cart.price, cart.image_medium, cart.parts);
  $('#js-cart').html(newCart.fullCart(newCart));
  //scroll to dynamically rendered element
  if( $('#js-cart').length ) { 
    $('html, body').animate({
      scrollTop: $('#js-cart').offset().top
    }, 'slow');
  }
  location.hash = 1;
}
