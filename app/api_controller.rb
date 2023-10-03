require 'json'
require_relative 'user'

class ApiController

  def initialize(db_connection)
    @db_connection = db_connection
  end

  def help(env)
    [200, { 'content-type' => 'application/json' }, [JSON.generate(
      {
        "/help" => "List of all routes",
        "/user" => "Get user object by ID",
        "/user/new" => "Make new user",
        "/list" => "Get all users in collection"
      }
    )]]
  end

  def user(env)
    params = Rack::Utils.parse_query(env['QUERY_STRING'])
    raw_user = @db_connection[:users][{id: params["id"]}]

    user = User.new(raw_user)

    [200, { 'content-type' => 'application/json' }, [JSON.generate(user)]]
  end

  def new_user(env)
    if env[:REQUEST_METHOD] != 'POST'
      [404, {}, ["Route not exist, send GET to /help to check available routes"]]
    end

    request = Rack::Request.new(env)
    params = JSON.parse(request.body.read).transform_keys(&:to_sym)
    user = User.new(params)

    new_user = @db_connection[:users].insert(
      first_name: user.first_name,
      last_name: user.last_name,
      patronymic: user.patronymic,
      sex: user.sex,
      address: user.address,
      email: user.email,
      zip_code: user.zip_code,
      created_at: user.created_at
    )

    [200, { 'content-type' => 'application/json' }, [JSON.generate({ :result => "true", :user_id => new_user.to_s })]]
  end

  def list(env)
    users_collection = []
    @db_connection[:users].each do |raw_user|
      users_collection.push(User.new(raw_user))
    end

    [200, { 'content-type' => 'application/json' }, [users_collection.to_json]]
  end
end
