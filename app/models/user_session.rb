class UserSession
  include Mongoid::Document
  include Mongoid::Timestamps
  field :token, type: String
  field :userid, type: String
  field :expire, type: Date
  field :ip, type: String

end
