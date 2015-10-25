class User
  attr_accessor :nom, :email

  def initialize(attributes = {})
    @nom  = attributes[:nom]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@nom} <#{@email}>"
  end
  
  def shuffle_name
    "#{@nom.split('').shuffle.join}"
  end
  
end