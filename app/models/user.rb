class User < ActiveRecord::Base
	validates :first_name, :last_name, :email, :location, presence: true
	validates :email, uniqueness: true
end
