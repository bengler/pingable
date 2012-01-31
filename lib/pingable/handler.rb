module Pingable

  class Handler

    def initialize(name = nil)
      @name = name
    end

    def self.call(env)
      new.call(env)
    end

    def call(env)
      failures = Pingable.run_checks!
      if failures.any?
        [503, HEADERS, [failures.map { |f| f[:message] }.join("\n")]]
      else
        [200, HEADERS, [(@name ||= '').dup]]
      end
    end

    private

      HEADERS = {'Cache-Control' => 'private', 'Content-Type' => 'text/plain'}

  end

end