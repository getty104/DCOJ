task :test_task => :environment do
    Contest.update_info
    User.update_rate_rank
    puts 'done.'
end
