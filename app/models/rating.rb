class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user

	def to_s
   		"#{beer.name} #{score}"
	#	olut= Beer.find_by id:beer_id
	#	"#{olut.name}  #{score}"
	end

end
