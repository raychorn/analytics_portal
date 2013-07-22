require 'config/boot'
require 'config/environment'

#every(1.minute, 'alert_aggregator_job.send_alert_notifications') { KpiReport.delay.send_alert_notifications }
every(1.day, 'alert_aggregator_job.send_alert_notifications', :at => '00:00') { KpiReport.delay.send_alert_notifications }
