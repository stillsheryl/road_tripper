class User
  attr_reader :email, :api_key
  def initialize(user_info, user_api_key)
    @email = user_info[:email]
    @api_key = user_api_key
  end
end
