class UsersController < ApplicationController
  def create
    render_interaction(Users::Create, params)
  end

  def authenticate
    render_interaction(Users::Authenticate, params, failure: -> int {
      render json: { error: int.errors.full_messages.join("\n") }, status: :unauthorized })
  end
end