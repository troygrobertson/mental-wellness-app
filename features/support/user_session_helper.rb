module UserSessionHelper
  def current_user
    @current_user
  end
  def sign_in(user)
     @current_user=user
   visit signin_path
   fill_in 'Email',with: @current_user.email
   fill_in 'Password', with: "foobar"
   click_button 'Sign in'

   page.should have_css("ul.dropdown-menu > li a", :visible => false, :text => "Sign out")

  end
  def sign_out
    click_link 'Sign out'
  end

end
RSpec.configure do |config|
    config.include UserSessionHelper
end if RSpec.respond_to?(:configure)

World(UserSessionHelper) if respond_to?(:World)
