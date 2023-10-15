require_relative 'validation_type'
require_relative '../exceptions/type_exception'

class ZipCode < ValidationType
  def initialize(zip_code)
    validate(zip_code) ? @zip_code = zip_code : (raise TypeException.new(ZipCode, zip_code))
  end

  def validate(zip_code)
    zip_code.to_i < 999999 and zip_code.to_i > 100000
  end

  def to_s
    @zip_code.to_s
  end

  def to_i
    @zip_code.to_i
  end
end
