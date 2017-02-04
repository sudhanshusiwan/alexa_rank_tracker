class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_websites
  has_many :websites, through: :user_websites

  validates :email, :presence => true

  def get_dashboard_data
     Website.get_alexa_ranking_history( self.websites.includes(:rankings) )
  end

  def create_or_update_websites( websites_array )
    websites_array.each do |website|
      website = self.websites.where(url: website[:url]).first_or_initialize
      website.save!

      user_website = self.user_websites.where( user_id: self.id, website_id: website.id ).first_or_initialize
      user_website.save!
    end
  end

end
