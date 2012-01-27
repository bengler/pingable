require 'pingable'
require 'active_record'

Pingable.common_checks!
Pingable.add_check lambda {
  {:message => "oh noes"}
}

if true
  # Rack 1.4.0 and later
  map '/ping' do
    use Pingable::Handler, "myapp"
  end
  run lambda { |env|
    [200, {'Content-Type' => 'text/plain'}, ['OK']]
  }
else
  # Earlier Rack versions barf without this
  map '/ping' do
    use Pingable::Handler, "myapp"
    run nil
  end
  map '/' do
    run lambda { |env|
      [200, {'Content-Type' => 'text/plain'}, ['OK']]
    }
  end
end