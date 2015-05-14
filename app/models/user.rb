class User < ActiveRecord::Base
	validates :name, :last_name, :email, :location, presence: true
end
