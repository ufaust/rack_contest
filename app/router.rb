class Router
  def initialize
    @routes = {}
    @not_found_callback = nil
  end

  def add_route(path, callback)
    @routes[path] = callback
  end

  def add_not_found_callback(callback)
    @not_found_callback = callback
  end

  def dispatch(env)
    path = env['PATH_INFO']

    if @routes.key?(path)
      return @routes[path].call(env)
    else
      if @not_found_callback
        return @not_found_callback.call(env)
      end
    end

    [200, {}, ""]
  end
end