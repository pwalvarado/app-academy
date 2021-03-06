  require 'uri'
require 'byebug'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  #
  # You haven't done routing yet; but assume route params will be
  # passed in as a hash to `Params.new` as below:
  def initialize(req, route_params = {})
    @params = {}
    @params.merge!(route_params)
    @params.merge!(parse_params(req.query_string)) if req.query_string
    @params.merge!(parse_params(req.body)) if req.body
  end

  def [](key)
      @params[key.to_s]
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
  def parse_params(www_encoded_form)
    params = {}

    key_value_pairs = URI::decode_www_form(www_encoded_form)
    key_value_pairs.each do |key_string, value|
      key_set = parse_key(key_string)
      params = additive_merge(params, nested_hash(key_set, value))
    end

    params
  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end

  def nested_hash(key_set, value)
    if key_set.size == 1
      { key_set.first => value }
    else
     { key_set.first => nested_hash( key_set.drop(1), value ) }
    end
  end

  def additive_merge(h1, h2)
    if h1.is_a?(Hash) && h2.is_a?(Hash)
      h1.merge(h2) do |key, value1, value2|
        additive_merge(h1[key], h2[key])
      end
    else
      h2
    end
  end
end
