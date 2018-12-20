class SessionsController < ApplicationController
	skip_before_action :authenticate_user, only: :create
	#Make sure to skip the authenticate_user before_action when you're creating a session, otherwise you'll end up in an infinite loop of trying to figure out who the user is, which is a very existential bug.



	def create
		resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
			req.params['client_id'] = ENV['DOHRFWJ4ADKXBXEPFGYU0VMZUWX0135GA3GG1EP0Z5JM0HVS']
			req.params['client_secret'] = ENV['UARMZQVBWT1EHSMRGR52U4TZLEYQISFC0SSBGHUYY3FQ0D1X']
	        req.params['grant_type'] = 'authorization_code'
	        req.params['redirect_uri'] = "http://localhost:3000/auth"
             req.params['code'] = params[:code]
         end

         body = JSON.parse(resp.body)
         session[:token] = body["access_token"]
         redirect_to root_path
     end

     def friends
     	resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
     		req.params['oauth_token'] = sessions[:token]
     		 # don't forget that pesky v param for versioning
     		 req.parmas['v'] = '20160201'
     		end
     		@friends = JSON.parse(resp.body)["response"]["friends"]["items"]
     	end
end
