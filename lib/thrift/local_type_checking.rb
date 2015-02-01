require 'thrift/local_type_checking/version'
require 'thrift'

module Thrift
  module LocalTypeChecking
    def self.extended(*)
      ::Thrift::Struct.extend(ClassMethods)
      ::Thrift::Struct.overwrite_initialize
      ::Thrift::Struct.instance_eval do
        def method_added(name)
          return if name != :initialize
          overwrite_initialize
        end
      end
    end

    module ClassMethods
      def overwrite_initialize
        class_eval do
          unless method_defined?(:custom_initialize)
            define_method(:custom_initialize) do |d={}|
              original_initialize(d)

              unless d.empty?
                d.each do |name, value|
                  unless name_to_id(name.to_s)
                    raise Exception, "Unknown key given to #{self.class}.new: #{name}"
                  end
                  Thrift.check_type(value, struct_fields[name_to_id(name.to_s)], name)
                  instance_variable_set("@#{name}", value)
                end
              end
            end
          end

          if instance_method(:initialize) != instance_method(:custom_initialize)
            alias_method :original_initialize, :initialize
            alias_method :initialize, :custom_initialize
          end
        end
      end
    end
  end
end

