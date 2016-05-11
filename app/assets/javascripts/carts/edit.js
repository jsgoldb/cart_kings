var edited_cart_id;

$('.carts.edit').ready(function () {
  addListeners();
});

function addListeners(){
  $('form.edit_cart').on('submit', function(event){
    event.preventDefault();
    $.rails.handleRemote( $(this) ).always(function(response){
      location.hash = 1;
      edited_cart_id = response.cart.id;
    }).done(function(){
      var delay = 100;
      setTimeout(function() {
        $.getJSON('/carts/' + edited_cart_id, function(data){
          showThisCart(data.cart);
        });
      }, delay);
    });
  });
}


// function updateCart(cartId){
//   var method = "PATCH";
//   var comments = $('#cart_comments').val();
//   var image = $('#cart_image').val();
//   var price = $('#cart_price').val();
//   var patch = $.ajax({
//     url: '/carts/' + cartId,
//     method: method,
//     data: {cart:
//        {
//         image: image,
//         price: price,
//         comments: comments
//       },
//       id: cartId
//     } 
//   });

//   patch.done(function(response) {
//     showThisCart(response);
//   });

// }


// function showEditedCart(cart) {
//   var editedCart = new CartToShow(cart.id, cart.comments, cart.price, cart.image_medium, cart.parts);
//   $('#cart').html(newCart.renderTheCart)
// }

