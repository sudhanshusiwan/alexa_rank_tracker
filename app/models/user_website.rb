class UserWebsite < ApplicationRecord

  belongs_to :user
  belongs_to :website

  validates :user, :website, :presence => true

  before_commit :website_count_within_bounds

  private

  def website_count_within_bounds
    errors.add("Too many websites for one user!") if user.websites.size >= 3
  end
end