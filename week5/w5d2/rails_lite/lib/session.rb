require 'json'
require 'webrick'

class Session
    def initialize(req)
        @session_hash = cookie_to_hash( preexisting_cookie(req) ) || {}
    end

    # find the cookie for this app
    def preexisting_cookie(req)
        req.cookies.find { |cookie| cookie.name == '_rails_lite_app' }
    end

    # deserialize the cookie into a hash
    def cookie_to_hash( cookie )
        cookie.nil? ? nil : JSON.parse( cookie.value )
    end

    # serialize the hash as json, save in a cookie, add to the response
    def store_session(res)
        cookie = WEBrick::Cookie.new('_rails_lite_app', @session_hash.to_json)
        res.cookies << cookie
    end

    def [](key)
        @session_hash[key.to_s]
    end

    def []=(key, val)
        @session_hash[key.to_s] = val
    end
end
