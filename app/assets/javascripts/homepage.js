
$('.application.index').ready(function() {
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
    scrollTop: $('#scroll-stop').offset().top
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

  this.renderCart = function(cart){
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

}

function showCart(currentCart){
  $('#cart-index').append(currentCart.renderCart(currentCart));
}

       