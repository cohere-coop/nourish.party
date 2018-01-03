# Connects a user to a stripe connection
class StripeConnectionsController < ApplicationController
  before_action :authenticate_registered_user!
  expose(:stripe_connections, -> { current_user.stripe_connections })
  expose(:stripe_connection, :find_or_initialize_stripe_connection)

  def create
    if stripe_connection.save
      stripe_connection.update(stripe_connection_params)

      flash[:notice] = t("stripe_connections.connection_successful",
                         stripe_display_name: stripe_connection.display_name)
    else
      flash[:notice] = t("stripe_connections.connection_failed")
    end
    redirect_to action: :index
  end

  def index; end

  private def find_or_initialize_stripe_connection
    stripe_connections.find_or_initialize_by(stripe_account_id: omniauth_data["uid"])
  end

  private def omniauth_data
    request.env["omniauth.auth"]
  end

  private def omniauth_extra_data
    omniauth_data["extra"]["extra_info"]
  end

  private def stripe_connection_params
    { business_name: omniauth_extra_data["business_name"],
      display_name: omniauth_extra_data["display_name"],
      statement_descriptor: omniauth_extra_data["statement_descriptor"] }
  end
end
