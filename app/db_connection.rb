require 'singleton'
require 'sequel'

class DBConnection

  include Singleton
  attr_accessor :connection

  def self.__load(connection_config)
    instance.connection = Sequel.connect(connection_config)
  end
end
