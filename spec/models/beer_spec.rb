require 'spec_helper'

describe Beer do
  
it "with a proper name and style, beer is created and saved" do
    beer = Beer.create name:"Koff", style:"Lager"

 	beer.name.should == "Koff"
 	beer.style.should == "Lager"
    expect(beer.valid?).to be(true)
  end

it "without a proper name, beer is not created and saved" do
    beer = Beer.create  style:"Lager"

   # beer.style.should == "Lager"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
   end

it "without a proper style, beer is not created and saved" do
    beer = Beer.create name:"Koff"
  #  beer.name.should == "Koff"
    expect(beer.valid?).to be(false)
   	expect(Beer.count).to eq(0)
  end

end
