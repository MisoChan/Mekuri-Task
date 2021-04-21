class LoginController < ApplicationController
    
    include Authenticate
    def index
        
    end
    def create
        neko = params[:email_user]
        pass = params[:pass]
        logIn(neko,pass)
    end
end 
