# lib/tasks/whenever_test.rake
desc 'Whenever rake task test'
task whenever_call: :environment do
  Rails.logger.info "Whenever task"
end
