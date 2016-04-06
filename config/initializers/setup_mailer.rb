ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        =>  'smtp.sendgrid.net',
  :port           =>  '587',
  :authentication =>  :plain,
  :user_name      =>  'insert_username_here',
  :password       =>  'insert_password_here',
  :domain         =>  'heroku.com',
  :enable_starttls_auto => true
}