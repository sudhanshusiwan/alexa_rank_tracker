class UserWebsite < ApplicationRecord

  belongs_to :user
  belongs_to :website

end