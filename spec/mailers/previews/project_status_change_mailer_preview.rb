# makes it easy to see what project status change emails will actually look like
# @see http://localhost:3000/rails/mailers/project_status_change_mailer/
class ProjectStatusChangeMailerPreview < ActionMailer::Preview
  def approved
    ProjectStatusChangeMailer.status_change_notification(
      member: RegisteredUser.first || create(:user),
      status_change: ProjectStatusChange.approved.first || create(:project_status_change, :approved)
    )
  end

  def rejected
    ProjectStatusChangeMailer.status_change_notification(
      member: RegisteredUser.first || create(:user),
      status_change: ProjectStatusChange.rejected.first || create(:project_status_change, :rejected)
    )
  end
end
