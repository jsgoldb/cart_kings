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


function CartToShow (id, comments, price, image, parts){
  this.id = id;
  this.comments = comments;
  this.price = price;
  this.image = image;
  this.parts = parts;
  this.renderTheCart = function(cart){
    var cartString = '<div class="text-center">';

    if(gon.admin === 'true'){
      cartString += '<div><a href="/carts/' + cart.id + '/edit">Edit/Delete Cart</a></div>';
    }
    cartString += '<img src="' + cart.image + '" alt="">';

    if (cart.comments){
      cartString += '<h4> ' + cart.comments + ' </h4>';
    };

    if (cart.price){
      cartString += '<h3>Cart Price: $' + cart.price + '0 </h3>';
    };

    if (cart.parts.length > 0){
      cartString += '<div><h2>Parts On This Cart</h2></div>';
    } 

      cart.parts.forEach(function(part){
        cartString += '<div class="col-xs-6 thumbnail">' +
          '<a href="/categories/' + part.category_id + '/parts/' + part.id + '">' + 
            '<img src="' + part.image_medium + '" alt=""></a>' +
          '<h3> ' + part.description + '  </h3></div>';
      });

    cartString += '<div class="col-xs-12">';

      if (gon.admin === 'true'){
        cartString += '<form class="button_to" method="get" action="/carts/' + cart.id + '/addpart"><input class="btn btn-success" type="submit" value="Add Parts To This Cart"></form>';
      }

    cartString += '</div></div>';
    return cartString;
  }
}


function showThisCart(cart) {
  var newCart = new CartToShow(cart.id, cart.comments, cart.price, cart.image_medium, cart.parts);
  $('#js-cart').html(newCart.renderTheCart(newCart));
  //scroll to dynamically rendered element
  if( $('#js-cart').length ) { 
    $('html, body').animate({
      scrollTop: $('#js-cart').offset().top
    }, 'slow');
  }
  location.hash = 1;
}
