class Wiki < ActiveRecord::Base
  #Associations
  belongs_to :user
  has_many :collaborators
  accepts_nested_attributes_for :collaborators

  #Validations
  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  #Scopes
  scope :visible_to, -> (user) {user.standard? ? where(private: nil) : all } 
end
