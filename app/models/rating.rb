class Rating < ActiveRecord::Base
	belongs_to :beer

	def to_s
		olut= Beer.find_by id:beer_id
		"#{olut.name}  #{score}"
	end
end