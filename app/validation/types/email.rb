require_relative 'validation_type'
require_relative '../exceptions/type_exception'

class Email < ValidationType
  def initialize(str)
    if validate(str)
      @str = str
    else
      raise TypeException.new(Email, str)
    end
  end

  def validate(email)
    email.to_s =~ /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  end

  def to_s
    @str
  end
end
