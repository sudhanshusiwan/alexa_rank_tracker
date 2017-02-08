class AlexaRankJob
  include SuckerPunch::Job

  def perform
    puts 'Starting Alexa rank update job'
    Website.transaction do

      Website.all.each do |website|
        puts website.url
        website.rankings.create!( alexa_global_rank: website.get_alexa_global_rank )
      end
    end
    puts 'Finishing Alexa rank update job'

    # enqueue another job in 24 hours to run, there are 86400 seconds in a day
    AlexaRankJob.perform_in(86400)
  end
end