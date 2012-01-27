module Pingable

  class << self
    @@common_checks_added ||= false

    # Add checks for standard gems such as Active Record.
    def common_checks!
      unless @@common_checks_added
        add_active_record!
        add_rails_cache!
        @@common_checks_added = true
      end
    end

    private

      def add_active_record!
        if defined?(ActiveRecord)
          require 'timeout'
          add_check lambda {
            begin
              timeout(10) do
                ActiveRecord::Base.verify_active_connections!
              end
              ActiveRecord::Base.connection.execute('select 1')
              nil
            rescue Timeout::Error
              "ActiveRecord: Timed out"
            rescue Exception => e
              if e.class.name == e.message
                "ActiveRecord: #{e}"
              else
                "ActiveRecord: #{e.class}: #{e.message}"
              end
            end
          }
        end
      end

      def add_rails_cache!
        if defined?(Rails) and Rails.respond_to?(:cache)
          add_check lambda {
            begin
              Rails.cache.read('ping_check')
              Rails.cache.write('ping_check', 'ok')
              nil
            rescue Exception => e
              "Rails cache: #{e.class}: #{e.message}"
            end
          }
        end
      end

  end

end