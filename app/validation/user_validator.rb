require_relative 'exceptions/type_exception'

class UserValidator

  USER_TYPES = {
    "first_name" => String,
    "last_name" => String,
    "patronymic" => String,
    "sex" => true,
    "address" => String,
    "email" => String,
    "zip_code" => Integer,
  }

  def is_valid(user_entity)
    unless user_entity.is_a?(User)
      raise TypeException.new("User", user_entity)
    end
    USER_TYPES.each do |variable_name, type|
      if type.is_a?(TrueClass)
        self.validate_boolean(user_entity.send(variable_name))
      elsif !user_entity.send(variable_name).is_a?(type)
        raise TypeException.new(type, user_entity.send(variable_name))
      end
    end

    true
  end

  private def validate_boolean(value)
    case value
    when TrueClass, FalseClass
      true
    else
      raise TypeException.new("Boolean", value)
    end
  end
end
