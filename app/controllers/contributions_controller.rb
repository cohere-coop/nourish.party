# Allows contributions to a particular project from a supporter
class ContributionsController < ApplicationController
  expose :project, -> { Project.find(params.fetch(:project_id)) }
  expose :contribution, scope: -> { current_user.contributions }

  def new; end

  def create
    if contribution.process
      flash[:notice] = success_notice
    else
      flash[:alert] = t("contribution.failed")
    end
    redirect_to root_path
  end

  private def success_notice
    t("contribution.succeeded", amount: contribution.amount.format(symbol: true), project:
      project.title, statement_descriptor: project.statement_descriptor)
  end

  private def contribution_params
    sanitized_params = params.require(:contribution)
                             .permit(:amount_in_dollars, payment_processor_attributes: :token)
    sanitized_params[:payment_processor_attributes][:stripe_connection] = project.stripe_connection
    sanitized_params[:project] = project
    sanitized_params
  end
end
