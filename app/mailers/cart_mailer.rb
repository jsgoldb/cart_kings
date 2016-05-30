class CartMailer < ApplicationMailer

  def quote_email(user, cart)
    @user = user
    @cart = cart
    mail(to: 'contact@cartkings.net', subject: 'Quote Request')
  end
  
end
