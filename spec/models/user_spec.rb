require 'spec_helper'

describe User do
 
  it "has the username set correctly" do
  	user = User.new username: "Pekka"
  	user.username.should == "Pekka"
  	end

  it "has the username set correctly 2" do
    user = User.create username:"Kalle"
  	expect(user.username).to eq("Kalle")
  	end

  it "user is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  	end

  it "password passed to program properly" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
 		user.password.should  == "Secret1"
 		user.password_confirmation.should == "Secret1"
  	end

  it "user with a proper password is saved" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
    end


  it "user with password that is too short but has number is not saved" do
    user = User.create username:"Pekka", password:"S1", password_confirmation:"S1"
 		expect(user.valid?).to be(false)
   	expect(User.count).to eq(0)
  	end

  it "user with password without a number but long enough is not saved" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"
 		expect(user.valid?).to be(false)
   	expect(User.count).to eq(0)
  	end

  it "user with password thats empty is not saved" do
    user = User.create username:"Pekka", password:"", password_confirmation:""
 		expect(user.valid?).to be(false)
   	expect(User.count).to eq(0)
  	end

  it "with a proper password and two ratings, has the correct average rating" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
    rating = Rating.new score:10
    rating2 = Rating.new score:20
    user.ratings << rating
    user.ratings << rating2
    expect(user.ratings.count).to eq(2)
    expect(user.average_rating).to eq(15.0)
    end


  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
      end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20
      user.ratings << rating
      user.ratings << rating2
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
      end
    end

  describe "user orig.test with a proper password is saved" do
    let (:user) {FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
      end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
      end
    end

  describe "favorite_beer1" do
    let (:user){FactoryGirl.create(:user)}

    it "has method for determining the favourite beer" do
      user.should respond_to :favorite_beer
      end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
      end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_beer).to eq(beer)
      end
  
    it "is the one with highest rating if several rated" do
      beer1 = FactoryGirl.create(:beer)
      beer2 = FactoryGirl.create(:beer)
      beer3 = FactoryGirl.create(:beer)
      rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      rating2 = FactoryGirl.create(:rating, score:25,  beer:beer2, user:user)
      rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)
      expect(user.favorite_beer).to eq(beer2)
      end
    end
  
  describe "favorite beer-final" do
      let(:user){FactoryGirl.create(:user) }

      it "has method for determining one" do
        user.should respond_to :favorite_beer
        end

      it "without ratings does not have one" do
        expect(user.favorite_beer).to eq(nil)
        end

      it "is the only rated if only one rating" do
        beer = create_beer_with_rating(10, user)
        expect(user.favorite_beer).to eq(beer)
        end

      it "is the one with highest rating if several rated" do
        create_beers_with_ratings(10, 20, 15, 7, 9, user)
        best = create_beer_with_rating(25, user)
        expect(user.favorite_beer).to eq(best)
        end
  end #describe favorite beer-final
end # describe User 


def create_beers_with_ratings(*scores, user)
    scores.each do |score|
    create_beer_with_rating score, user
    end
end

def create_beer_with_rating(score,  user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
    beer
end  