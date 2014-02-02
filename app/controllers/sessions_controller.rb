class SessionsController < ApplicationController

def new
	#renderöi kirjautumissivun
end

def create
	#haetaan usernamea vastaava käyttäjä tietokannasta
	user = User.find_by username: params[:username]
	
	if not user.nil? 
		#talletetaan sessioon kirjautuneen käyttäjän id 
		#(jos käyttäjä on olemassa)
		session[:user_id] = user.id 
		#uudelleenohjataan käyttäjä omalle sivulleen
		redirect_to user 

	else
		#jos käyttäjää ei ole olemassa rupea tekemään sitä
		redirect_to signup_path	
	end
end

def destroy
	#nollataan session
	session[:user_id] = nil
	#uudelleenohjataan pääsivulle
	redirect_to :root
end

end
