$(function() {
  listingPosition = 1;
  attachListeners();
});

function attachListeners(){
  //delegated click event allows attachment to dynamically generated content
  $(document.body).on("click", 'a.c-warehouse', function(event){
    event.preventDefault();
    event.stopPropagation();
    loadCartsIndex();
  });
};

function loadCartsIndex(){
   var load = $.getJSON("/carts.json", function(data) {
    var threeCarts = loadThreeCarts(listingPosition, data);
    threeCarts.forEach(function(cart){
      var currentCart = new Cart(cart.id, cart.comments, cart.price, cart.image_medium);
      showCart(currentCart);
    });
    if ((threeCarts.length > 0) && ($('.js-more-carts').html() === '')) {
      $('.js-more-carts').append('<a class="btn btn-lg btn-success c-warehouse" id="scroll-stop" href="/carts" role="button">View More Carts</a>');
    };
  });
  listingPosition += 3;
  $('html, body').animate({
    scrollTop: $('#cart-index').offset().top
  }, 'slow');
  location.hash = 1; //preserves back button function
};

function loadThreeCarts(startingIndex, dataJSON){
  return dataJSON.carts.splice(startingIndex, 3);
}

function Cart (id, comments, price, image){
  this.id = id
  this.comments = comments
  this.price = price
  this.image = image

  this.smallCart = function(cart){
    var cartString = '<div class="col-xs-12 col-sm-6 col-md-4 thumbnail ' + 'text-center cart-thumbs">' + 
    '<div class="cart_comments col-xs-12 row text-center">' +
    '</div>' +
    '<img src="' + cart.image + '" alt="' + cart.comments + '" ' +'class=""/><br>' +
    '<form class="button_to" method="get" action="/carts/' + 
    cart.id + '"><input class="btn btn-primary" type="submit" ' +
    'value="View This Cart"></form>' +
  '</div>';
  return cartString;
  };

  this.fullCart = function(cart){
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
  };

}

function showCart(currentCart){
  $('#cart-index').append('Hello There!');
}
       