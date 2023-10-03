require 'json'

class User
  attr_reader :id, :first_name, :last_name, :patronymic, :sex, :address, :email, :zip_code, :created_at
  attr_writer :first_name, :last_name, :patronymic, :sex, :address, :email, :zip_code

  def initialize(
    raw_user
  )
    @id = raw_user.fetch(:id, nil)
    @first_name = raw_user.fetch(:first_name)
    @last_name = raw_user.fetch(:last_name)
    @patronymic = raw_user.fetch(:patronymic)
    @sex = raw_user.fetch(:sex, false)
    @address = raw_user.fetch(:address)
    @email = raw_user.fetch(:email)
    @zip_code = raw_user.fetch(:zip_code)
    @created_at = raw_user.fetch(:created_at, Time.now)
  end

  def to_json(options = {})
    {
      id: @id,
      first_name: @first_name,
      last_name: @last_name,
      patronymic: @patronymic,
      sex: @sex,
      address: @address,
      email: @email,
      zip_code: @zip_code,
      created_at: @created_at
    }.to_json
  end
end
