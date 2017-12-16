# Exposes CRUD actions for party hosting requests
class PartyHostingRequestsController < ApplicationController
  expose :party_hosting_request
  def new; end

  def create
    current_user.party_hosting_requests << party_hosting_request
    if party_hosting_request.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def party_hosting_request_params
    params.require(:party_hosting_request).permit(:title, :activity)
  end
end
