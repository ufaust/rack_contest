require 'minitest/autorun'
require_relative '../../app/user'
require_relative '../../app/validation/user_validator'
require_relative '../../app/validation/types/email'
require_relative '../../app/validation/types/zip_code'

class UserValidatorTest < Minitest::Test
  def setup
    @validator = UserValidator.new
  end

  def teardown
    @validator = nil
  end

  def test_is_valid
    test_user = User.new({
                           :first_name => 'test_name',
                           :last_name => 'test_lastname',
                           :patronymic => 'test_patronymic',
                           :sex => true,
                           :address => 'test address 22222',
                           :email => 'test@email.com',
                           :zip_code => 333333
                         })
    assert(@validator.is_valid(test_user) == true)
  end

  def test_is_not_valid
    test_if_not_user = {}
    error_not_user = assert_raises(TypeException) { @validator.is_valid(test_if_not_user) }
    assert_equal("Uncaught TypeException: must be of the type User, Hash given, value {}", error_not_user.message)

    test_if_not_string = User.new({
                                    :first_name => 1,
                                    :last_name => 'test_lastname',
                                    :patronymic => 'test_patronymic',
                                    :sex => true,
                                    :address => 'test address 22222',
                                    :email => Email.new('test@email.com'),
                                    :zip_code => ZipCode.new(333333)
                                  })
    error_not_string = assert_raises(TypeException) { @validator.is_valid(test_if_not_string) }
    assert_equal("Uncaught TypeException: must be of the type String, Integer given, value 1", error_not_string.message)

    error_not_zipcode = assert_raises(TypeException) { @validator.is_valid(User.new({
                                                                                      :first_name => 'test_name',
                                                                                      :last_name => 'test_lastname',
                                                                                      :patronymic => 'test_patronymic',
                                                                                      :sex => true,
                                                                                      :address => 'test address 22222',
                                                                                      :email => 'test@email.com',
                                                                                      :zip_code => 333
                                                                                    })) }

    assert_equal("Uncaught TypeException: must be of the type ZipCode, Integer given, value 333", error_not_zipcode.message)

    test_if_not_boolean = User.new({
                                     :first_name => 'test_name',
                                     :last_name => 'test_lastname',
                                     :patronymic => 'test_patronymic',
                                     :sex => 'string',
                                     :address => 'test address 22222',
                                     :email => 'test@email.com',
                                     :zip_code => ZipCode.new(333333)
                                   })

    error_not_boolean = assert_raises(TypeException) { @validator.is_valid(test_if_not_boolean) }
    assert_equal("Uncaught TypeException: must be of the type Boolean, String given, value string", error_not_boolean.message)


    error_not_email = assert_raises(TypeException) { @validator.is_valid(User.new({
                                                                                    :first_name => 'test_name',
                                                                                    :last_name => 'test_lastname',
                                                                                    :patronymic => 'test_patronymic',
                                                                                    :sex => true,
                                                                                    :address => 'test address 22222',
                                                                                    :email => 'testemailcom',
                                                                                    :zip_code => ZipCode.new(333333)
                                                                                  })) }

    assert_equal("Uncaught TypeException: must be of the type Email, String given, value testemailcom", error_not_email.message)
  end
end

