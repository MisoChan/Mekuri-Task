module Authenticate
    #認証系統制御を行う。
    include Session
    extend ActiveSupport::Concern
    

    def logIn(user,password)
      token = Session.create(user)
      session[:token] = token token
      
    end
    

    def updateSession()

    end

    def deleteSession()

    end
end