var newCartId;

$(function () {
  addNewCartListeners();
});

function addNewCartListeners(){
  $('.js-newCart form').on('submit', function(event){
    var formData = new FormData($('form')[0]);
    event.preventDefault();
    $.ajax({
      url: '/carts',
      type: 'POST',
      data: formData,
      cache: false,
      contentType: false,
      processData: false 
    }).success( function(response){
      location.hash = 1;
      showThisCart(response.cart);
    });
  });
};


