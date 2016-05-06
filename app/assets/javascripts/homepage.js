$(function() {
  attachListeners();
});

function attachListeners(){
  $('a.c-warehouse').on("click", function(event){
    event.preventDefault();
    loadCartsIndex();
  });
};

function loadCartsIndex(){
  $.getJSON("/carts.json", function(data) {
    data.carts.forEach(function(cart){
      showCart(cart);
  });
}




//   var current_cart = new Cart(cart.id, cart.comments, cart.price, cart.image_medium)
// });
// function Cart (id, comments, price, image){
//   this.id = id
//   this.comments = comments
//   this.price = price
//   this.image = image
// }

      // $('.container.marketing').prepend(