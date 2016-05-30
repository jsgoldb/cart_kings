class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true
  attribute :number, :validate => /\d{3}[\-]\d{3}[\-]\d{4}/

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Contact Form",
      :to => "contact@cartkings.net",
      :from => %("#{name}" <#{email}>)
    }
  end


end