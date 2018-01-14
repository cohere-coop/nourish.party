# Allows contributions to a particular project from a supporter
class ContributionsController < ApplicationController
  expose :project, -> { Project.find(params.fetch(:project_id)) }

  def new; end
end
