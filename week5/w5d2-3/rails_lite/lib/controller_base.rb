require_relative './session'
require_relative './params'
require_relative './flash'
require 'active_support/core_ext'
require 'erb'
require 'securerandom'

class ControllerBase
  attr_accessor :already_built_response
  attr_reader :req, :res, :params, :flash, :form_authenticity_token

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params ||= Params.new(req, route_params)
    protect_from_csrf_attack
    @flash = Flash.new(req)
    @already_built_response = false
    @form_authenticity_token = SecureRandom.urlsafe_base64(16)
  end

  def protect_from_csrf_attack
    return if req.request_method == 'GET'
    unless (params[:authenticity_token] && session[:authenticity_token] &&
      params[:authenticity_token] == session[:authenticity_token]
    )
      raise 'CSRF attack detected!'
    end
  end

  def already_built_response?
    already_built_response
  end

  def redirect_to(url)
    raise 'already built response' if already_built_response?
    self.res.status = 302
    self.res.header['location'] = url
    self.already_built_response = true
    run_controller_closeout_actions
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(body, content_type)
    raise 'already built response' if already_built_response?
    self.res.body = body
    self.res.content_type = content_type
    self.already_built_response = true
    run_controller_closeout_actions
  end

  def run_controller_closeout_actions
    session[:authenticity_token] = form_authenticity_token
    session.store_session(res)
    flash.store_flash(res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.to_s.underscore
    template_filename = "views/#{controller_name}/#{template_name}.html.erb"
    erb_template = ERB.new(File.read(template_filename))
    render_content(erb_template.result(binding), 'text/html')
  end

  def session
    @session ||= Session.new(req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    send(name)
    render(name) unless already_built_response?
  end
end