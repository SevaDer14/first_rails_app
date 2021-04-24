class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  rescue_from ActiveRecord::RecordNotFound, with: :no_such_record

  private

  def no_such_record
    render json: {status: 404, message: "No such article"}
  end
end
