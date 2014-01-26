class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def to_s
		@@panimo=Brewery.last 	
		@@olut= Beer.last
		"#{panimo.name}  #{olut.brewery.name}"
	end

	def average_rating
		@@b = Beer.first
		@@c = b.ratings.count
		@@s = b.ratings.sum("score")
		puts "#{s/c}"

	end
end
re
