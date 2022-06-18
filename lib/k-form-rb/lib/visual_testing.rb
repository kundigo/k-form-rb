module KFormRb
  module Lib
    module VisualTesting
      extend ::Dry::Configurable
      setting :adapter

      class << self
        def snapshot(*args, **kwargs, &block)
          case config.adapter
          when :percy, 'percy'
            Percy.snapshot(*args, **kwargs, &block)
          when nil, ''
            # no visual testing adapter
          else
            raise "Unknown Visual Testing Adapter #{config.adapter.inspect}"
          end
        end
      end
    end
  end
end