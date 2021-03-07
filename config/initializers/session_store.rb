#Railsのセッションストアを定義
Rails.application.config.session_store :mongoid_store
Rails.application.config.api_only = false
MongoSessionStore.collection_name = "sessions"