module Pingable

  class Handler

    def initialize(app)
      @app = app
    end

    def call(env)
      failures = Pingable.run_checks!
      if failures.any?
        [500, HEADERS, failures.map { |f| f[:message] }.join("\n")]
      else
        app_name = env['pingable.name']
        app_name ||= ''
        [200, HEADERS, app_name]
      end
    end

    private

      HEADERS = {'Cache-Control' => 'private'}

  end

end