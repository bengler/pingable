require 'pingable'
require 'active_record'

Pingable.common_checks!
Pingable.add_check lambda {
  {:message => "oh noes"}
}

# Earlier Rack versions barf without this
map '/ping' do
  run Pingable::Handler.new('myapp')
end
map '/' do
  run lambda { |env|
    [200, {'Content-Type' => 'text/plain'}, ['OK']]
  }
end