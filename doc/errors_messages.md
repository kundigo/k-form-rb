# Errors messages

## use of the magic hat  🪄🎩

What is the magic hat? The magic hat is that character `^` that we use in front of error messages and that allows us not to display the name of the field on which we have a validation.

example:

```ruby
class MyModel < ApplicationRecord
# We add a validation on the name field so that it is present provided that true
  validates :name, presence: true, if: :conditional_method

  def conditional_method
    errors.add(:name, "^Here is a specific message for this field") if true
  end
end
```

Here is the difference with the magic hat:
<br />
`Here is a specific message for the field`

and without the magic hat:
<br />
`Name Here is a specific message for the field`


This method of not displaying the field name works on validation errors and warnings and can also be used in locales like the following example:

```yaml
en:
  errors:
    messages:
      name: "^Here is a specific message for this field"
```