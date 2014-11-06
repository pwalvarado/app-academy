require 'json'
require 'webrick'

class Flash
  attr_accessor :current_flash_hash, :next_flash_hash

  def initialize(req)
    @current_flash_hash = cookie_to_hash( flash_cookie(req) ) || {}
    @next_flash_hash = {}
  end

  # find the flash cookie for this app
  def flash_cookie(req)
    req.cookies.find { |cookie| cookie.name == '_rails_lite_app_flash' }
  end

  # deserialize the cookie into a hash
  def cookie_to_hash( cookie )
    cookie.nil? ? nil : JSON.parse( cookie.value )
  end

  # serialize the hash as json, save in a cookie, add to the response
  def store_flash(res)
    clear_flash(res)  
    flash_cookie = WEBrick::Cookie.new(
      '_rails_lite_app_flash', next_flash_hash.to_json
    )
    flash_cookie.path = '/'
    res.cookies << flash_cookie
  end

  def clear_flash(res)
    res.cookies.delete_if { |cookie| cookie.name == '_rails_lite_app_flash' }
  end

  def [](key)
    current_flash_hash[key.to_s]
  end

  def []=(key, val)
    self.next_flash_hash[key.to_s] = val
  end
end