
# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class CartMailerPreview < ActionMailer::Preview
  def quote_email_preview
    CartMailer.quote_email(User.first, Cart.first)
  end
end