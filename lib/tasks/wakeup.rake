# rubocop:disable all
namespace :wakeup do
  desc 'wakeup'
  task exec: :environment do
    pp 'Hello world'
  end
end
# rubocop:enable all