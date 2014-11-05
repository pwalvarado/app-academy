require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
        @cookie_hash = preexisting_cookie(req) || {}
    end

    def preexisting_cookie(req)
        cookie = req.cookies.find { |cookie| cookie.name == '_rails_lite_app' }
        JSON.parse(cookie.value) if cookie
    end

    def [](key)
        @cookie_hash[key.to_s]
    end

    def []=(key, val)
        @cookie_hash[key.to_s] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
        cookie = WEBrick::Cookie.new('_rails_lite_app', @cookie_hash.to_json)
        res.cookies << cookie
    end
  end
end
