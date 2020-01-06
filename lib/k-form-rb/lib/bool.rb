module KFormRb
  module Lib
    class Bool

      TRUTHIES = [true, 1, '1', 't', 'T', 'true', 'TRUE', 'on', 'ON'].to_set
      FALSIES  = [false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF'].to_set

      def self.to_bool(raw_value)
        if TRUTHIES.include?(raw_value)
          true
        elsif raw_value.nil?
          nil
        elsif raw_value.is_a?(String) && raw_value.blank?
          nil
        else
          false
        end
      end

      def self.true?(raw_value)
        self.to_bool(raw_value)
      end

      def self.false?(raw_value)
        self.to_bool(raw_value) == false
      end

      def self.nil?(raw_value)
        self.to_bool(raw_value).nil?
      end

    end
  end
end