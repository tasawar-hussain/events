# frozen_string_literal: true

module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      erorr_message = "Couldn't find #{e.model} with 'id = #{e.id}'"
      json_response({ message:  erorr_message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do |_e|
      json_response({ message: 'Parameters missing: provide atleast one field' }, :unprocessable_entity)
    end
  end
end
