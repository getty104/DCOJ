task :test_task => :environment do
    Contest.update_info
    puts 'done.'
end