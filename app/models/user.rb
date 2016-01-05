class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	after_initialize :init 
	enum role: [:admin, :standard, :premium]

	def init
		self.role ||= "standard"
	end         
end
