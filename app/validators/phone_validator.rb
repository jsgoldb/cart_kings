class PhoneValidator < ActiveModel::EachValidator

  def validate_each(user, phone, value)
    value.gsub!(/[\s-]*/, "")
    unless value =~ /^((\+\d{3,4})?\d{7,8})?$/
      user.errors[phone] << (options[:message] || "is not a valid number")
    end
  end

end