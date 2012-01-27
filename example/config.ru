require 'pingable'
require 'active_record'

Pingable.common_checks!
Pingable.add_check lambda {
  {:message => "oh noes"}
}

map '/ping' do
  use Pingable::Handler, "myapp"
end
run lambda { |env|
  [200, {'Content-Type' => 'text/plain'}, ['OK']]
}