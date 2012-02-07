module Pingable

  class << self
    @@common_checks_added ||= false

    # Add checks for standard gems such as Active Record, based on
    # what is currently available.
    def common_checks!
      unless @@common_checks_added
        if defined?(ActiveRecord)
          active_record_checks!
        end
        if defined?(Rails) and Rails.respond_to?(:cache)
          rails_cache_checks!
        end
        @@common_checks_added = true
      end
    end

    # Add checks for ActiveRecord.
    def active_record_checks!
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

    # Add Rails cache checks.
    def rails_cache_checks!
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