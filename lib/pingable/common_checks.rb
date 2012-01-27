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
          add_check lambda {
            begin
              ActiveRecord::Base.verify_active_connections!
              ActiveRecord::Base.connection.execute('select 1')
              nil
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