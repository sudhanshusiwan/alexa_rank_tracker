class AlexaRankJob < ApplicationJob

  def perform
    Website.transaction do

      Website.all.each do |website|
        puts website.url
        # website.rankings.create!( alexa_global_rank: website.get_alexa_global_rank )
      end

    end
  end
end