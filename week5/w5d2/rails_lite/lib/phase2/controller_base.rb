module Phase2
  class ControllerBase
    attr_accessor :req, :res, :already_built_response

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
      @already_built_response = false
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      raise 'already built response' if already_built_response?
      self.res.status = 302
      self.res.header['location'] = url
      self.already_built_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(body, content_type)
      raise 'already built response' if already_built_response?
      self.res.body = body
      self.res.content_type = content_type
      self.already_built_response = true
    end
  end
end
