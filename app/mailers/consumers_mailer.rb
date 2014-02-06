class ConsumersMailer < ActionMailer::Base
  default from: "Tallysheet <no-reply@lx3a07>"
  
  def debt_reminder(consumer)
    @consumer = consumer
    mail(to: @consumer.email, subject: 'Reminder on your tallysheet debt')
  end
end
