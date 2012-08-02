class BasicObject
  instance_methods.each { |m| undef_method m unless m =~ /^__|instance_eval/ }
end unless defined?(BasicObject)

def parse_parameters_hash(str)
  proc do
    $SAFE = 4
    BasicObject.new.instance_eval(str)
  end.call
end
