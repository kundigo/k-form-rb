require "thor"

class Hammer < Thor
  include Thor::Actions
end

namespace :k_form_rb do
  desc "Install KForms in this application"
  task :install do
    Hammer.source_root "#{__dir__}/"

    hammer.insert_into_file 'app/models/application_record.rb', after: "class ApplicationRecord < ActiveRecord::Base\n" do
      <<~MODEL
         include KFormRb::Concerns::ValidateWithoutSaveConcern
       MODEL
    end

    hammer.copy_file "examples/vuejs_forms_controller.js", "app/javascript/controllers/vuejs_forms_controller.js"
    hammer.run "yarn add git+https://kundigo-ci:2381bb4546b420a55d62592192be6e65c201bf06@github.com/kundigo/k-form-js.git#master"
  end

  private

  def hammer
    @hammer ||= Hammer.new
  end
end