module Pingable
  class << self

    @@checks ||= []

    def add_check(check)
      @@checks << check
    end

    def run_checks!
      failures = []
      @@checks.each do |check|
        begin
          result = check.call
        rescue Exception => e
          failures.push(:message => "Pinger check failed: #{e}")
        else
          if result
            case result
              when Array
                failures.concat result
              when String
                failures.push(:message => result)
              else
                failures.push(result)
            end
          end
        end
      end
      failures
    end

  end
end