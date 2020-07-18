# workaround for making things work in Rails 3 + Ruby 2
# more info: https://github.com/rails/rails/issues/11026#issuecomment-26921562
# TODO: Remove after migrating from Rails 3.

if Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR == 0 && RUBY_VERSION >= "2.0.0"
  module ActiveRecord
    module Associations
      class AssociationProxy
        def send(method, *args)
          if proxy_respond_to?(method, true)
            super
          else
            load_target
            @target.send(method, *args)
          end
        end
      end
    end
  end
end
