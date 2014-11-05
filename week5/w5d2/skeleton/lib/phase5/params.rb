require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
        @params = route_params
        parse_www_encoded_form(req.query_string) if req.query_string
        parse_www_encoded_form(req.body) if req.body
    end

    def [](key)
        @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
        rough_decoding = URI::decode_www_form(www_encoded_form)
        rough_decoding.each do |key, value|
            keys = parse_key(key)
            h = {}
            keys.reverse.each_with_index do |a_key, i|
              if i == 0
                h = Hash[a_key, value]
              else
                h = Hash[a_key, h]
              end
            end
            @params = additive_merge(h, @params)
        end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
        key.split(/\]\[|\[|\]/)
    end

    def additive_merge(h1, h2)
      h1.merge(h2) do |key, value1, value2|
        if h2[key]
          additive_merge(h1[key], h2[key])
        else
          value1
        end
      end
    end
  end
end
