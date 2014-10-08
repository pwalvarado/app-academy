def super_print(string, options = {})
  defaults = {
    :times => 3,
    :upcase => false,
    :reverse => false
  }
  
  options = defaults.merge(options)
  
  string = times(string, options[:times])
  string.upcase! if options[:upcase]
  string.reverse! if options[:reverse]
  
  string
end

def times(string, n)
  string * n
end

# options = {:upcase => true, :reverse => true}
# p super_print("hello", options)
# p options