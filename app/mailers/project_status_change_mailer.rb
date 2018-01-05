# Sends emails to notify project team members when their project status has changed
# @see http://localhost:3000/rails/mailers/project_status_change_mailer/
class ProjectStatusChangeMailer < ApplicationMailer
  def approved(member:, approval:)
    mail(to: member.email) do |format|
      format.html { render locals: { approval: approval, member: member } }
      format.text { render locals: { approval: approval, member: member } }
    end
  end

  def rejected(member:, rejection:)
    mail(to: member.email) do |format|
      format.html { render locals: { rejection: rejection, member: member } }
      format.text { render locals: { rejection: rejection, member: member } }
    end
  end
end
