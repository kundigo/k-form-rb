module KFormRb
  module Concerns
    class PotentialValues < Module
      def initialize(field_key, klass_name)
        klass = klass_name.constantize
        puts "define #{field_key}__potential_values"
        define_method "#{field_key}__potential_values" do
          puts "call #{field_key}__potential_values"
          fields = klass.const_defined?(:FIELDS) ? klass.const_get(:FIELDS) : nil
          field = fields[field_key.to_sym] || { }

          result = case field[:type].to_sym
                   when :belongs_to
                     field[:class_name].constantize.where(nil).collect do |instance|
                       {
                           id: instance.id,
                           display_name: instance.try(:display_name) || instance.to_s
                       }
                     end
                   when :enum
                     field[:mapping].collect do | label, value_id|
                       { id: value_id, display_name: label}
                     end

                   else
                     [ ]
                   end

          result
        end
      end
    end
  end
end