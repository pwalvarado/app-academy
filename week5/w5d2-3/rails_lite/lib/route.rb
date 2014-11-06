class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
        @pattern, @http_method, @controller_class, @action_name =
          pattern, http_method, controller_class, action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
      !!(req.path =~ pattern) && req.request_method.downcase.to_sym == http_method
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
        controller = controller_class.new( req, res, route_params(req) )
        controller.invoke_action(action_name)
    end

    def route_params(req)
        route_matchdata = req.path.match(pattern)
        Hash[ route_matchdata.names.zip( route_matchdata.captures ) ]
    end
end