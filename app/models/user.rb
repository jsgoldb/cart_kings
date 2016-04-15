class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :timeoutable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :carts
  has_one :current_cart, class_name: "Cart"
  validates :phone, phone: true, allow_blank: true
  has_many :orders


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end      
  end



end
