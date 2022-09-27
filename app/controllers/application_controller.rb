class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authorize
  
  private

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end

  # def record_not_found(err)
  #   render json: { error: "#{err.model} not found" }, status: :not_found
  # end

  def invalid_record(err)
    render json: { errors: err.record.errors.full_messages }, status: :unprocessable_entity
  end

end
