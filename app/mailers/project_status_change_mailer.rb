# Sends emails to notify project team members when their project status has changed
# @see http://localhost:3000/rails/mailers/project_status_change_mailer/
class ProjectStatusChangeMailer < ApplicationMailer
  def status_change_notification(member:, status_change:)
    locals = { status_change: status_change, member: member }
    mail(to: member.email, subject: t("subject", status_change: status_change)) do |format|
      format.html { render locals: locals }
      format.text { render locals: locals }
    end
  end

  helper_method :t
  def t(lookup, options = {})
    status_change = options.delete(:status_change)
    lookup = if status_change.nil?
               lookup
             else
               "project_status_change_mailer.#{status_change.action}.#{lookup}"
             end
    I18n.t(lookup, options)
  end
end
