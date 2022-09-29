task dispatch_broadcasts: :environment do
    Publication.all.each do |publication|
        publication.publish_current_broadcasts
    end
    puts "dispatched_broadcasts ran at #{Time.now}"
end