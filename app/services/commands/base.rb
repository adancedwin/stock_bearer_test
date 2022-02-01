# frozen_string_literal: true

module Commands
  class Base
    private

    def return_success
      { code: '200', message: 'OK' }
    end

    def validate_params(_params)
      raise NoMethodError
    end

    def halt(result)
      # Ideally there are would be many types of exceptions
      raise ValidationError, build_error_message(result)
    end

    def build_error_message(result)
      result.errors.to_h.each_with_object([]) do |(key, error), message|
        message << "#{key} #{error.join(', ')}"
      end.join(', ')
    end

    def humanize_name(name)
      name.split('_').join(' ')
    end
  end
end
