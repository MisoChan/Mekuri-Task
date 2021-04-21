module Authenticate
    extend ActiveSupport::Concern
    #認証系統制御を行う。
    include Session

   
    

    def logIn(user,password)

      MUser.find_by(user_email_address: user)
      
      token = createSession(user,"127.0.0.1")
      session[:token] = token 
      
    end
    

    def updateSession()

    end

    def deleteSession()

    end
end