class AlertMailer < ActionMailer::Base
  # TODO parameterize default from in a global config
  default :from => "analytics@smithmicro.com"

  def alert_email(user, kpi_results)
    @user = user
    @kpi_results = kpi_results
    mail(:to => user.email,
         :subject => "[analytics] alert - thresholds exceeded")
  end
end
