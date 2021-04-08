module Session

    #セッション系統制御を行う。
    extend ActiveSupport::Concern

    include UserSession

    #セッション作成
    def create(user)
       
        token = generateToken()
        #セッション追加
        UserSession.new(token: token,userid: user)
        #発行したトークンを返却
        return token
    end

    def isavalivale(token)
        UserSession.find_by(token)

    end

    def delete(user)
        UserSession.delete(user)
    end

    def generateToken()
         #トークンをSecureRandomで作成する
         token = SecureRandom.hex(64)
         return token
    end
    


    

end