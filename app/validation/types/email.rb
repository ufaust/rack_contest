class Email < ValidationType
  def initialize(str)
    if validate(str)
      @str = str
    else
      raise TypeException.new(Email, str)
    end
  end

  def validate(email)
    email =~ (/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

  def to_s
    @str
  end
end
