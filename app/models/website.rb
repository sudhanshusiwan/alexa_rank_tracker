class Website < ApplicationRecord
  has_many :rankings
  has_many :user_websites
  has_many :users, through: :user_websites

  validates :url, :presence => true
  after_create :create_ranking

  ALEXA_RANK_URL = 'http://www.alexa.com/siteinfo/'

  # Alexa rank is fetched by scraping.
  def get_alexa_global_rank
    html_page = Nokogiri::HTML( open( Website::ALEXA_RANK_URL + self.url ) )

    node_with_global_rank = html_page.css('div.rank-row  .metrics-data').first
    return 0 if node_with_global_rank.blank?

    global_rank_string = node_with_global_rank.children.last.text.strip

    global_rank_string.gsub(',','').to_i
  rescue
    0
  end

  # Returns the alexa rank history of the websites passed as an argument
  #  Output => [ { url: 'site1.com', ranking_history: [ {date: '2016,1,01', rank: 10}, {date: '2016,1,01', rank: 21} ] },
  #              { url: 'site2.com', ranking_history: [ {date: '2016,1,01', rank: 8}, {date: '2016,1,01', rank: 5} ] }]
  def self.get_alexa_ranking_history( websites )
    websites.map do |website|
      ranking_history = website.rankings.map { |ranking| { date: ranking.created_at.strftime('%Y, %m, %d'), rank: ranking.alexa_global_rank } }

      {
        url: website.url,
        ranking_history: ranking_history
      }
    end

  end

  private

  def create_ranking
    self.rankings.create!( alexa_global_rank: self.get_alexa_global_rank )
  end
end