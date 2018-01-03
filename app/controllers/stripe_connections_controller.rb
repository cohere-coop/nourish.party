# Connects a user to a stripe connection
class StripeConnectionsController < ApplicationController
  before_action :authenticate_registered_user!

  def create; end
end
