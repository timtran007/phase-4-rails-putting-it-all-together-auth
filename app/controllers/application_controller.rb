class ApplicationController < ActionController::API
  include ActionController::Cookies

  private
  def authorize
    render json: {errors: ["Unauthorized user"]}, status: 401 unless session.include? :user_id
  end
end
