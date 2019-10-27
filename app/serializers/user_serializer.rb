class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :token_expires_at, :access_token, :refresh_token
end
