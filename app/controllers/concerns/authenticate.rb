module Authenticate
    #認証系統制御を行う。

    extend ActiveSupport::Concern
    

    def logIn(){
        session[:user_id]
        
    }
    
    def isSessionExpired(){

    }

    def updateSession(){

    }

    def deleteSession(){

    }
end