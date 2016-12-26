begin
  require 'action_mailer'
rescue LoadError
  require 'actionmailer'
end

namespace :deploy do
  namespace :notify do
    desc 'Send a deployment notification via email.'
    task :mail do
      Capistrano::Notifier::Mail.new().perform

      if fetch(:notifier_mail_options)[:method] == :test
        puts ActionMailer::Base.deliveries
      end
    end
  end
end

if fetch(:notifier_mail_options)[:need_notice] == 'y'
  after 'deploy:restart', 'deploy:notify:mail'
end
