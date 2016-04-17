class PhoneValidator < ActiveModel::EachValidator

  def validate_each(user, phone, value)
    value.gsub!(/[\s-]*/, "")
    unless value =~ /\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*/
      user.errors[phone] << (options[:message] || "is not a valid number")
    end
  end

end