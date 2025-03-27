module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response({ error_key: e.message }, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error_response({ error_key: e.message }, 422)
    end

    rescue_from CanCan::AccessDenied do |e|
      error_response({ error_key: e.message }, 403)
    end
  end
end