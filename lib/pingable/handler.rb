module Pingable

  class Handler

    def initialize(app, name = nil)
      @app = app
      @name = name
    end

    def call(env)
      failures = Pingable.run_checks!
      if failures.any?
        [500, HEADERS, failures.map { |f| f[:message] }.join("\n")]
      else
        [200, HEADERS, @name ||= '']
      end
    end

    private

      HEADERS = {'Cache-Control' => 'private', 'Content-Type': 'text/plain'}

  end

end