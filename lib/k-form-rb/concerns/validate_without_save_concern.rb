module KFormRb
  module Concerns
    module ValidateWithoutSaveConcern
      extend ActiveSupport::Concern

      included do
        attr_accessor :_prevent_save
        define_attribute :_prevent_save, :bool
        after_save :force_rollback!, if: :_prevent_save
      end

      private

      def force_rollback!
        raise ActiveRecord::Rollback.new("_prevent_save")
      end
    end
  end
end
