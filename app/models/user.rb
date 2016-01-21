class User < ActiveRecord::Base
  #Associations
  has_many :wikis
  has_many :collaborators, through: :wikis


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	after_initialize :init 
	enum role: [:admin, :standard, :premium]

	def init
		self.role ||= "standard"
	end         
end
