class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :authenticate_user!, except: [:index, :show]
  
  rescue_from ActiveRecord::RecordNotFound, with: :no_such_record

  private

  def no_such_record
    render json: {status: 404, message: "No such article"}
  end


end
