module Session

    #セッション系統制御を行う。
    extend ActiveSupport::Concern
    def create(user)
        
        MongoidStore::Session.create(user)

    end

    def isavalivale(user)

    end

    def delete()

    end
    


    

end