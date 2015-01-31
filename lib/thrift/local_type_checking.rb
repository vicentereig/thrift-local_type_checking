require 'thrift/local_type_checking/version'
require 'thrift'

module Thrift
  module Validator
    def self.extended(base_class)
      byebug
      base_class.send :include, InstanceMethods if base_class.is_a?(Class)
    end

    def validate
      raise 'BOOOM!'
    end
  end

  module LocalTypeChecking
    def self.extended(base_class)
      base_class.send :include, InstanceMethods if base_class.is_a?(Class)
    end

    module InstanceMethods
      def send_message(message_name, args_class, args={})
        args_class.extend(Validator)
        super(message_name, args_class, args)
      end

      def send_oneway_message(message_name, args_class, args={})
        args_class.extend(Validator)
        super(message_name, args_class, args)
      end
    end
  end
end
