class Beer < ActiveRecord::Base
 	include RatingAverage
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def to_s
		"#{name} #{brewery.name}"
	end	

#	def to_s (olut:beer)
#	olut = Beer.last
#	olut.panimo_id
#	"#{panimo.name}  #{olut.brewery.name}"
#	end

#	def average_rating (*args)
#	args {|value| sum += value}
#	return (sum / args.count)
#	end

end

