class CartPart < ActiveRecord::Base
  belongs_to :cart
  belongs_to :part

  attr_reader :part_descriptions

  def part_descriptions=(descriptions)
    descriptions.each do |desc|
      part = Part.find_by(description: desc)
      self.parts << part
    end
  end

end
