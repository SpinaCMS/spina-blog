module ControllerHelpers
  def sign_in
    @account = Spina::Account.create name: 'My Website', preferences: { theme: 'default' }
    @user = Spina::User.create name: 'admin', email: 'admin@example.com', password: 'password', admin: true
    request.session[:user_id] = @user.id
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, :type => :controller
end
