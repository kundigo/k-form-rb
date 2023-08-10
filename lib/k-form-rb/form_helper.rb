module KFormRb
  module FormHelper
    # There is no easy way to force a custom tag for forms. It would be too much of an hassle to override
    # form_tag_with_body and form_tag_html to support a custom tag and update form_with to call the previous
    # 2 functions with the right arguments.
    #
    # we simply do a low level gsub of ""<form " and "</form>"

    def bs4_vue_form_with(options, &block)
      unless respond_to?(:form_with)
        raise "Your Rails does not implement form_with helper."
      end
      form_tag_name = options.delete(:form_tag_name) || "k-form"

      options[:builder] ||= KFormRb::FormBuilder
      result = if block_given?
                 form_with(**options, &block)
               else
                 form_with(**options)
               end

      if form_tag_name
        result.gsub!("<form ","<#{form_tag_name} " )
        result.gsub!("</form>","</#{form_tag_name}>" )
      end

      result.html_safe
    end


    def vuejs_form_with(
      model:,
      values: nil,
      url: nil,
      validation_url: nil,
      form_wrapper_options: nil,
      return_to: nil,
      **options,
      &block
    )
      # content_wrapper options
      validation_url = validation_url || url
      values = values || { model.singular_name => model.to_builder.attributes! }
      form_wrapper_options = form_wrapper_options || {}
      # form options
      id = options.delete(:id) || (model.persisted? ? "edit_#{model.singular_name}_form_#{model.id}" : "new_#{model.singular_name}_form")
      klass = options.delete(:class) || "form #{model.singular_name}-form"
      content_tag :div,
        data: {
          controller: "vuejs-forms",
          values: values,
          validation_url: validation_url,
          ** form_wrapper_options
        } do

        form =  bs4_vue_form_with(
          model: model,
          id: id,
          class: klass,
          url: url,
          **options
        ) do |form|
          concat(hidden_field_tag :return_to, return_to) if return_to
          concat(block.call(form)) if block_given?
        end

        concat(form)
      end
    end
  end
end
