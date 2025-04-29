# frozen_string_literal: true

module RequireLogin
  extend ActiveSupport::Concern

  def require_login
    redirect_to '/facilitators/sign_in' unless current_facilitator
  end
end
