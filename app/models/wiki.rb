class Wiki < ActiveRecord::Base
  #Associations
  belongs_to :user

  #Validations
  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  #Scopes
  scope :visible_to, -> (user) {user.standard? ? where(private: nil) : all } 
end
