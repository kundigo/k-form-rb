module KFormRb
  class FormBuilder < ActionView::Helpers::FormBuilder

    alias_method :original_text_field, :text_field
    alias_method :original_number_field, :number_field
    alias_method :original_text_area, :text_area
    alias_method :original_select, :select
    alias_method :original_date_field, :date_field
    alias_method :original_datetime_field, :datetime_field
    alias_method :original_check_box, :check_box

    def text_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-input ' )
      result.gsub!( '/>', '></k-input>')

      result.html_safe
    end


    def number_field(attribute, options = {})
      result = original_number_field(attribute, options)
      result.gsub!('<input ', '<k-input ' )
      result.gsub!( '/>', '></k-input>')
      result.html_safe
    end

    def text_area(attribute, options = {})
      result = original_text_area(attribute, options)
      result.gsub!('<textarea ', '<k-textarea ' )
      result.gsub!( '/>', '></k-textarea>')

      result.html_safe
    end

    def select(attribute, choices = nil, options = {}, html_options = {}, &block)
      result = original_select(attribute, choices, options, html_options, &block)
      result.gsub!('<select ', '<k-select ' )
      result.gsub!( '/>', '></k-select>')

      result.html_safe
    end

    def date_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-date ' )
      result.gsub!( '/>', '></k-date>')

      result.html_safe
    end

    def datetime_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-datetime ' )
      result.gsub!( '/>', '></k-datetime>')

      result.html_safe
    end

    def check_box(attribute, options = {}, checked_value = "1", unchecked_value = "0")
      result = original_check_box(attribute, options, checked_value, unchecked_value)
      result.gsub!(/<input[^<]*hidden[^<]*\/>/, '') # remove hiden field (it will be created again in vue JS)
      result.gsub!('<input ', '<k-check_box ' )
      result.gsub!( '/>', " unchecked_value=\"#{unchecked_value}\"></k-check_box>")
      result.html_safe
    end
  end
end
