module Session

    #セッション系統制御を行う。
    extend ActiveSupport::Concern



    #セッション作成
    def createSession(user,ip_addr)
       
        token = self.generateToken()
        #セッション追加
        
     
        usersession=UserSession.new(
            token: token,userid: user,ip: ip_addr)

        usersession.save
        #発行したトークンを返却
        return token
    end

    def isSessionExists(token)
        return UserSession.find_by(token) != nil

    end

    def delete(token)
        UserSession.find_by(token).delete(token)
    end

    def generateToken()
         #トークンをSecureRandomで作成する
         token = SecureRandom.hex(64)
         return token
    end
    


    

end