module Session

    #セッション系統制御を行う。
    extend ActiveSupport::Concern
    def addSession()
        MongoidStore::Session.where();
    end

    

end