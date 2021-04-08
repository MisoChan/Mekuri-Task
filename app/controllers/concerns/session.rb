module Session

    #セッション系統制御を行う。
    extend ActiveSupport::Concern

    include UserSession

    #セッション作成
    def create(user)
        token = SecureRandom.hex(64)
        UserSession.new(token: token,userid: user)

        return token
    end

    def isavalivale(token)
        UserSession.find_by(token)

    end

    def delete()

    end

    def generateToken()

    end
    


    

end