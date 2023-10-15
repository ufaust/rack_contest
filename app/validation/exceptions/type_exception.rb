class TypeException < StandardError
  def initialize(excepted_type, given)
    message = "Uncaught TypeException: must be of the type #{excepted_type}, #{given.class} given, value #{given.to_s}"
    super(message)
  end

  def http_status
    500
  end

  def code
    'INTERNAL_SERVER_ERROR'
  end
end
