# makes it easy to see what project status change emails will actually look like
# @see http://localhost:3000/rails/mailers/project_status_change_mailer/
class ProjectStatusChangeMailerPreview < ActionMailer::Preview
  def approved
    ProjectStatusChangeMailer.approved(member: RegisteredUser.first || create(:user),
                                       approval: ProjectStatusChange.approved.first ||
                                         create(:project_status_change, :approved))
  end

  def rejected
    ProjectStatusChangeMailer.rejected(member: RegisteredUser.first || create(:user),
                                       rejection: ProjectStatusChange.rejected.first ||
                                         create(:project_status_change, :rejected))
  end
end
