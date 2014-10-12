def super_print(string, options)
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }

  options = defaults.merge(options)
  super_string = string.dup
  super_string.upcase! if options[:upcase]
  super_string.reverse! if options[:reverse]

  options[:times].times do
    puts super_string
  end
end

# string = 'cool string'
# options = {:times => 2, :upcase => true, :reverse => true}
# super_print(string, options)
# p string
# p options

