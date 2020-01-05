require "k-form-rb/form_helper"

module KFormRb
  class Railtie < Rails::Railtie
    initializer "k_form_rb.view_form_helper" do
      ActiveSupport.on_load :action_view do
        include KFormRb::FormHelper
      end
    end

    initializer "k_form_rb.errors_helper" do
      ActiveSupport.on_load :active_model do
        module ActiveModel
          class Errors
            prepend KFormRb::Errors::FullMessage
            prepend KFormRb::Errors::ToBuilder
          end
        end
      end
    end

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
