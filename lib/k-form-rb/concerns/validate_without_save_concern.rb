module KFormRb
  module Concerns
    module ValidateWithoutSaveConcern
      extend ActiveSupport::Concern

      included do
        attr_accessor :_force_rollback
        attribute :_force_rollback, :bool
        after_save :force_rollback!, if: :_force_rollback
      end

      private

      def force_rollback!
        raise ActiveRecord::Rollback.new("_force_rollback")
      end
    end
  end
end
