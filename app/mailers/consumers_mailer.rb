class ConsumersMailer < ActionMailer::Base
  default from: "Tallysheet <no-reply@lx3afamous02>"
  
  def debt_reminder(consumer)
    @consumer = consumer
    mail(to: @consumer.email, subject: 'Reminder on your tallysheet debt')
  end
  
  def generic(consumer, subject, body)
    @consumer = consumer
    @body = body
    mail(to: @consumer.email, subject: subject)
  end

end
