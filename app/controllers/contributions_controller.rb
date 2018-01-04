# Allows contributions to a particular project from a supporter
class ContributionsController < ApplicationController
  expose :project, -> { Project.find(params.fetch(:project_id)) }
  expose :contribution

  def new; end

  def create
    self.contribution = Contribution.new(contribution_params)
    contribution.create
    redirect_to root_path
  end

  private def contribution_params
    sanitized_params = params.require(:contribution)
                             .permit(:amount_in_dollars, payment_processor_attributes: :token)
    sanitized_params[:payment_processor_attributes][:stripe_connection] = project.stripe_connection
    sanitized_params
  end
end
