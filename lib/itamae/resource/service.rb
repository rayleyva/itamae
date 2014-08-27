require 'itamae'

module Itamae
  module Resource
    class Service < Base
      define_attribute :action, default: :nothing
      define_attribute :name, type: String, default_name: true

      def pre_action
        case @current_action
        when :start, :restart
          @attributes[:running?] = true
        when :stop
          @attributes[:running?] = false
        when :enable
          @attributes[:enabled?] = true
        when :disable
          @attributes[:enabled?] = false
        end
      end

      def set_current_attributes
        @current_attributes[:running?] = run_specinfra(:check_service_is_running, name)
        @current_attributes[:enabled?] = run_specinfra(:check_service_is_enabled, name)
      end

      def start_action(options)
        run_specinfra(:start_service, name)
      end

      def stop_action(options)
        run_specinfra(:stop_service, name)
      end

      def restart_action(options)
        run_specinfra(:restart_service, name)
      end

      def reload_action(options)
        run_specinfra(:reload_service, name)
      end

      def enable_action(options)
        run_specinfra(:enable_service, name)
      end

      def disable_action(options)
        run_specinfra(:disable_service, name)
      end
    end
  end
end

