module Authenticable
  # Devise methods overwrites
  def current_user
    @current_user = User.find_by_token(request.headers['Authorization'])
  end

  private
    def authenticate_user
        render json: { errors: "Not authenticated" },
                    status: :unauthorized unless current_user.present?
    end
end
