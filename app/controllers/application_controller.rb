class ApplicationController < ActionController::API

  def render_interaction(
    klass,
    params,
    success: -> int { render json: int.result },
    failure: -> int { render json: {error: int.errors.full_messages.join("\n")}, status: :unprocessable_entity }
  )
    interaction = klass.run(params)
    (interaction.valid? ? success : failure)[interaction]
  end
end
