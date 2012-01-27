Pinger
======

Pinger is a simple framework to implement a 'ping' URL in Rack-based web applications.

For example, a Rails or Sinatra app's `config.ru` may look like this:

    map '/ping' do
      use Pingable::Handler
    end
    run MyApp

Now you can add checks in a modular fashion:

    Pingable.add_check lambda {
      unless check_something
        "Oh noes, something failed"
      end
    }

Something a bit more complex:

    class TwitterCheck
      def initialize(url)
        @url = url
      end

      def call
        # ... check the URL ...
      end
    end

    Pingable.add_check TwitterCheck.new(:url => "http://twitter.com/")

A check is simply an object which:

* implements `call` with no arguments.
* returns one of the following on error:
  * a string
  * a hash of {:message => message}
  * an array of the above
* returns nil on success.

Common checks
-------------

Pingable comes with a set of checks that are commonly needed for web applications. To install these, add the following:

    Pingable.common_checks!

These include:

* A check to verify ActiveRecord's current connection.
* A check to check the ability for Rails' cache to read and write values.

License
-------

Licensed under the MIT license. See `LICENSE` file.
