class CartMailer < ApplicationMailer

  def quote_email(user, cart)
    @user = user
    @cart = cart
    mail(to: 'seth@jsgold.co', subject: 'Sample Quote')
  end
  
end
