Pingable
========

Pingable is a simple framework to implement a 'ping' URL in Rack-based web applications.

For example, a Rails or Sinatra app's `config.ru` may look like this (Rack 1.4.0 and later):

    map '/ping' do
      run Pingable::Handler
    end
    run MyApp

Now you can add checks in a modular fashion:

    Pingable.add_check lambda {
      unless check_something
        "Oh noes, something failed"
      end
    }

Checks
------

A check is simply an object which:

* implements `call` with no arguments.
* returns one of the following on error:
  * a string
  * a hash of `{:message => message}`
  * an array of the above
* returns nil on success.

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

Configuration
-------------

To set the name that a successful ping check will return, provide a name in the rackup file:

    map '/ping' do
      use Pingable::Handler, 'my fancy app'
    end
    run MyApp

Ping check
----------

`/ping` is implemented by running all registered checks.

On failure, an HTTP `503` is returned, with the body of the response being a `text/plain` text with each error on separate lines.

On success, a `200 OK` is returned, with either the application's name as the body (if defined), or an empty body.

Common checks
-------------

Pingable comes with a set of checks that are commonly needed for web applications. To install these, add the following:

    Pingable.common_checks!

These include:

* A check to verify ActiveRecord's current connection.
* A check to check the ability for Rails' cache to read and write values.

Common checks for are only installed for dependencies that are discovered automatically. For example, if ActiveRecord has not been `require`d, then the ActiveRecord check is not included.

License
-------

Licensed under the MIT license. See `LICENSE` file.
