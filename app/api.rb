require_relative 'router'
require_relative 'db_connection'
require_relative 'api_controller'

# Initialize DB
DB = DBConnection.__load('postgres://api_form:api_form@db/api_form')

unless DB.table_exists?(:users)
  DB.create_table :users do
    primary_key :id
    String :first_name, null: false
    String :last_name, null: false
    String :patronymic, null: false
    Boolean :sex, null: false
    String :address, null: false
    String :email, null: false
    Int :zip_code, null: false
    Time :created_at, null: false
  end
end

# initialize controller
api_controller = ApiController.new(DB)
# configure default routes
not_found_handler = ->(env) { [404, {}, ["Route not exist, send GET to /help to check available routes"]] }

# define router
app_router = Router.new

app_router.add_route("/help", api_controller.method(:help))
app_router.add_route('/user', api_controller.method(:user))
app_router.add_route('/user/new', api_controller.method(:new_user))
app_router.add_route('/list', api_controller.method(:list))

app_router.add_not_found_callback(not_found_handler)

APP = app_router.method(:dispatch)