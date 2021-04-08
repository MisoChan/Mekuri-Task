module Authenticate
    #認証系統制御を行う。
    include Session
    extend ActiveSupport::Concern
    

    def logIn(user,password)
      
    end
    
    
    def isSessionExpired()

    end

    def updateSession()

    end

    def deleteSession()

    end
end